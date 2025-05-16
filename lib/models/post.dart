class Post {
  final String header;
  final String body;
  final DateTime createdAt;

  Post({required this.header, required this.body, required this.createdAt});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      header: json['header'],
      body: json['body'],
      createdAt: DateTime.parse(json['createdAt']),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'header': header,
      'body': body,
      'createdAt': createdAt.toUtc().toIso8601String(),
    };
  }
}
