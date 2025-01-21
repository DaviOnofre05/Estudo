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

  while (true) {
  print("Digite um número: ");
  String? umNum = stdin.readLineSync()!;
  print("Digite um segundo número: ");
  String? doisNum = stdin.readLineSync()!;

  int numUm = int.parse(umNum);
  int numDois = int.parse(doisNum);

  if (numUm == numDois) {
    int somaAB = numUm + numDois;
    print("A soma $numUm + $numDois = $somaAB");
  }else {
    int mult = numUm * numDois;
    print("A multiplicação $numUm X $numDois = $mult");
  }

  var user = retornar();

  if (user == "s") {
    return main();
  }else {
    break;
  }

  }

  
}