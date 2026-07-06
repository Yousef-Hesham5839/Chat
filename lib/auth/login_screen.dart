import 'package:flutter/material.dart';

import '../services/auth_controller.dart';
import 'package:chat_app/auth/register_screen.dart';
import 'package:chat_app/widgets/auth_header.dart';
import 'package:chat_app/widgets/auth_form.dart';
import 'package:chat_app/widgets/auth_navigation_section.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final LoginController controller = LoginController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
  // passwordControllerو emailController عند إغلاق التطبيق يتم التخلص من




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
                     padding: const EdgeInsets.symmetric(horizontal: 24),
                     child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                       // (الأيقونة + Welcome Back)
                       const AuthHeader(
                        icon: Icons.forum_rounded,
                        title: "Welcome Back",
                       ),
           
                       // (حقول الإدخال + الزر)
                       AuthForm(
                        controller: controller,
                        onSubmit: () {
                         controller.login(
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
                       
                       // (Create account button)
                       AuthNavigationSection(
                       text: "Don't have an account?",
                       buttonText: "Create Account",
                       destination: const RegisterScreen(),
                       ),
                      ],
                     ),
         )
        ),
      ),
    );
  }
}