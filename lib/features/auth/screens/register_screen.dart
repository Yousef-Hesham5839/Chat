import 'package:flutter/material.dart';

import '../controllers/auth_controller.dart';
import 'login_screen.dart';
import 'package:chat_app/features/users/widgets/auth_header.dart';
import 'package:chat_app/features/users/widgets/auth_form.dart';
import 'package:chat_app/features/users/widgets/auth_navigation_section.dart';



class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final RegisterController controller = RegisterController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
               AuthHeader(
                 icon: Icons.person_add,
                 title: "Create Account",
               ),

                const SizedBox(height: 24),

                AuthForm(
                 controller: controller,
                 isRegister: true,
                 onSubmit: () {
                  controller.register(
                   setState: setState,
                   context: context,
                  );
                },
                 onTogglePassword: () {
                  setState(() {
                   controller.togglePassword(setState);
                  });
                 },
                ),

                const SizedBox(height: 20),

                AuthNavigationSection(
                 text: "Already have an account?",
                 buttonText: "Login",
                 destination: const LoginScreen(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}