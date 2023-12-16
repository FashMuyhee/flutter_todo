import 'package:flutter/material.dart';
import 'package:todo/widgets/button.dart';

class NewTodoDialog extends StatelessWidget {
  final TextEditingController controller;
  VoidCallback onSave;
  VoidCallback onCancel;

  NewTodoDialog(
      {super.key,
      required this.controller,
      required this.onCancel,
      required this.onSave});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      insetPadding: EdgeInsets.zero,
      backgroundColor: Theme.of(context).dialogBackgroundColor,
      content: Container(
        height: 150,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              TextField(
                controller: controller,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'To do Title',
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Button(title: 'Save', onPressed: onSave),
                  Button(title: 'Cancel', onPressed: onCancel)
                ],
              )
            ]),
      ),
    );
  }
}
