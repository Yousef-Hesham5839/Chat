class MessageModel {
  final String text;
  final String sender;
  final DateTime? time;

  MessageModel({
    required this.text,
    required this.sender,
    this.time,
  });

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      text: map['text'] ?? '',
      sender: map['sender'] ?? '',
      time: map['time']?.toDate(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'sender': sender,
      'time': time,
    };
  }
}