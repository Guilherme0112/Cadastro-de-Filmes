import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final VoidCallback onPressed;

  const Button({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed,
      tooltip: 'Increment',
      child: const Icon(Icons.add, color: Colors.white),
      backgroundColor: const Color.fromARGB(255, 34, 160, 209),
    );
  }
}
