import 'package:flutter/material.dart';
import 'style.dart'; // Make sure to import your style file

class ResultScreen extends StatelessWidget {
  final String result;
  final String statusMessage;

  const ResultScreen({
    Key? key,
    required this.result,
    required this.statusMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI Result'),
        backgroundColor: Color(0xFF1D1E33),
      ),
      body: Card(

        child: Padding(
          
          padding: const EdgeInsets.all(16.0),
          child: Column(

            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Your BMI :',
                style: kstyleclass, // Ensure this style is defined in your style.dart
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10.0),
              Text(
                result,
                style: knumberstyle, // Ensure this style is defined in your style.dart
                textAlign: TextAlign.center,

              ),

              SizedBox(height: 20.0),
              Text(
                statusMessage,
                style: kstyleclass, // Ensure this style is defined in your style.dart
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40.0),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context); // Navigate back to the input page
                },
                child: Text('Recalculate'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.pink, // Ensure this matches your theme
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
