  // ignore_for_file: non_constant_identifier_names, avoid_types_as_parameter_names

  import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
  import 'package:flutter_lista_leitura/models/livro_model.dart';
import 'package:flutter_lista_leitura/pages/formulario_livro_page.dart';
  import 'package:flutter_lista_leitura/widgets/linha_horizontal.dart';

  class ListaLivros extends StatelessWidget {
    const ListaLivros({required this.listalivros, super.key, required this.onCadastrar, required this.deletarLivro});

    final Set<LivroModel> listalivros; 
    final Function(LivroModel) onCadastrar;
    final Function(LivroModel) deletarLivro;

    @override
    Widget build(BuildContext context) {
      return ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (context, i) {
          final livro = listalivros.elementAtOrNull(i);
          return ListTile(
            onTap: () => Navigator.of(context).push(CupertinoPageRoute(
              builder: (context) => FormularioLivroPage(
                livro: livro, 
                onCadastrar: onCadastrar,
              ),
            )),
            trailing: GestureDetector(
              onTap: () {
                deletarLivro(livro!);
              },
              child: const Icon(Icons.delete)
            ),
            title: Padding(
              padding: const EdgeInsets.only(left: 40),
              child: Text(
              livro!.titulo,
                style: TextStyle(
                  color: livro.lido ? Colors.grey : Colors.black,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  decoration: livro.lido ? TextDecoration.lineThrough : null,
                ),
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(left: 40),
              child: Text(
                livro.descricao!,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  color: livro.lido ? Colors.grey : Colors.black,
                  decoration: livro.lido ? TextDecoration.lineThrough : null,
                ),
                maxLines: 1,
              ),
            ),
            visualDensity: VisualDensity.compact,
          );
        },
        separatorBuilder: (context, i) => const LinhaHorizontal(),
        itemCount: listalivros.length,
      );
    }
  }
