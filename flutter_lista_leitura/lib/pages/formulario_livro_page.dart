import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_lista_leitura/models/livro_model.dart';

class FormularioLivroPage extends StatefulWidget {
  final Function(LivroModel) onCadastrar;
  final LivroModel? livro;
  const FormularioLivroPage({super.key, required this.onCadastrar, this.livro});

  @override
  State<FormularioLivroPage> createState() => _FormularioLivroPageState();
}

class _FormularioLivroPageState extends State<FormularioLivroPage> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late LivroModel livro;

  @override
  void initState() {
    livro = widget.livro ?? LivroModel(
      titulo: '',
      id: Random().nextInt(255),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1EF88),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(0, 255, 193, 7),

      ),
      body: Form( 
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Inclua seu novo livro',
                  style: TextStyle(
                    color: Color(0xFF498C9A),
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 100),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(
                    flex: 1,
                  ),
                  Expanded(
                      flex: 9,
                      child: TextFormField(
                        initialValue: livro.titulo,
                        decoration: const InputDecoration(
                          hintText: 'Título do Livro',
                          hintStyle: TextStyle(
                              color: Colors.black,
                              fontSize: 26,
                              fontWeight: FontWeight.bold),
                        ),
                        onSaved: (titulo) => livro.titulo = titulo!,
                        validator: (titulo) => titulo!.isEmpty ? 'Título é obrigatório!' : null,
                      )),
                  const Spacer(
                    flex: 1,
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(
                  flex: 1,
                ),
                Expanded(
                    flex: 9,
                    child: TextFormField(
                      initialValue: livro.descricao,
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                      decoration: const InputDecoration(
                        hintText: 'Descrição do Livro',
                        hintStyle: TextStyle(
                          color: Colors.black,
                          fontSize: 26,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      onSaved: (descricao) => livro.descricao = descricao,
                    )),
                const Spacer(
                  flex: 1,
                ),
              ],
            ),
            const Spacer(),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Já leu esse livro'),
                  Checkbox(
                    value: livro.lido,
                    onChanged: (valor) {
                      setState(() {
                        livro.lido = valor ?? false;
                      }); 
                    },
                  ),
                ],
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: ElevatedButton(
                    onPressed: () {
                      final form = _formKey.currentState;
                      if (form!.validate()) {
                        form.save();
                        widget.onCadastrar(livro);
                        Navigator.of(context).pop();
                      }else {
                        return;
                      }

                    },
                    style: ButtonStyle(
                      backgroundColor:WidgetStateProperty.resolveWith(
                        (states) => const Color(0xFFE67F22)
                      ),
                    ),
                    child: const Text(
                      "Cadastrar",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 35,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Spacer()
          ],
        ),
      ),
    );
  }
}
