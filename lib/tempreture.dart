import 'package:flutter/material.dart';

void main() {
  runApp(TemperatureConverterApp());
}

class TemperatureConverterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Temperature Converter',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TemperatureConverter(),
    );
  }
}

class TemperatureConverter extends StatefulWidget {
  @override
  _TemperatureConverterState createState() => _TemperatureConverterState();
}

class _TemperatureConverterState extends State<TemperatureConverter> {
  String _fromUnit = 'Celsius';
  String _toUnit = 'Fahrenheit';
  double? _inputValue;
  String _result = '';

  final List<String> _units = ['Celsius', 'Fahrenheit', 'Kelvin'];
  final TextEditingController _inputController = TextEditingController();

  void _convertTemperature() {
    double input = double.tryParse(_inputController.text) ?? 0;
    double output = 0;

    if (_fromUnit == _toUnit) {
      output = input;
    } else if (_fromUnit == 'Celsius') {
      if (_toUnit == 'Fahrenheit') {
        output = (input * 9/5) + 32;
      } else if (_toUnit == 'Kelvin') {
        output = input + 273.15;
      }
    } else if (_fromUnit == 'Fahrenheit') {
      if (_toUnit == 'Celsius') {
        output = (input - 32) * 5/9;
      } else if (_toUnit == 'Kelvin') {
        output = (input - 32) * 5/9 + 273.15;
      }
    } else if (_fromUnit == 'Kelvin') {
      if (_toUnit == 'Celsius') {
        output = input - 273.15;
      } else if (_toUnit == 'Fahrenheit') {
        output = (input - 273.15) * 9/5 + 32;
      }
    }

    setState(() {
      _result = '$_inputValue $_fromUnit = ${output.toStringAsFixed(2)} $_toUnit';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Temperature Converter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _inputController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter Temperature',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                DropdownButton<String>(
                  value: _fromUnit,
                  onChanged: (String? newValue) {
                    setState(() {
                      _fromUnit = newValue!;
                    });
                  },
                  items: _units.map((String unit) {
                    return DropdownMenuItem<String>(
                      value: unit,
                      child: Text(unit),
                    );
                  }).toList(),
                ),
                Icon(Icons.arrow_forward),
                DropdownButton<String>(
                  value: _toUnit,
                  onChanged: (String? newValue) {
                    setState(() {
                      _toUnit = newValue!;
                    });
                  },
                  items: _units.map((String unit) {
                    return DropdownMenuItem<String>(
                      value: unit,
                      child: Text(unit),
                    );
                  }).toList(),
                ),
              ],
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: _convertTemperature,
              child: Text('Convert'),
              style: ElevatedButton.styleFrom(
                primary: Colors.blueAccent,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                textStyle: TextStyle(fontSize: 18),
              ),
            ),
            SizedBox(height: 30),
            Text(
              _result,
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
