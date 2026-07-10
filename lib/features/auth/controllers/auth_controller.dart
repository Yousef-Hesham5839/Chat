import 'package:chat_app/features/users/screens/users_screen.dart';
import 'package:flutter/material.dart';
import '../services/auth_service.dart';

enum AuthType { login, register }

/// =======================
/// BASE CONTROLLER
/// =======================
class AuthController {
  final AuthService authService = AuthService();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isLoading = false;
  bool isPasswordVisible = false;
  String? error;

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

/// =======================
/// LOGIN CONTROLLER
/// =======================
class LoginController extends AuthController {
  Future<void> login({
    required Function(void Function()) setState,
    required BuildContext context,
  }) async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    // Validation
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
      await authService.login(
        email: email,
        password: password,
      );

      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const UsersScreen(),
          ),
        );
      }

    } catch (e) {
      setState(() {
        error = e.toString();
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}

/// =======================
/// REGISTER CONTROLLER
/// =======================
class RegisterController extends AuthController {
  final nameController = TextEditingController();

  Future<void> register({
    required Function(void Function()) setState,
    required BuildContext context,
  }) async {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    // Validation
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
      await authService.register(
        name: name,
        email: email,
        password: password,
      );

      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => const UsersScreen(),
          ),
        );
      }

    } catch (e) {
      setState(() {
        error = e.toString();
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}
