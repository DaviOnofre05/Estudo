import 'dart:io';

String? retornar() {
  print("Vc quer continuar?");
  print("Digite [s/n]");
  String? resposta = stdin.readLineSync();
  while (resposta == null || !['s', 'n'].contains(resposta)) {
    print("Digite uma resposta válida: ");
    print("Digite [s/n]");
    resposta = stdin.readLineSync(); // Reatribui a resposta
  }
  return resposta;
} 

void main () {

  int i = 1;

  while (true) {
  print("Digite um número:");
  String? numero = stdin.readLineSync();

    if (numero != null && numero.isNotEmpty) {
      int num = int.parse(numero);
  
      while(i <= 10) {
        print("$i X $num = ${num * i}");
        i++;
      }
    }
    var respostaUsuario = retornar()!.toLowerCase();

    if (respostaUsuario == "s") {
      return main();
     }else {
      break;
    }
    
  }
}