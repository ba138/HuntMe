class JobModel {
  final String gigs;
  final String title;
  final String discrption;
  final String jobType;
  final String location;
  final String industry;
  final String userId;
  final String profilePic;
  final String bio;
  final DateTime postTime;
  final String name;
  final String postId;

  JobModel({
    required this.gigs,
    required this.title,
    required this.discrption,
    required this.jobType,
    required this.location,
    required this.industry,
    required this.userId,
    required this.profilePic,
    required this.bio,
    required this.postTime,
    required this.name,
    required this.postId,
  });
  Map<String, dynamic> toMap() {
    return {
      'gigs': gigs,
      'title': title,
      'discrption': discrption,
      'jobType': jobType,
      'location': location,
      'industry': industry,
      'userId': userId,
      'profilePic': profilePic,
      'bio': bio,
      'postTime': postTime,
      'name': name,
      'postId': postId,
    };
  }

  factory JobModel.fromMap(
    Map<String, dynamic> map,
  ) {
    return JobModel(
      gigs: map['gigs'] ?? '',
      title: map['title'] ?? '',
      discrption: map['discrption'] ?? '',
      jobType: map['jobType'] ?? '',
      location: map['location'] ?? '',
      industry: map['industry'] ?? '',
      userId: map['userId'] ?? '',
      profilePic: map['profilePic'] ?? '',
      bio: map['bio'] ?? '',
      postTime: DateTime.fromMillisecondsSinceEpoch(
        map['postTime'],
      ),
      name: map['name'] ?? '',
      postId: map['postId'] ?? '',
    );
  }
}
