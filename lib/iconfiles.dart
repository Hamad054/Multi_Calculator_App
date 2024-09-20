import 'package:flutter/material.dart';

class repeticontext extends StatelessWidget {
  repeticontext({required this.iconData, required this.lable}); // Use 'required' keyword

  final IconData iconData;
  final String lable;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          iconData,
          size: 70.0,
          color: Colors.white,
        ),
        SizedBox(height: 20),
        Text(
          lable, // Display the actual label value
          style: TextStyle(
              color: Colors.white,
              fontSize: 20.0
          ),
        ),
      ],
    );
  }
}