
import 'dart:io';

void main () {

  print("Digite um número: ");
  String? A = stdin.readLineSync();
  print("Digite mais um número: ");
  String? B = stdin.readLineSync();
  print("Digite um terceiro número: ");
  String? C = stdin.readLineSync();

  try {
    int numUm = int.parse(A!);
    int numDois = int.parse(B!);
    int numTres = int.parse(C!);
    int somaAB = numUm + numDois;
    if (somaAB > numTres) {
      print("A soma de $numUm + $numDois = $somaAB");
      print("$somaAB é maoir que $numTres");
    }else {
      print("A soma de $numUm + $numDois = $somaAB");
      print("$somaAB é menor que $numTres");
    }
    
  }catch (e) {
    if (A == null || B == null && C == null){
      print("Digite números");
      return main();
    }
  }

}