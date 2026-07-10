import 'package:flutter/material.dart';
import '../../auth/services/auth_service.dart';

class RegisterController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final AuthService auth = AuthService();

  bool isLoading = false;
  String? error;
  bool isPasswordVisible = false;

  Future<void> register({
    required Function(void Function()) setState,
    required BuildContext context,
    required VoidCallback onSuccess,
  }) async {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (name.isEmpty || email.isEmpty || password.isEmpty) {
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
      await auth.register(
        name: name,
        email: email,
        password: password,
      );

      onSuccess();
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

  void togglePassword(Function(void Function()) setState) {
    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
  }

  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
}