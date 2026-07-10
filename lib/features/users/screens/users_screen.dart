import 'package:chat_app/features/users/widgets/custom_appbar_widget.dart';
import 'package:chat_app/features/users/widgets/users_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../auth/services/auth_service.dart';
import '../../chat/services/chat_service.dart';
import '../../auth/screens/login_screen.dart';
import 'admin_add_user_screen.dart';
import '../../../core/constants/app_colors.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  final ChatService chatService = ChatService();
  final AuthService auth = AuthService();

  Future<void> _logout() async {
    await auth.logout();

    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
              title: "Messages",
              onLogout: _logout,
              ),


      floatingActionButton: auth.isAdmin
          ? FloatingActionButton(
              backgroundColor: AppColors.admin,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AdminAddUserScreen()),
                );
              },
              child: const Icon(Icons.person_add, color: Colors.white),
            )
          : null,

      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance.collection("users").snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final currentUserId = auth.currentUser!.uid;

          final users = snapshot.data!.docs
              .where((doc) => doc.data()["uid"] != currentUserId)
              .toList();

          if (users.isEmpty) {
            return const Center(child: Text("No users found"));
          }

          return UsersList(users: users, currentUserId: currentUserId);
        },
      ),
    );
  }
}
