
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lista_leitura/models/livro_model.dart';
import 'package:flutter_lista_leitura/pages/formulario_livro_page.dart';
import 'package:flutter_lista_leitura/widgets/linha_horizontal.dart';
import 'package:flutter_lista_leitura/widgets/lista_livros.dart';


class ListaLivorsPage extends StatefulWidget {
  const ListaLivorsPage({super.key});

  @override
  State<ListaLivorsPage> createState() => _ListaLivorsPageState();
}

class _ListaLivorsPageState extends State<ListaLivorsPage> {
  Set<LivroModel> meusLivros = {};

  void cadastrarLivro(LivroModel livro) {
    setState(() {
      meusLivros.add(livro);
    });
  }

  void deletarLivro(LivroModel livroModel) {
    setState(() {
      meusLivros.remove(livroModel);
    });
  }

  

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1EF88),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                children: [
                  Padding(
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
                                      onCadastrar: cadastrarLivro,
                                    )));
                          },
                          mini: true,
                          child: const Icon(Icons.add),
                        ),
                      ],
                    ),
                  ),
                  const LinhaHorizontal(),
                  ListaLivros(
                    listalivros: meusLivros,
                    onCadastrar: cadastrarLivro,
                    deletarLivro: deletarLivro,
                  ),
                  if (meusLivros.isNotEmpty) const LinhaHorizontal(),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 40),
                child: SizedBox(
                  height: MediaQuery.of(context)
                      .size
                      .height, // Altura total da tela
                  child: VerticalDivider(
                    color: Colors.red[200],
                    thickness: 3,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
