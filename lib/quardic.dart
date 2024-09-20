import 'package:flutter/material.dart';
import 'dart:math';

class QuadraticSolver extends StatefulWidget {
  @override
  _QuadraticSolverState createState() => _QuadraticSolverState();
}

class _QuadraticSolverState extends State<QuadraticSolver> {
  final TextEditingController aController = TextEditingController();
  final TextEditingController bController = TextEditingController();
  final TextEditingController cController = TextEditingController();

  String result = '';

  void solveEquation() {
    double a = double.tryParse(aController.text) ?? 0;
    double b = double.tryParse(bController.text) ?? 0;
    double c = double.tryParse(cController.text) ?? 0;

    if (a == 0) {
      setState(() {
        result = 'Not a quadratic equation (a cannot be zero)';
      });
      return;
    }

    double discriminant = b * b - 4 * a * c;

    if (discriminant > 0) {
      double root1 = (-b + sqrt(discriminant)) / (2 * a);
      double root2 = (-b - sqrt(discriminant)) / (2 * a);
      setState(() {
        result = 'Roots are real and different: \nRoot 1 = $root1\nRoot 2 = $root2';
      });
    } else if (discriminant == 0) {
      double root = -b / (2 * a);
      setState(() {
        result = 'Roots are real and equal: \nRoot = $root';
      });
    } else {
      double realPart = -b / (2 * a);
      double imaginaryPart = sqrt(-discriminant) / (2 * a);
      setState(() {
        result = 'Roots are complex: \nRoot 1 = $realPart + ${imaginaryPart}i\n'
            'Root 2 = $realPart - ${imaginaryPart}i';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quadratic Equation Solver'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Enter the coefficients of the quadratic equation:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blueAccent),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            _buildCoefficientInput(aController, 'Enter coefficient a'),
            SizedBox(height: 10),
            _buildCoefficientInput(bController, 'Enter coefficient b'),
            SizedBox(height: 10),
            _buildCoefficientInput(cController, 'Enter coefficient c'),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: solveEquation,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 15.0),
                child: Text('Solve', style: TextStyle(fontSize: 18)),
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            SizedBox(height: 30),
            Text(
              result,
              style: TextStyle(fontSize: 16, color: Colors.black),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCoefficientInput(TextEditingController controller, String hint) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        hintText: hint,
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        filled: true,
        fillColor: Colors.blue[50],
      ),
    );
  }
}
