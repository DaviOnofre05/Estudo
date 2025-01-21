
import 'dart:io';

void main () {

  while(true){
    print("Digite um número: ");
    String? num = stdin.readLineSync();
    
    if (num != null && num.isNotEmpty) {
      try {
        int numero = int.parse(num);
        if (numero % 2 == 0) {
          print("Vc digitou um número par!");
          if (numero < 0) {
            print("Seu número é negativo");
          }else {
            print("Seu número é positivo");
          }
        }else {
          print("Vc digitou um número impar!");
          if (numero < 0) {
            print("Seu número é negativo");
          }else {
            print("Seu número é positivo");
          }
        }
      } catch (e) {
        print("Vc não digitou um número");
      }
    }

    print("Vc quer continuar?");
    print("Digite [s/n]");
    String? resposta = stdin.readLineSync();
    if (resposta == "s"){
      return main();
    } 
    if (resposta == null || !["s", "n"].contains(resposta.toLowerCase())) {
      print("Vc quer continuar?");
      print("Digite [s/n]");
    }
    if (resposta == "n") {
      break;
    }
  }
}