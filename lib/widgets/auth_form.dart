import 'package:flutter/material.dart';

import '../models/app_colors.dart';
import 'custom_text_field.dart';
import '../services/auth_controller.dart';

class AuthForm extends StatelessWidget {
  final AuthController controller;
  final VoidCallback onSubmit;
  final VoidCallback onTogglePassword;
  final bool isRegister;

  const AuthForm({
    super.key,
    required this.controller,
    required this.onSubmit,
    required this.onTogglePassword,
    this.isRegister = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(24),
        boxShadow: const [
          BoxShadow(
            color: AppColors.shadow,
            blurRadius: 20,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          // NAME (only register)
          if (isRegister) ...[
            CustomTextField(
              controller: RegisterController().nameController,
              label: "Name",
              prefixIcon: Icon(
              Icons.person,
            ),
            ),
            const SizedBox(height: 16),
          ],

          // EMAIL
          CustomTextField(
            controller: controller.emailController,
            label: "Email",
            prefixIcon: Icon(
              Icons.email,
            ),
          ),

          const SizedBox(height: 16),

          // PASSWORD
          CustomTextField(
            controller: controller.passwordController,
            label: "Password",
            prefixIcon: Icon(
              Icons.lock,
            ),
            obscureText: !controller.isPasswordVisible,
            suffixIcon: IconButton(
              icon: Icon(
                controller.isPasswordVisible
                    ? Icons.visibility
                    : Icons.visibility_off,
              ),
              onPressed: onTogglePassword,
            ),
          ),

          const SizedBox(height: 24),

          // BUTTON
          SizedBox(
            width: double.infinity, // ياخد عرض الشاشة كله
            child: ElevatedButton(
              onPressed: controller.isLoading ? null : onSubmit,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.white,
              ),
              child: controller.isLoading
                  ? const CircularProgressIndicator()
                  : Text(isRegister ? "Sign Up" : "Sign In"),
            ),
          ),
        ],
      ),
    );
  }
}