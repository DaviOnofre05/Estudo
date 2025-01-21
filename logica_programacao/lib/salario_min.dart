
import 'dart:io';

double salMin = 1293.20;
void main () {
  print("Escreva quanto você ganha: ");
  String? salUser = stdin.readLineSync()!;
  double salUserInt = double.parse(salUser);
  
  if (salUserInt < salMin) {
    print("Seu sálario está abaixo do sálario mínimo");
    return main();
  }else {
    double quantSal = salUserInt / salMin;
    print("Você ganha em média $quantSal sálarios mínimos");
    return main();
  }

}