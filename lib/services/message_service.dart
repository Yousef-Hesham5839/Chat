import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/message_model.dart';
import 'package:chat_app/models/chat_helper.dart';

class MessageService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Get Messages
  Stream<List<MessageModel>> getMessages({
    required String user1,
    required String user2,
  }) {
    final id = ChatHelper.chatId(user1, user2);

    return _firestore
        .collection("chats")
        .doc(id)
        .collection("messages")
        .orderBy("timestamp")
        .snapshots()
        .map((snapshot) =>
            snapshot.docs
                .map((doc) => MessageModel.fromMap(doc.data()))
                .toList());
  }

  /// Delete Message
  Future<void> deleteMessage({
    required String user1,
    required String user2,
    required String messageId,
  }) async {
    final id = ChatHelper.chatId(user1, user2);

    await _firestore
        .collection("chats")
        .doc(id)
        .collection("messages")
        .doc(messageId)
        .delete();
  }

  /// Mark as Seen
  Future<void> markAsSeen({
    required String user1,
    required String user2,
    required String messageId,
  }) async {
    final id = ChatHelper.chatId(user1, user2);

    await _firestore
        .collection("chats")
        .doc(id)
        .collection("messages")
        .doc(messageId)
        .update({
      "seen": true,
    });
  }
}