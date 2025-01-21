import 'package:flutter/material.dart';
import 'package:flutternorris/pages/joke_page.dart';
import 'package:flutternorris/repositories/joke_repository.dart';

class CategoriesPages extends StatefulWidget {
  const CategoriesPages({super.key});

  @override
  State<CategoriesPages> createState() => _CategoriesPagesState();
}

class _CategoriesPagesState extends State<CategoriesPages> {
  final jokeRepository = JokeRepository();

  late Future<List<String>> futureCategories;
  // List<String> categories = [];

  @override
  void initState() {
    super.initState();
    futureCategories = jokeRepository.getCategories();
    // jokeRepository.getCategories().then((value) => setState(() {
    //   categories = value;
    // }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // body: categories.isNotEmpty ? ListView.separated(
      //   itemBuilder: (_, i) => ListTile(
      //     title: Text(
      //       categories[i],
      //     ),
      //   ), 
      //   separatorBuilder: (_, i) => const Divider(), 
      //   itemCount: categories.length
      // ) : const Center(
      //   child: Text(
      //     'Buscando categorias de piadas...'
      //   )
      // ),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 255, 101, 46),
        title: const Center(
          child: Text(
            "Escolha uma categoria!"
          ),
        ),
        leading: const Hero(
          tag: 'chuck',
          child: CircleAvatar(
            backgroundImage: AssetImage('assets/chuck.png'),
          ),
        ),
      ),
      body: FutureBuilder<List<String>>(
        future: futureCategories,
        builder: (context, AsyncSnapshot) {
          if (AsyncSnapshot.hasError) {
            return const Center(
              child: Text(
                'Algo deu errado na requisição HTTP!...'
              ),
            );
          }
          if (AsyncSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }else if (AsyncSnapshot.connectionState == ConnectionState.done) {
            final categories = AsyncSnapshot.data;
            return ListView.separated(
              itemBuilder: (_, i) =>  ListTile(
                onTap: () async{
                  final joke = await jokeRepository.getJokeByCategory(categories[i]);
                  Navigator.of(_).push(
                    MaterialPageRoute(
                      builder: (_) => JokePage(joke, categories[i])
                    ),
                  );
                },
                leading: Text(
                  '${i+1}'
                ),
                title: Text(
                  categories[i],
                ),
                dense: true,
              ),
              separatorBuilder: (_, i) => const Divider(),
              itemCount: categories!.length,
            );
          }else {
            return const Center(
              child: Text(
                'Erro desconhecido...'
              ),
            );
          }
          
        }
      ),
    );
  }
}