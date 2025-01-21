
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:flutter_application_2_list/framework/inputs/custom_text_input.dart';
import 'package:flutter_application_2_list/framework/inputs/custom_time_input.dart';
import '/framework/xml.dart';
import 'package:flutter_application_2_list/componentes/theme.dart';


class popuptarefas extends StatefulWidget {
  const popuptarefas({super.key});

  @override
  State<popuptarefas> createState() => _popupTarefasState();
}

class _popupTarefasState extends State<popuptarefas> {


  Xml? xmlPrincipal;
  List<Xml>listaTarefas = [];
  final _selectedListTarefas = HashSet<Xml>();
  final _scrollListTarefas = ScrollController();

   @override
   void initState() {
    super.initState();

    xmlPrincipal = Xml('body', values: {});

    var noLista = Xml("listaTarefas");

    xmlPrincipal?.addNode(noLista);

    var item = Xml("item", values: {
      "@nome": "Acordar",
      "@hora": "07:00",
      "@permite_delete" : "true",
    });
    var item2 = Xml("item", values: {
      "@nome": "Trabalhar",
      "@hora": "09:00",
      "@permite_delete" : "true",
    });

    noLista.addNode(item);
    noLista.addNode(item2);

    listaTarefas = xmlPrincipal!.getNodes("listaTarefas.item").toList();

  }

  Future<void> addItem() async{
    Xml itemNovo = Xml('item', values: {"@permite_delete": "true"});
    Xml? xmlTemp = xmlPrincipal!.getNode("listaTarefas", true);
    setState(() {
      xmlTemp?.addNode(itemNovo);
      listaTarefas = xmlPrincipal!.getNodes("listaTarefas.item");
    });
  }

  Future<void> delItem() async{
    Xml? xmlTemp = xmlPrincipal!.getNode("listaTarefas");
    setState(() {
      for (Xml itemNovo in _selectedListTarefas) {
        xmlTemp!.removeNode(itemNovo);
      }
      listaTarefas = xmlPrincipal!.getNodes("listaTarefas.item");
      _selectedListTarefas.clear();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: TestTheme.primaryColor,
        centerTitle: true,
        title: const Text('Tarefas a fazer'),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        ),
      body:Center(
        child: SizedBox(
          width: 380,
          height: 750,
          child: Column(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Material(
                      color: TestTheme.cabTabela,
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                      elevation: 4,
                      child: Row(
                        children: [
                          Checkbox(
                            splashRadius: 15,
                            value: _selectedListTarefas.isEmpty
                            ? false
                            : _selectedListTarefas.length ==
                                    listaTarefas.where((e) => e["permite_delete"] == "true").toList().length
                                ? true
                                : null,
                            tristate: true,
                            onChanged: (value) {
                              if (_selectedListTarefas.isEmpty &&
                                  listaTarefas.where((e) => e["permite_delete"] == "true").toList().isNotEmpty) {
                                setState(() {
                                  _selectedListTarefas.addAll(listaTarefas.where((e) => e["permite_delete"] == "true"));
                                });
                              } else {
                                setState(() {
                                  _selectedListTarefas.clear();
                                });
                              }
                            },
                          ),
                          const SizedBox(height: 20, child: VerticalDivider(color: Colors.black)),
                          Expanded(
                            flex: 2,
                            child: InkWell(
                              onTap: () {},
                              child: const Text('Tarefa', textAlign: TextAlign.center,),
                            ),
                          ),
                          const SizedBox(height: 20, child: VerticalDivider(color: Colors.black)),
                          Expanded(
                            flex: 1,
                            child: InkWell(
                              onTap: () {},
                              child: const Text('Horario', textAlign: TextAlign.center,),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Material(
                        color: TestTheme.cabTabela,
                        child: Scrollbar(
                          controller: _scrollListTarefas,
                          child: ListView.builder(
                            controller: _scrollListTarefas,
                            itemCount: listaTarefas.length,
                            itemBuilder: (context, index) {
                              final item = listaTarefas[index];
                              return Ink(
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      if (item["permite_delete"] == "true"){
                                        _selectedListTarefas.contains(item) ? _selectedListTarefas.remove(item) : _selectedListTarefas.add(item); 
                                      }
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      item["permite_delete"] == 'true' ?
                                      Checkbox(
                                        splashRadius: 15,
                                        value: _selectedListTarefas.contains(item),
                                        onChanged: (value) {
                                          setState(() {
                                            if (value == true) {
                                              _selectedListTarefas.add(item);
                                            } else {
                                              _selectedListTarefas.remove(item);
                                            }
                                          });
                                        },
                                      ) : const Padding(padding: EdgeInsets.all(5), child: Icon(Icons.block, size: 20)),
                                      const SizedBox(height: 20, child: VerticalDivider(color: Colors.black)),
                                      Expanded(
                                        flex: 2,
                                        child: CustomTextInput(
                                          padding: const EdgeInsets.all(0),
                                          autofocus: true,
                                          controller: TextEditingController(text: item["nome"] ?? ""),
                                          textCapitalization: TextCapitalization.words,
                                          onChanged: (value) {
                                            item["nome"] = value;
                                          },
                                        ),
                                      ),
                                      const SizedBox(height: 20, child: VerticalDivider(color: Colors.black)),
                                      Expanded(
                                        flex: 1,
                                        child: CustomTimeInput(
                                          padding: const EdgeInsets.all(0),
                                          autofocus: true,
                                          controller: TextEditingController(text: item["hora"] ?? ""),
                                          textCapitalization: TextCapitalization.words,
                                          onChanged: (value) {
                                            item["hora"] = value;
                                          },
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ), 
                      ),
                    ),
                    SizedBox(
                      height: 40,
                      child: Material(
                        color: TestTheme.peCabTabela,
                        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(15)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              onPressed: addItem, 
                              icon: const Icon(Icons.add)
                            ),
                            IconButton(
                              onPressed: _selectedListTarefas.isEmpty ? null : delItem, 
                              icon: const Icon(Icons.delete)
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
