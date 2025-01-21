
void main () {

  List<num> lista = [7, 5, 10, 40.5, 2, 8, 98, 0.0001];

  if (lista.isEmpty) {
    print("informe uma lista válida");
    return;
  }

  num maiorNumero = lista [0];
  num menorNumero = lista [0];

  for (int posicaoNumero = 0; posicaoNumero < lista.length; posicaoNumero ++) {
    if (lista[posicaoNumero] > maiorNumero) {
      maiorNumero = lista[posicaoNumero];
    }
    if (lista[posicaoNumero] < menorNumero) {
      menorNumero = lista[posicaoNumero];
    }
  }

  print("O maior número é $maiorNumero");
  print("O menor número é $menorNumero");
}