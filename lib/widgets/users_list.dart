import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../models/app_colors.dart';
import '../screens/chat_screen.dart';

class UsersList extends StatelessWidget {
  final List users;
  final String? currentUserId;

  const UsersList({
    super.key,
    required this.users,
    required this.currentUserId,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: users.length,
      itemBuilder: (context, i) {
        final u = users[i].data();
        final uid = u["uid"];
        final name = u["name"] ?? "Unknown";
        final email = u["email"] ?? "";

        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                color: AppColors.shadow,
                blurRadius: 10,
                offset: Offset(0, 4),
              )
            ],
          ),
          child: ListTile(
            leading: CircleAvatar(
              backgroundColor: AppColors.primarySoft,
              child: Text(
                name.isNotEmpty ? name[0].toUpperCase() : "?",
                style: const TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            title: Text(name),
            subtitle: Text(email),

            trailing: const Icon(
              Icons.chat_bubble_outline,
              color: AppColors.primary,
            ),

            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ChatScreen(
                    userId: uid,
                    userName: name,
                  ),
                ),
              );
            },
          ),
        )
            .animate()
            .fade(delay: (i * 100).ms)
            .slideX(begin: 0.1);
      },
    );
  }
}