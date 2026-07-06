import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:intl/intl.dart';

import '../models/app_colors.dart';

class MessageBubble extends StatelessWidget {
  final dynamic msg;
  final bool isMe;

  const MessageBubble({
    super.key,
    required this.msg,
    required this.isMe,
  });

  @override
  Widget build(BuildContext context) {
    String time = "";

    if (msg.time != null) {
      time = DateFormat('hh:mm a').format(msg.time!);
    }

    return Align(
      alignment: isMe
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        decoration: BoxDecoration(
          color: isMe
              ? AppColors.messageMe
              : AppColors.messageOther,
          borderRadius: BorderRadius.circular(
            AppColors.messageRadius,
          ),
          boxShadow: const [
            BoxShadow(
              color: AppColors.shadow,
              blurRadius: 5,
              offset: Offset(0, 2),
            )
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              msg.text,
              style: TextStyle(
                color: isMe
                    ? AppColors.white
                    : AppColors.textPrimary,
              ),
            ),
            if (time.isNotEmpty)
              Text(
                time,
                style: const TextStyle(
                  color: AppColors.textSoft,
                  fontSize: 10,
                ),
              ),
          ],
        ),
      )
          .animate()
          .fade()
          .slideY(begin: 0.1),
    );
  }
}