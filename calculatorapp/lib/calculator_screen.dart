import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';

class Calculator extends StatefulWidget {
  const Calculator({Key? key}) : super(key: key);

  @override
  State<Calculator> createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  String userInput = "";
  String result = "0";
  List<String> buttonList = [
    'AC',
    '(',
    ')',
    '/',
    '7',
    '8',
    '9',
    '*',
    '4',
    '5',
    '6',
    '+',
    '1',
    '2',
    '3',
    '-',
    'C',
    '0',
    '.',
    '=',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                  alignment: Alignment.centerRight,
                  child: const Text(
                    "user Input",
                    style: TextStyle(
                      fontSize: 32,
                      color: Colors.white,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20),
                  alignment: Alignment.centerRight,
                  child: const Text(
                    "result",
                    style: TextStyle(
                      fontSize: 48,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Divider(color: Colors.white),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(10),
              child: GridView.builder(
                itemCount: buttonList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 4,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                ),
                itemBuilder: (BuildContext context, int index) {
                  return CustomButton(buttonList[index]);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget CustomButton(String text) {
    return InkWell(
      splashColor: const Color(0xFF1d2630),
      onTap: () {
        setState(() {
          handleButtons(text);
        });
      },
      child: Ink(
        decoration: BoxDecoration(
          color: getBgColor(text),
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.white.withOpacity(0.1),
              blurRadius: 4,
              spreadRadius: 0.5,
              offset: const Offset(-3, -3),
            ),
          ],
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: getColor(text),
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  Color getColor(String text) {
    if (text == "/" ||
        text == "*" ||
        text == "+" ||
        text == "-" ||
        text == "C" ||
        text == "(" ||
        text == ")") {
      return const Color.fromARGB(255, 252, 100, 100);
    }
    return Colors.white;
  }

  Color getBgColor(String text) {
    if (text == "AC") {
      return const Color.fromARGB(255, 252, 100, 100);
    }
    if (text == "=") {
      return const Color.fromARGB(255, 104, 204, 159);
    }
    return const Color(0xFF1d2630);
  }

  void handleButtons(String text) {
    if (text == "AC") {
      userInput = "";
      result = "0";
    } else if (text == "C") {
      if (userInput.isNotEmpty) {
        userInput = userInput.substring(0, userInput.length - 1);
      }
    } else if (text == "=") {
      result = calculator();
      userInput = result;

      if (result.endsWith(".0")) {
        return;
      }
      result = calculator();
    } else {
      userInput += text;
    }
  }

  String calculator() {
    try {
      final exp = Parser().parse(userInput);
      final evaluation = exp.evaluate(EvaluationType.REAL, ContextModel());
      return evaluation.toString();
    } catch (e) {
      return "Error";
    }
  }
}
