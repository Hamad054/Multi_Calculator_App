import 'package:flutter/material.dart';

void main() {
  runApp(FuelEfficiencyCalculatorApp());
}

class FuelEfficiencyCalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fuel Efficiency Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FuelEfficiencyCalculator(),
    );
  }
}

class FuelEfficiencyCalculator extends StatefulWidget {
  @override
  _FuelEfficiencyCalculatorState createState() => _FuelEfficiencyCalculatorState();
}

class _FuelEfficiencyCalculatorState extends State<FuelEfficiencyCalculator> {
  final TextEditingController distanceController = TextEditingController();
  final TextEditingController fuelController = TextEditingController();
  String result = '';
  bool isMetric = true; // Switch between metric (km/L) and imperial (MPG)

  void calculateEfficiency() {
    try {
      double? distance = double.tryParse(distanceController.text);
      double? fuel = double.tryParse(fuelController.text);

      if (distance == null || fuel == null || distance <= 0 || fuel <= 0) {
        setState(() {
          result = 'Please enter valid positive numbers for distance and fuel.';
        });
        return;
      }

      double efficiency;
      if (isMetric) {
        efficiency = (fuel / distance) * 100; // Liters per 100 km
        setState(() {
          result = 'Fuel Efficiency: ${efficiency.toStringAsFixed(2)} L/100km';
        });
      } else {
        efficiency = distance / fuel; // Miles per gallon
        setState(() {
          result = 'Fuel Efficiency: ${efficiency.toStringAsFixed(2)} MPG';
        });
      }
    } catch (e) {
      setState(() {
        result = 'An error occurred: ${e.toString()}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Fuel Efficiency Calculator'),
        actions: [
          IconButton(
            icon: Icon(isMetric ? Icons.swap_horiz : Icons.swap_vert),
            onPressed: () {
              setState(() {
                isMetric = !isMetric;
              });
            },
            tooltip: 'Switch Units',
          ),
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade200, Colors.blue.shade800],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              isMetric ? 'Kilometers per Liter' : 'Miles per Gallon',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
            ),
            SizedBox(height: 20),

            // Distance Input
            TextFormField(
              controller: distanceController,
              decoration: InputDecoration(
                labelText: isMetric ? 'Distance Traveled (km)' : 'Distance Traveled (miles)',
                prefixIcon: Icon(Icons.directions_car),
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),

            // Fuel Input
            TextFormField(
              controller: fuelController,
              decoration: InputDecoration(
                labelText: isMetric ? 'Fuel Consumed (liters)' : 'Fuel Consumed (gallons)',
                prefixIcon: Icon(Icons.local_gas_station),
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 30),

            // Calculate Button
            ElevatedButton(
              onPressed: calculateEfficiency,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                primary: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text('Calculate', style: TextStyle(fontSize: 18, color: Colors.white)),
            ),
            SizedBox(height: 30),

            // Result Display
            if (result.isNotEmpty)
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    result,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
