// ignore: non_constant_identifier_names

import 'package:flutter/material.dart';

double valorPeso = 50;
double valorAltura = 1.6;
TextEditingController pesoController = TextEditingController(text: '50');
TextEditingController alturaController = TextEditingController(text: '1.6');

double? imc;
String? classificacao;
Color? corResultado;

String? getClassificacaoIMC(double imc) {
  if (imc <= 18.5) {
    return 'Abaixo do peso';
  }
  if (imc > 18.5 && imc <= 24.9) {
    return 'Peso normal';
  }
  if (imc > 25 && imc < 29.9) {
    return 'Sobrepeso';
  }
  if (imc > 30 && imc < 34.9) {
    return 'Obesidade Grau I';
  }
  if (imc > 35 && imc < 39.9) {
    return 'Obesidade Grau II';
  }
  if (imc > 40) {
    return 'Obesidade Grau III';
  }
  return null;
}

Color? getCorIMC(double imc) {
  if (imc <= 18.5) {
    return Colors.blue;
  }
  if (imc > 18.5 && imc <= 24.9) {
    return Colors.green;
  }
  if (imc > 25 && imc < 29.9) {
    return const Color(0xFFF4BE8E);
  }
  if (imc > 30 && imc < 34.9) {
    return const Color(0xFFEE9809);
  }
  if (imc > 35 && imc < 39.9) {
    return const Color(0xFFE44F38);
  }
  if (imc > 40) {
    return Colors.red;
  }
  return null;
}

void calIMC() {
  double peso = double.parse(pesoController.text);
  double altura = double.parse(alturaController.text);
  imc = peso / (altura * altura);
  classificacao = getClassificacaoIMC(imc!);
  corResultado = getCorIMC(imc!);
}

void anulaTudo() {
  imc = null;
  classificacao = null;
  corResultado = null;
  pesoController.text = '';
  alturaController.text = '';
}
