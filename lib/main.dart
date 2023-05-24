import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final double boderWidth = 1.5;
  final Color mainColor = Colors.black38;
  final Color secondaryColor = Colors.white;
  final Color numBoxColor = Colors.white;
  String numBoxText = "";

  void pushSymbol(String symbol) {
    setState(() {
      numBoxText += symbol;
    });
  }

  void evaluateExpression() {
    Parser parser = Parser();
    Expression exp = parser.parse(numBoxText);

    ContextModel contextModel = ContextModel();
    double result = exp.evaluate(EvaluationType.REAL, contextModel);
    setState(() {
      numBoxText = '$result';
    });
  }

  void clearExpression() {
    setState(() {
      numBoxText = "";
    });
  }

  void evalSymbol(String label) {
    switch (label) {
      case "=":
        {
          evaluateExpression();
        }
        break;
      case "c":
        {
          setState(() {
            numBoxText = numBoxText.substring(0, numBoxText.length - 1);
          });
        }
      case "C":
        {
          setState(() {
            numBoxText = "";
          });
        }
      default:
        {
          pushSymbol(label);
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(),
      body: Container(
        child: Column(children: [
          Expanded(
            child: Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.all(50),
              child: Text(
                numBoxText,
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
          Expanded(
            child: Row(
              children: [
                NumButton('(', evalSymbol),
                NumButton(')', evalSymbol),
                NumButton('c', evalSymbol),
                NumButton('C', evalSymbol),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                NumButton('1', evalSymbol),
                NumButton('2', evalSymbol),
                NumButton('3', evalSymbol),
                NumButton('+', evalSymbol),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                NumButton('4', evalSymbol),
                NumButton('5', evalSymbol),
                NumButton('6', evalSymbol),
                NumButton('-', evalSymbol),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                NumButton('7', evalSymbol),
                NumButton('8', evalSymbol),
                NumButton('9', evalSymbol),
                NumButton('*', evalSymbol),
              ],
            ),
          ),
          Expanded(
            child: Row(
              children: [
                NumButton('.', evalSymbol),
                NumButton('0', evalSymbol),
                NumButton('=', evalSymbol),
                NumButton('/', evalSymbol),
              ],
            ),
          ),
        ]),
      ),
    ));
  }
}

class NumButton extends StatelessWidget {
  final String label;
  final Function command;

  const NumButton(this.label, this.command, {super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: TextButton(
      onPressed: () {
        command(label);
      },
      child: Center(
        child: Text(label),
      ),
    ));
  }
}
