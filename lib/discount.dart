import 'package:flutter/material.dart';

void main() {
  runApp(DiscountCalculatorApp());
}

class DiscountCalculatorApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Discount Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DiscountCalculator(),
    );
  }
}

class DiscountCalculator extends StatefulWidget {
  @override
  _DiscountCalculatorState createState() => _DiscountCalculatorState();
}

class _DiscountCalculatorState extends State<DiscountCalculator> {
  final TextEditingController originalPriceController = TextEditingController();
  final TextEditingController discountPercentageController = TextEditingController();
  String result = '';

  void calculateDiscountedPrice() {
    double? originalPrice = double.tryParse(originalPriceController.text);
    double? discountPercentage = double.tryParse(discountPercentageController.text);

    if (originalPrice == null || discountPercentage == null || discountPercentage < 0 || discountPercentage > 100) {
      setState(() {
        result = 'Please enter valid values for price and discount (0-100%)';
      });
      return;
    }

    double discountAmount = (originalPrice * discountPercentage) / 100;
    double finalPrice = originalPrice - discountAmount;

    setState(() {
      result = 'Final Price: \$${finalPrice.toStringAsFixed(2)}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Discount Calculator'),
      ),
      body: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue.shade100, Colors.blue.shade400],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Original Price Input
            TextFormField(
              controller: originalPriceController,
              decoration: InputDecoration(
                labelText: 'Original Price',
                prefixIcon: Icon(Icons.attach_money),
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),

            // Discount Percentage Input
            TextFormField(
              controller: discountPercentageController,
              decoration: InputDecoration(
                labelText: 'Discount Percentage (%)',
                prefixIcon: Icon(Icons.percent),
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 30),

            // Calculate Button
            ElevatedButton(
              onPressed: calculateDiscountedPrice,
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
