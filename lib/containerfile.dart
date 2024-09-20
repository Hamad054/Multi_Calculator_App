import 'package:flutter/material.dart';
import 'style.dart';


class RepeatContainerCode extends StatelessWidget {
  RepeatContainerCode({required this.colors, this.cardwidget,this.onPressed});

  final Color colors;
  final Widget? cardwidget;
  final onPressed;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        margin: const EdgeInsets.all(10.0),
        child: cardwidget,
        decoration: BoxDecoration(
          color: colors,
          borderRadius: BorderRadius.circular(15.0),
        ),
      ),
    );
  }
}