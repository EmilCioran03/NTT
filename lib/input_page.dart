import 'package:flutter/material.dart';
import 'dart:math';

class InputPage extends StatefulWidget {
  final String title;
  final String function;

  InputPage({required this.title, required this.function});

  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController num1Controller = TextEditingController();
  TextEditingController num2Controller = TextEditingController();
  String result = '';

  int gcd(int a, int b) {
    while (b != 0) {
      int temp = b;
      b = a % b;
      a = temp;
    }
    return a;
  }

  int numberOfFactors(int n) {
    int count = 0;
    for (int i = 1; i <= sqrt(n); i++) {
      if (n % i == 0) {
        count += (i == n / i) ? 1 : 2;
      }
    }
    return count;
  }

  void calculate() {
    if (_formKey.currentState!.validate()) {
      int num1 = int.parse(num1Controller.text);
      int num2 = int.parse(num2Controller.text);

      if (widget.function == 'gcd') {
        setState(() {
          result = 'GCD: ${gcd(num1, num2)}';
        });
      } else if (widget.function == 'factors') {
        setState(() {
          result = 'Number of Factors: ${numberOfFactors(num1)}';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: num1Controller,
                decoration: InputDecoration(labelText: 'Enter first number'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a number';
                  }
                  return null;
                },
              ),
              if (widget.function == 'gcd')
                TextFormField(
                  controller: num2Controller,
                  decoration: InputDecoration(labelText: 'Enter second number'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a number';
                    }
                    return null;
                  },
                ),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text('Calculate'),
                onPressed: calculate,
              ),
              SizedBox(height: 20),
              Text(
                result,
                style: TextStyle(fontSize: 24),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
