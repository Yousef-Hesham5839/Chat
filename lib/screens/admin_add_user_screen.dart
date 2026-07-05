import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../models/app_colors.dart';

class AdminAddUserScreen extends StatefulWidget {
  const AdminAddUserScreen({super.key});

  @override
  State<AdminAddUserScreen> createState() => _AdminAddUserScreenState();
}

class _AdminAddUserScreenState extends State<AdminAddUserScreen> {
  final auth = AuthService();

  final name = TextEditingController();
  final email = TextEditingController();
  final password = TextEditingController();

  bool loading = false;

  Future<void> createUser() async {
    setState(() => loading = true);

    await auth.adminCreateUser(
      name: name.text.trim(),
      email: email.text.trim(),
      password: password.text.trim(),
    );

    setState(() => loading = false);

    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add User"),
        backgroundColor: AppColors.admin,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            TextField(
              controller: name,
              decoration: const InputDecoration(
                labelText: "Name",
              ),
            ),
            TextField(
              controller: email,
              decoration: const InputDecoration(labelText: "Email"),
            ),
            TextField(
              controller: password,
              decoration: const InputDecoration(labelText: "Password"),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: loading ? null : createUser,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.admin,
              ),
              child: const Text("Create"),
            )
          ],
        ),
      ),
    );
  }
}