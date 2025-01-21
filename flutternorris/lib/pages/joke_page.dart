import 'package:flutter/material.dart';
import 'package:flutternorris/models/jokemodel.dart';
import 'package:flutternorris/repositories/joke_repository.dart';

class JokePage extends StatefulWidget {
  const JokePage(this.j, this.categories, {super.key});

  final String categories;
  final JokeModel j;

  @override
  State<JokePage> createState() => _JokePageState();
}

class _JokePageState extends State<JokePage> {
  final jokeRepository = JokeRepository();
  bool isLoading = false;
  bool hasError = false;
  late JokeModel joke;

  @override
  void initState() {
    super.initState();
    joke = widget.j;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 101, 46),
        title: Text("Categoria escolhida: ${widget.categories}"),
      ),
      body:  SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 25,),
            const Hero(
              tag: 'chuck',
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/chuck.png'),
                radius: 100,
              ),
            ),
            const SizedBox(height: 25,),
            getContent(joke.value ?? "Erro ao carregar a piada...", isLoading, hasError),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          setState(() {
            isLoading = true;
          });
          try {
            joke = await jokeRepository.getJokeByCategory(widget.categories);
            setState(() {
              isLoading = false;
            });
          } on Exception {
            setState(() {
              isLoading = false;
              hasError = true;
            }); 
          }
        },
        child: const Icon(Icons.repeat_one),
      ),
    );
  }

  Widget getContent(String valor, bool isLoading, bool hasError) {
    if (hasError) {
      return const Text('Erro na busca da piada...');
    }
    if (isLoading) {
      return const CircularProgressIndicator();
    }
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Text(
        valor,
        style: const TextStyle(
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

}