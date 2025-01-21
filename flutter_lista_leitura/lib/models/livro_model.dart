
class LivroModel {

  String titulo;
  String? descricao;
  bool lido;
  int id;

  LivroModel({
    required this.titulo,
    this.descricao = '',
    this.lido = false,
    required this.id,
  });

  @override
  bool operator ==(o) => o is LivroModel && id == o.id;
  int get hashCode => super.hashCode;
  

  // @override
  // String toString() {
  //   if (lido == true) {
  //     String estadoLido = 'Sim';
  //     return 'Título do livro é $titulo, sua descrição é $descricao, ja foi lido $estadoLido';
  //   }else {
  //     String estadoLido = 'Não';
  //     return 'Título do livro é $titulo, sua descrição é $descricao, ja foi lido $estadoLido';
  //   }
  // }


}
// Para teste
// final listalivrosMock = [
//   LivroModel(titulo: 'Código Limpo', descricao: 'Ótimo livro'),
//   LivroModel(titulo: 'Programador Pragmatico', descricao: 'Livro bom para iniciantes em programação', lido: true),
//   LivroModel(titulo: 'Entendendo Algoritmos', lido: true)
// ];
