import 'package:flutter/material.dart';
import '../services/auth_service.dart';

class LoginController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final AuthService auth = AuthService();

  bool isLoading = false;
  String? error;
  bool isPasswordVisible = false;

  Future<void> login({
    required Function(void Function()) setState,
    required BuildContext context,
    required VoidCallback onSuccess,
  }) async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      setState(() {
        error = "Please fill all fields";
      });
      return;
    }

    setState(() {
      isLoading = true;
      error = null;
    });

    try {
      final user = await auth.login(email: email, password: password);

      if (user != null) {
        onSuccess();
      }
    } catch (e) {
      setState(() {
        error = e.toString().replaceAll("Exception:", "");
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
  }

  void togglePassword(Function(void Function()) setState) {
  setState(() {
    isPasswordVisible = !isPasswordVisible;
  });
}
}
