import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../services/chat_service.dart';

class ChatController {
  final textController = TextEditingController();
  final ScrollController scrollController = ScrollController();
  final ChatService chatService = ChatService();

  late final String myId;

  void init() {
    myId = FirebaseAuth.instance.currentUser?.uid ?? "unknown";
  }

  void sendMessage({
    required String receiverId,
  }) {
    if (textController.text.trim().isEmpty) return;

    chatService.sendMessage(
      senderId: myId,
      receiverId: receiverId,
      text: textController.text.trim(),
    );

    textController.clear();

    if (scrollController.hasClients) {
      scrollController.animateTo(
        0.0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void dispose() {
    textController.dispose();
    scrollController.dispose();
  }
}