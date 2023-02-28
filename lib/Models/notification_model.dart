class NotificationModel {
  final String title;
  final String userId;
  final String profilePic;
  final DateTime timePost;
  final String notificationId;
  NotificationModel({
    required this.title,
    required this.userId,
    required this.profilePic,
    required this.timePost,
    required this.notificationId,
  });
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'userId': userId,
      'profilePic': profilePic,
      'timePost': timePost,
      'notificationId': notificationId,
    };
  }

  factory NotificationModel.fromMap(
    Map<String, dynamic> map,
  ) {
    return NotificationModel(
      title: map['title'] ?? '',
      userId: map['userId'] ?? '',
      profilePic: map['profilePic'] ?? '',
      timePost: DateTime.fromMillisecondsSinceEpoch(map['timePost']),
      notificationId: map['notificationId'] ?? '',
    );
  }
}
