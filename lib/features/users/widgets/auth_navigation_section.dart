import 'package:flutter/material.dart';

class AuthNavigationSection extends StatelessWidget {
  final String text;
  final String buttonText;
  final Widget destination;
  final bool replace;

  const AuthNavigationSection({
    super.key,
    required this.text,
    required this.buttonText,
    required this.destination,
    this.replace = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(text),
        TextButton(
          onPressed: () {
            if (replace) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => destination,
                ),
              );
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => destination,
                ),
              );
            }
          },
          child: Text(buttonText),
        ),
      ],
    );
  }
}