import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import 'logout_button.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final String? userName;
  final bool showUser;
  final VoidCallback? onLogout;

  const CustomAppBar({
    super.key,
    this.title,
    this.userName,
    this.showUser = false,
    this.onLogout,
  });


  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.surface,
      elevation: 0,
      title: showUser
          ? Row(
              children: [
                CircleAvatar(
                  backgroundColor: AppColors.avatarHint,
                  child: Text(
                    (userName != null && userName!.isNotEmpty)
                        ? userName![0].toUpperCase()
                        : "?",
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    userName ?? "",
                    style: const TextStyle(
                      color: AppColors.black,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            )
          : Text(
              title ?? "",
              style: const TextStyle(
                color: AppColors.black,
                fontWeight: FontWeight.w600,
              ),
            ),

      actions: onLogout != null
          ? [
              LogoutButton(onLogout: onLogout!),
              const SizedBox(width: 8),
            ]
          : null,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}