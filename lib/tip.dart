import 'package:flutter/material.dart';

class TipCalculator extends StatefulWidget {
  @override
  _TipCalculatorState createState() => _TipCalculatorState();
}

class _TipCalculatorState extends State<TipCalculator> {
  double billAmount = 0.0;
  int tipPercentage = 15;
  double totalAmount = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tip Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Enter bill amount'),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                billAmount = double.parse(value);
              },
            ),
            DropdownButton<int>(
              value: tipPercentage,
              items: [10, 15, 20].map((int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text('$value% Tip'),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  tipPercentage = newValue!;
                });
              },
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  totalAmount = billAmount + (billAmount * tipPercentage / 100);
                });
              },
              child: Text('Calculate Total'),
            ),
            SizedBox(height: 20),
            Text('Total amount: $totalAmount'),
          ],
        ),
      ),
    );
  }
}
