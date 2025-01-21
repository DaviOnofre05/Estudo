

import 'package:calculadora_imc/widgets/imc_calculator.dart';
import 'package:flutter/material.dart';

class CalculadoraImc extends StatefulWidget {
  const CalculadoraImc({super.key});

  @override
  State<CalculadoraImc> createState() => _CalculadoraImcState();
}

class _CalculadoraImcState extends State<CalculadoraImc> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 161, 161, 161),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            imc == null ? const Text(
              'Adicione valores de peso e \naltura para calcularseu IMC',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontStyle: FontStyle.italic,
              ),
            ) : Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(150),
                  border: Border.all(width: 12, color: corResultado!)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '${imc?.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 45, color: corResultado),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Text(
                    '$classificacao',
                    style: TextStyle(fontSize: 20, color: corResultado),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    const Text('Seu peso'),
                    const SizedBox(height: 10,),
                    SizedBox(
                      width: 95,
                      child: TextField(
                        controller: pesoController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25)),
                          suffixText: 'kg',
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    Slider(
                      activeColor: Colors.purple,
                      value: valorPeso, 
                      onChanged: (peso) {
                        setState(() {
                          pesoController.text = valorPeso.toStringAsFixed(3);
                          valorPeso = peso;
                        });
                      },
                      min: 0,
                      max: 200,
                    ),
                  ],
                ),
                const SizedBox(
                  width: 22,
                ),
                Column(
                  children: [
                    const Text('Seu altura'),
                    const SizedBox(height: 10,),
                    SizedBox(
                      width: 75,
                      child: TextField(
                        controller: alturaController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25)),
                          suffixText: 'm',
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    Slider(
                      activeColor: Colors.purple,
                      value: valorAltura, 
                      onChanged: (altura) {
                        setState(() {
                          alturaController.text = valorAltura.toStringAsFixed(2);
                          valorAltura = altura;
                        });
                      },
                      min: 0,
                      max: 2.00,
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
             height: 25,
            ),
            SizedBox(
              width: 200,
              height: 60,
              child: ElevatedButton(
                onPressed: () {
                  try {
                    setState(() {
                      calIMC();
                    });
                  } on Exception {
                    setState(() {
                      anulaTudo();
                    });
                  }
                },
                style: ButtonStyle(
                  backgroundColor: WidgetStateProperty.resolveWith(
                      (states) => const Color.fromARGB(255, 147, 0, 205)),
                ),
                child: const Text(
                  'Calcular',
                  style: TextStyle(
                    color: Colors.white
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

}
