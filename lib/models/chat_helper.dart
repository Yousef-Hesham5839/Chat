class ChatHelper {
  static String chatId(String user1, String user2) {
    final ids = [user1, user2];
    ids.sort();
    return ids.join("_");
  }
}
