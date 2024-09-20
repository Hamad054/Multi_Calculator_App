import 'package:flutter/material.dart';
class SpeedDistanceTimeCalculator extends StatefulWidget {
  @override
  _SpeedDistanceTimeCalculatorState createState() => _SpeedDistanceTimeCalculatorState();
}

class _SpeedDistanceTimeCalculatorState extends State<SpeedDistanceTimeCalculator> {
  final TextEditingController speedController = TextEditingController();
  final TextEditingController distanceController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  String selectedOption = 'Speed';  // Default to speed
  String result = '';

  void calculate() {
    try {
      double? speed = double.tryParse(speedController.text);
      double? distance = double.tryParse(distanceController.text);
      double? time = double.tryParse(timeController.text);

      // Handle empty fields or invalid numbers
      if (selectedOption == 'Speed' && (distance == null || time == null)) {
        setState(() {
          result = 'Please enter valid distance and time values';
        });
        return;
      }
      if (selectedOption == 'Distance' && (speed == null || time == null)) {
        setState(() {
          result = 'Please enter valid speed and time values';
        });
        return;
      }
      if (selectedOption == 'Time' && (speed == null || distance == null)) {
        setState(() {
          result = 'Please enter valid speed and distance values';
        });
        return;
      }

      // Perform calculation
      switch (selectedOption) {
        case 'Speed':
          if (time == 0) {
            setState(() {
              result = 'Time cannot be zero for speed calculation';
            });
          } else {
            setState(() {
              result = 'Speed: ${(distance! / time!).toStringAsFixed(2)}';
            });
          }
          break;
        case 'Distance':
          setState(() {
            result = 'Distance: ${(speed! * time!).toStringAsFixed(2)}';
          });
          break;
        case 'Time':
          if (speed == 0) {
            setState(() {
              result = 'Speed cannot be zero for time calculation';
            });
          } else {
            setState(() {
              result = 'Time: ${(distance! / speed!).toStringAsFixed(2)}';
            });
          }
          break;
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
      appBar: AppBar(title: Text('Speed Distance Time Calculator')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButton<String>(
              value: selectedOption,
              onChanged: (value) {
                setState(() {
                  selectedOption = value!;
                  result = '';  // Clear result when option changes
                });
              },
              items: ['Speed', 'Distance', 'Time'].map((String option) {
                return DropdownMenuItem<String>(
                  value: option,
                  child: Text(option),
                );
              }).toList(),
            ),
            if (selectedOption != 'Speed')
              TextFormField(
                controller: speedController,
                decoration: InputDecoration(labelText: 'Speed'),
                keyboardType: TextInputType.number,
              ),
            if (selectedOption != 'Distance')
              TextFormField(
                controller: distanceController,
                decoration: InputDecoration(labelText: 'Distance'),
                keyboardType: TextInputType.number,
              ),
            if (selectedOption != 'Time')
              TextFormField(
                controller: timeController,
                decoration: InputDecoration(labelText: 'Time'),
                keyboardType: TextInputType.number,
              ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: calculate,
              child: Text('Calculate'),
            ),
            SizedBox(height: 20),
            Text(result, style: TextStyle(fontSize: 20, color: Colors.red)),
          ],
        ),
      ),
    );
  }
}
