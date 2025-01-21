import 'package:collection/collection.dart';
import 'package:xml/xml.dart';

class Xml {
  final XmlElement _element;

  //Cria um novo XML vazio
  Xml(String name, {Iterable<Xml>? children, String? text, Map<String, String?>? values, Xml? parent})
      : _element = XmlElement(XmlName(name)) {
    if (children != null) {
      addNodes(children);
    }
    if (text != null) {
      setValue(null, text);
    }
    if (values != null) {
      values.forEach((key, value) => setValue(key, value));
    }
    if (parent != null) {
      parent.addNode(this);
    }
  }

  //Cria um novo XML baseado na String de um XML
  Xml.parse(String xmlString) : _element = XmlDocument.parse(xmlString).rootElement;

  //Cria um novo XML baseado em um XmlElement já existente
  Xml._fromElement(this._element);

  String get localName {
    return _element.name.local;
  }

  XmlElement get baseElement {
    return _element;
  }

  Xml? get parent {
    if (_element.parent == null || _element.parent is! XmlElement) {
      return null;
    } else {
      return Xml._fromElement(_element.parent as XmlElement);
    }
  }

  // Implementa comparador pelo _element
  @override
  bool operator ==(other) => other is Xml && other._element == _element;

  // Implementa comparador pelo _element
  @override
  int get hashCode => _element.hashCode;

  // Indica hash do conteúdo (em string)
  int get contentHash => _element.toXmlString().hashCode;

  // Indica se conteúdo (string) de 2 xmls são iguais
  bool contentEquals(Xml other) => other.toXmlString() == _element.toXmlString();

  @override
  String toString() => toXmlString();

  String toXmlString({bool pretty = false, String indent = '  '}) {
    return _element.toXmlString(pretty: pretty, indent: indent);
  }

  List<Xml> getNodes([String path = '*', int limit = 0x00FFFFFF]) {
    var result = <Xml>{};

    //se já acabou o limite, retorna vazio
    if (limit <= 0) {
      return result.toList();
    }

    //pega próxima parte do caminho
    String name;
    String? resto;
    int idx = path.indexOf(".");
    if (idx < 0) {
      name = path; //um único nome
      resto = null;
    } else {
      name = path.substring(0, idx); //primeiro nome
      resto = path.substring(idx + 1);
    }

    //Busca lista diferente dependendo do nome
    Iterable<XmlElement> nodeList;
    if (name.isEmpty) {
      //Vazio significa todos os descendentes (..)
      if (resto != null) {
        //Se tem que filtrar decendentes ainda, considera o pai para buscar filhos imediatos também
        nodeList = [_element, ..._element.descendants.whereType<XmlElement>()];
      } else {
        //Se não tem mais filtros, somente retorna decendentes
        nodeList = _element.descendants.whereType<XmlElement>();
      }
    } else if (name == "*") {
      // "*" significa todos os filhos
      nodeList = _element.children.whereType<XmlElement>();
    } else {
      //Qualquer outra coisa, busca pelo nome
      nodeList = _element.findElements(name);
    }

    //passa por todos os nós encontrados
    for (var node in nodeList) {
      //converte esse element para um Xml
      var xmlNode = Xml._fromElement(node);
      //se tem mais caminho, chama recursivo, senão, só adiciona
      if (resto != null) {
        result.addAll(xmlNode.getNodes(resto, (limit - result.length)));
      } else {
        result.add(xmlNode);
      }
      //se já deu a quantidade necessária, sai
      if (result.length >= limit) {
        return result.toList();
      }
    }

    //retorna o que montou até aqui
    return result.toList();
  }

  Xml? getNode(String path, [bool createIfNotExists = false]) {
    var nodeList = getNodes(path, 1);
    if (nodeList.isNotEmpty) return nodeList.first;
    if (createIfNotExists) {
      // Set value null vai criar o caminho todo mas não colocar valor dentro
      setValue(path, null);
      // Manda buscar novamente
      return getNode(path, false);
    }
    return null;
  }

  List<String> getValues(String path, [int limit = 0x00FFFFFF]) {
    //começa com @ -> direto o valor do atributo
    if (path.startsWith("@")) {
      var atributeVal = _element.getAttribute(path.substring(1));
      return (atributeVal == null) ? [] : [atributeVal];
    }

    //quebra atributo, se houver
    String nodePath;
    String? attributeName;
    int idx = path.indexOf(".@");
    if (idx < 0) {
      //não tem um .@
      //pega o Text de um Element
      nodePath = path;
      attributeName = null;
    } else {
      //pega o Value de um Atributo
      nodePath = path.substring(0, idx);
      attributeName = path.substring(idx + 2);
    }

    // busca nós
    var nodes = getNodes(nodePath, limit);
    if (attributeName == null) {
      // Busca text dos nós encontrados
      return nodes.map((e) => e._element.innerText).toList();
    } else {
      // Busca atributos dos nós encontrados
      var result = <String>[];
      for (var node in nodes) {
        var atributeVal = node._element.getAttribute(attributeName);
        if (atributeVal != null) result.add(atributeVal);
      }
      return result;
    }
  }

  String? getValue([String? path]) {
    //não veio path, pega inner string do nó
    if (path == null) {
      return _element.innerText;
    }

    // Busca valores em lista (max 1)
    var nodeList = getValues(path, 1);
    if (nodeList.isNotEmpty) return nodeList.first;
    return null;
  }

  /// Retorna um atributo do nó atual.
  ///
  /// Retorna `null` se atributo não existe.
  String? operator [](String attribute) => _element.getAttribute(attribute);

// -------------------------- Edição XML -----------------

  void addNode(Xml node, {int? position}) {
    // Remove do pai antigo se tiver um
    node.removeFromParent();
    // Adiciona no pai novo
    if (position == null) {
      _element.children.add(node._element);
    } else {
      _element.children.insert(position, node._element);
    }
  }

  void addNodes(Iterable<Xml> nodeList) {
    nodeList.forEach(addNode);
  }

  void removeNode(Xml node) {
    _element.children.remove(node._element);
  }

  void removeNodes(Iterable<Xml> nodeList) {
    nodeList.forEach(removeNode);
  }

  void removeFromParent() {
    var parent = this.parent;
    parent?.removeNode(this);
  }

  /// Substitui um filho do nó atual por outro nó qualquer
  bool replaceNode(Xml oldChild, Xml newChild) {
    var index = _element.children.indexOf(oldChild._element);
    if (index < 0) return false;

    // remove antigo
    removeNode(oldChild);
    // adiciona novo
    addNode(newChild, position: index);
    // retorna OK
    return true;
  }

  /// Substitui o nó atual por um outro nó no parent
  void replace(Xml other) {
    _element.replace(other._element);
  }

  /// Atribui um valor para um nó de texto ou para um atributo.
  ///
  /// Atribuir valor `null` remove o atributo ou nó de texto.
  void setValue(String? path, String? value) {
    //não veio path, seta inner string do nó
    if (path == null) {
      //Procura filho do tipo Text ou CDATA
      var textNode = _element.children.firstWhereOrNull((node) => node is XmlText || node is XmlCDATA);
      //É pra adicionar ou remover?
      if (value == null) {
        // = Remover
        //se achou o textNode = Apaga
        if (textNode != null) {
          _element.children.remove(textNode);
        }
      } else {
        // = Adicionar
        //se não achou o textNode = Cria
        if (textNode == null) {
          _element.children.add(XmlText(value));
        } else if (textNode is XmlText) {
          textNode.value = value;
        }
      }
      return;
    }

    //começa com @ -> seta atributo
    if (path.startsWith("@")) {
      this[path.substring(1)] = value;
      return;
    }

    //quebra atributo, se houver
    String nodePath;
    String? finalPath;
    int idx = path.indexOf(".@");
    if (idx < 0) {
      //não tem um .@
      //pega o Text de um Element
      nodePath = path;
      finalPath = null; //aplica no Text
    } else {
      //pega o Value de um Atributo
      nodePath = path.substring(0, idx);
      finalPath = path.substring(idx + 1); //aplica no atributo @xxxx
    }

    //navega no caminho
    var pos = this;
    var passos = nodePath.split('.');
    for (var passo in passos) {
      var nextPos = pos.getNode(passo);
      if (nextPos == null) {
        //se não encontrou, cria
        nextPos = Xml(passo);
        pos.addNode(nextPos);
      }
      //avança
      pos = nextPos;
    }

    //agora que chegou lá, aplica o valor
    pos.setValue(finalPath, value);
  }

  /// Atualiza um atributo do nó.
  ///
  /// Atribuir valor `null` remove o atributo.
  void operator []=(String attribute, String? value) {
    _element.setAttribute(attribute, value);
  }

  /// Retorna uma cópia do nó
  Xml copy({String? newName}) {
    if (newName == null) {
      return Xml._fromElement(_element.copy());
    }
    var xml = Xml(newName);
    copyAttributes(this, xml);
    getNodes().forEach((e) => xml.addNode(e.copy()));
    return xml;
  }

  /// Copia os atributos de um nó para outro
  static void copyAttributes(Xml from, Xml to) {
    for (var attr in from.baseElement.attributes) {
      to[attr.localName] = attr.value;
    }
  }
}
