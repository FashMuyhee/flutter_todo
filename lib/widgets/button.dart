import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String title;
  VoidCallback onPressed;

  Button({Key? key, required this.title, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      color: Theme.of(context).primaryColor,
      height: 45,
      minWidth: 110,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
      child: Text(
        title,
        style:
            const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }
}
