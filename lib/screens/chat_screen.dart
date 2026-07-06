import 'package:chat_app/widgets/chat_input_bar.dart';
import 'package:chat_app/widgets/message_bubble.dart';
import 'package:flutter/material.dart';


import '../models/app_colors.dart';
import '../widgets/custom_appbar_widget.dart';
import '../services/chat_controller.dart';


class ChatScreen extends StatefulWidget {
  final String userId;
  final String userName;

  const ChatScreen({
    super.key,
    required this.userId,
    required this.userName,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final controller = ChatController();

  @override
  void initState() {
    super.initState();
    controller.init();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void sendMessage() {
    controller.sendMessage(receiverId: widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        showUser: true,
        userName: widget.userName,
      ),

      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<List>(
              stream: controller.messageService.getMessages(
                user1: controller.myId,
                user2: widget.userId,
              ),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final messages = snapshot.data!.reversed.toList();

                return ListView.builder(
                 itemBuilder: (context, i) {
                  final msg = messages[i];

                  return MessageBubble(
                   msg: msg,
                   isMe: msg.sender == controller.myId,
                  );
                 },
                );
              },
            ),
          ),

          Container(
            padding: const EdgeInsets.all(12),
            decoration: const BoxDecoration(
              color: AppColors.surface,
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadow,
                  offset: Offset(0, -3),
                  blurRadius: 10,
                )
              ],
            ),
            child: SafeArea(
              child: ChatInputBar(
               controller: controller.textController,
               onSend: sendMessage,
              ),
            ),
          ),
        ],
      ),
    );
  }
}