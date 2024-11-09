import 'package:flutter/material.dart';

class SentimentButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color backgroundColor;
  final VoidCallback onPressed;
  final bool isSelected;

  const SentimentButton({
    required this.icon,
    required this.label,
    required this.backgroundColor,
    required this.onPressed,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: isSelected ? Colors.black : backgroundColor,
          child: IconButton(
            icon: Icon(icon, color: isSelected ? Colors.white : Colors.black),
            color: Colors.white,
            onPressed: onPressed,
          ),
        ),
        const SizedBox(height: 8),
        Text(label),
      ],
    );
  }
}
