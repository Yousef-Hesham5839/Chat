import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/message_model.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Generate unique chat id between two users
  String chatId(String user1, String user2) {
    final ids = [user1, user2];
    ids.sort();
    return ids.join("_");
  }

  /// Send Message
  Future<void> sendMessage({
    required String senderId,
    required String receiverId,
    required String text,
  }) async {
    final id = chatId(senderId, receiverId);

    final message = MessageModel(
      text: text,
      sender: senderId,
      time: DateTime.now(),
    );

    final chatRef = _firestore.collection("chats").doc(id);

    final messageRef = chatRef.collection("messages").doc();

    await messageRef.set({
      ...message.toMap(),
      "messageId": messageRef.id,
      "receiver": receiverId,
      "seen": false,
      "timestamp": FieldValue.serverTimestamp(),
    });

    await chatRef.set({
      "chatId": id,
      "users": [senderId, receiverId],
      "lastMessage": text,
      "lastSender": senderId,
      "updatedAt": FieldValue.serverTimestamp(),
      "messagesCount": FieldValue.increment(1),
    }, SetOptions(merge: true));
  }

  /// Real Time Messages
  Stream<List<MessageModel>> getMessages({
    required String user1,
    required String user2,
  }) {
    final id = chatId(user1, user2);

    return _firestore
        .collection("chats")
        .doc(id)
        .collection("messages")
        .orderBy("timestamp")
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => MessageModel.fromMap(doc.data()))
              .toList(),
        );
  }

  /// Chats List (WhatsApp Home)
  Stream<QuerySnapshot<Map<String, dynamic>>> getChats(
      String userId) {
    return _firestore
        .collection("chats")
        .where("users", arrayContains: userId)
        .orderBy("updatedAt", descending: true)
        .snapshots();
  }

  /// Delete Message
  Future<void> deleteMessage({
    required String user1,
    required String user2,
    required String messageId,
  }) async {
    final id = chatId(user1, user2);

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
    final id = chatId(user1, user2);

    await _firestore
        .collection("chats")
        .doc(id)
        .collection("messages")
        .doc(messageId)
        .update({
      "seen": true,
    });
  }

  /// Delete whole chat
  Future<void> deleteChat({
    required String user1,
    required String user2,
  }) async {
    final id = chatId(user1, user2);

    final messages = await _firestore
        .collection("chats")
        .doc(id)
        .collection("messages")
        .get();

    for (final doc in messages.docs) {
      await doc.reference.delete();
    }

    await _firestore.collection("chats").doc(id).delete();
  }
}