import 'package:chat_app/models/app_colors.dart';
import 'package:flutter/material.dart';



class AuthHeader extends StatelessWidget {
  final IconData icon;
  final String title;

  const AuthHeader({
    super.key,
    required this.icon,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          icon,
          size: 80,
          color: AppColors.headerColor,
        ),

        const SizedBox(height: 24),

        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 24),
      ],
    );
  }
}