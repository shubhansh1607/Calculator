import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const Calculator());
}

class Calculator extends StatelessWidget {
  const Calculator({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Simple Calculator',
      home: SimpleCalculator(),
    ); // MaterialApp
  }
}

class SimpleCalculator extends StatefulWidget {
  const SimpleCalculator({super.key});
  @override
  State<SimpleCalculator> createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {
  String equation = "0";
  String result = "0";
  String expression = "";
  double equationSize = 38.0;
  double resultSize = 48.0;
  buttonPressed(String buttonText) {
    setState(() {
      if (buttonText == "C") {
        equation = "0";
        result = "0";
        equationSize = 38.0;
        resultSize = 48.0;
      } else if (buttonText == "⌫") {
        equation = equation.substring(0, equation.length - 1);
        if (equation == "") {
          equation = "0";
        }
        equationSize = 48.0;
        resultSize = 38.0;
      } else if (buttonText == "=") {
        equationSize = 38.0;
        resultSize = 48.0;
        expression = equation;
        expression = expression.replaceAll('×', '*');
        expression = expression.replaceAll('÷', '/');
        try {
          Parser p = Parser();
          Expression exp = p.parse(expression);
          ContextModel cm = ContextModel();
          result = '${exp.evaluate(EvaluationType.REAL, cm)}';
        } catch (e) {
          result = "Error";
        }
      } else {
        equationSize = 48.0;
        resultSize = 38.0;
        if (equation == "0") {
          equation = buttonText;
        } else {
          equation = equation + buttonText;
        }
      }
    });
  }

  Widget buildButton(
      String buttonText, double buttonHeight, Color buttonColor) {
    return Container(
      margin: const EdgeInsets.all(5.0),
      height: MediaQuery.of(context).size.height * 0.1 * buttonHeight,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(20),
        ),
        onPressed: () => buttonPressed(buttonText),
        child: Text(
          buttonText,
          style: const TextStyle(
              fontSize: 30.0, fontWeight: FontWeight.w400, color: Colors.white),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(
              equation,
              style: TextStyle(
                  fontSize: equationSize,
                  color: Colors.white,
                  fontWeight: FontWeight.w400),
            ),
          ),
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
            child: Text(
              result,
              style: TextStyle(
                  fontSize: resultSize,
                  color: Colors.white,
                  fontWeight: FontWeight.w400),
            ),
          ),
          const Expanded(
            child: Divider(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * .75,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        buildButton("C", 1, Colors.redAccent),
                        buildButton("⌫", 1, Colors.blue),
                        buildButton("÷", 1, Colors.blue),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton("7", 1, Colors.orange),
                        buildButton("8", 1, Colors.orange),
                        buildButton("9", 1, Colors.orange),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton("4", 1, Colors.orange),
                        buildButton("5", 1, Colors.orange),
                        buildButton("6", 1, Colors.orange),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton("1", 1, Colors.orange),
                        buildButton("2", 1, Colors.orange),
                        buildButton("3", 1, Colors.orange),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton("%", 1, Colors.blue),
                        buildButton("0", 1, Colors.orange),
                        buildButton(".", 1, Colors.blue),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.25,
                child: Table(
                  children: [
                    TableRow(
                      children: [
                        buildButton("×", 1, Colors.blue),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton("-", 1, Colors.blue),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton("+", 1, Colors.blue),
                      ],
                    ),
                    TableRow(
                      children: [
                        buildButton("=", 2, Colors.redAccent),
                      ],
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
