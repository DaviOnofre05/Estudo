
import 'dart:convert';

import 'package:flutternorris/models/jokemodel.dart';
import 'package:http/http.dart' as http; 

class JokeRepository {
  
  final urlBase = 'https://api.chucknorris.io/jokes';
  
  Future<List<String>> getCategories() async{
    try {
      final response = await http.get(Uri.parse('$urlBase/categories'));
      final decoded = jsonDecode(response.body) as List;
      return List.generate(decoded.length, (i) => decoded[i]);
    } on Exception {
      rethrow;
    }
  }

  Future<JokeModel> getJokeByCategory(String category) async {
    try {
      final response = await http.get(Uri.parse('$urlBase/random?category?=$category'));
      final decode = jsonDecode(response.body);
      final joke = JokeModel.fromJson(decode);
      return joke;
    } on Exception {
      rethrow;
    }
  }

}