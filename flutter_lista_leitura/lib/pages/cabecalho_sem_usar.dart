import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lista_leitura/models/livro_model.dart';
import 'package:flutter_lista_leitura/pages/formulario_livro_page.dart';

class Cabecalho extends StatefulWidget {
  const Cabecalho({super.key});

  @override
  State<Cabecalho> createState() => _CabecalhoState();
}

class _CabecalhoState extends State<Cabecalho> {
  
  List<LivroModel> meusLivros = [];
  
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 55),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Lista de Leitura... ',
            style: TextStyle(
              color: Color(0xFF498C9A),
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          FloatingActionButton(
            onPressed: () {
              //const FormularioLivroPage();
              //Muda a animação
              // Navigator.of(context).push(MaterialPageRoute(
              //     builder: (context) => const FormularioLivroPage()));
              //Vai pro lado
              Navigator.of(context).push(CupertinoPageRoute(
                  builder: (_) => FormularioLivroPage(
                        onCadastrar: (livro) {
                          setState(() {
                            meusLivros.add(livro);
                          });
                        },
                      )));
            },
            mini: true,
            child: const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
