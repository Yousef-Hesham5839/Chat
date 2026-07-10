import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:chat_app/core/helpers/chat_helper.dart';

class ChatService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Send Message
  Future<void> sendMessage({
    required String senderId,
    required String receiverId,
    required String text,
  }) async {
    final id = ChatHelper.chatId(senderId, receiverId);

    final chatRef = _firestore.collection("chats").doc(id);

    final messageRef = chatRef.collection("messages").doc();

    await messageRef.set({
      "text": text,
      "sender": senderId,
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

  /// Get Chats List
  Stream<QuerySnapshot<Map<String, dynamic>>> getChats(String userId) {
    return _firestore
        .collection("chats")
        .where("users", arrayContains: userId)
        .orderBy("updatedAt", descending: true)
        .snapshots();
  }

  /// Delete whole chat
  Future<void> deleteChat({
    required String user1,
    required String user2,
  }) async {
    final id = ChatHelper.chatId(user1, user2);

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