import 'package:flutter/material.dart';
import 'package:multi/age.dart';
import 'package:multi/bmi.dart';
import 'package:multi/speeddistence.dart';
import 'package:multi/tempreture.dart';
import 'package:multi/tip.dart';
import 'package:multi/quardic.dart';
import 'package:multi/todo.dart';
import 'efficency.dart';
import 'curruncy.dart';
import 'discount.dart';

void main() {
  runApp(CalculatorApp());
}

class CalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Multi-Calculator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white, // Set background color for the whole app
      ),
      home: HomePage(),
      routes: {
        '/bmi': (context) => InputPage(),
        '/tip': (context) => TipCalculator(),
        '/age': (context) => AgeCalculator(),
        '/curruncy': (context) => CurrencyConverterScreen(),
        '/quadratic': (context) => QuadraticSolver(),
        '/temperature': (context) => TemperatureConverterApp(),
        '/speeddistence': (context) => SpeedDistanceTimeCalculator(),
        '/discount': (context) => DiscountCalculatorApp(),
        '/efficiency': (context) => FuelEfficiencyCalculatorApp(),
        '/todo': (context) => ToDoListApp(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Multi-Calculator App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Display 2 buttons per row
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 1.0, // Adjust as needed for better fitting
          ),
          itemCount: _calculatorInfo.length,
          itemBuilder: (context, index) {
            final calculatorInfo = _calculatorInfo[index];
            return buildCalculatorButton(
              context,
              calculatorInfo['title']!,
              calculatorInfo['route']!,
              calculatorInfo['icon'] as IconData,
              calculatorInfo['color'] as Color?,
              calculatorInfo['gradient'] as Gradient?,
            );
          },
        ),
      ),
    );
  }

  Widget buildCalculatorButton(
      BuildContext context,
      String title,
      String route,
      IconData icon,
      Color? color,
      Gradient? gradient,
      ) {
    final buttonColor = color ?? Colors.grey; // Default color if null
    final buttonGradient = gradient ?? LinearGradient(colors: [buttonColor, buttonColor.withOpacity(0.7)]); // Default gradient if null

    return GestureDetector(
      onTap: () {
        _showCustomDialog(context, title, route);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16), // Adjust radius for roundness
          gradient: buttonGradient,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 48, color: Colors.white),
              SizedBox(height: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showCustomDialog(BuildContext context, String title, String route) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: AnimatedBuilder(
            animation: ModalRoute.of(context)!.animation!,
            builder: (context, child) {
              final animation = ModalRoute.of(context)!.animation!;
              return FadeTransition(
                opacity: animation,
                child: ScaleTransition(
                  scale: Tween(begin: 0.8, end: 1.0).animate(animation),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Text(
                          'Confirm Action',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 20),
                        Text('Do you want to open the $title?'),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(); // Dismiss the dialog
                              },
                              child: Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop(); // Close the dialog
                                Navigator.pushNamed(context, route); // Navigate to the selected screen
                              },
                              child: Text('Yes'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

final List<Map<String, dynamic>> _calculatorInfo = [
  {'title': 'BMI Calculator', 'route': '/bmi', 'icon': Icons.fitness_center, 'color': Colors.red, 'gradient': LinearGradient(colors: [Colors.red, Colors.redAccent])},
  {'title': 'Fuel Efficiency Calculator', 'route': '/efficiency', 'icon': Icons.local_gas_station, 'color': Colors.orange, 'gradient': LinearGradient(colors: [Colors.orange, Colors.deepOrange])},
  {'title': 'Discount Calculator', 'route': '/discount', 'icon': Icons.discount, 'color': Colors.green, 'gradient': LinearGradient(colors: [Colors.green, Colors.lightGreen])},
  {'title': 'Tip Calculator', 'route': '/tip', 'icon': Icons.attach_money, 'color': Colors.blue, 'gradient': LinearGradient(colors: [Colors.blue, Colors.blueAccent])},
  {'title': 'Age Calculator', 'route': '/age', 'icon': Icons.cake, 'color': Colors.purple, 'gradient': LinearGradient(colors: [Colors.purple, Colors.deepPurple])},
  {'title': 'Currency Converter', 'route': '/curruncy', 'icon': Icons.monetization_on, 'color': Colors.teal, 'gradient': LinearGradient(colors: [Colors.teal, Colors.tealAccent])},
  {'title': 'Quadratic Solver', 'route': '/quadratic', 'icon': Icons.calculate, 'color': Colors.indigo, 'gradient': LinearGradient(colors: [Colors.indigo, Colors.blue])},
  {'title': 'Temperature Converter', 'route': '/temperature', 'icon': Icons.thermostat, 'color': Colors.brown, 'gradient': LinearGradient(colors: [Colors.brown, Colors.orange])},
  {'title': 'SpeedDistanceTimeCalculator', 'route': '/speeddistence', 'icon': Icons.speed, 'color': Colors.grey, 'gradient': LinearGradient(colors: [Colors.grey, Colors.blueGrey])},
  {'title': 'ToDo App', 'route': '/todo', 'icon': Icons.check_box, 'color': Colors.pink, 'gradient': LinearGradient(colors: [Colors.pink, Colors.pinkAccent])},
];

