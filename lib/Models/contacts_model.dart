class ContactMessage {
  final String text;
  final String userId;
  final DateTime timeSend;
  final String bio;
  final String profilePic;
  final String name;
  ContactMessage(
      {required this.text,
      required this.userId,
      required this.timeSend,
      required this.bio,
      required this.profilePic,
      required this.name});
  Map<String, dynamic> toMap() {
    return {
      'text': text,
      'userId': userId,
      'timeSend': timeSend.millisecondsSinceEpoch,
      'bio': bio,
      'profilePic': profilePic,
      'name': name,
    };
  }

  factory ContactMessage.fromMap(Map<String, dynamic> map) {
    return ContactMessage(
      name: map['name'] ?? '',
      profilePic: map['profilePic'] ?? '',
      userId: map['userId'] ?? '',
      timeSend: DateTime.fromMillisecondsSinceEpoch(map['timeSent']),
      text: map['lastMessage'] ?? '',
      bio: map['bio'] ?? '',
    );
  }
}
