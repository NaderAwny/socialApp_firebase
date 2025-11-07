class postuser {
  String name;
  String uId;
  String? image;
  String dateTime;
  String? text;
  String? postimage;

  // جديد:
  int? comments;       // عدد الكومنتات
  String? lastComment; // نص آخر تعليق

  postuser({
    required this.name,
    required this.uId,
    this.image,
    required this.dateTime,
    this.postimage,
    this.text,
    this.comments,
    this.lastComment,
  });

  factory postuser.fromJson(Map<String, dynamic> map) {
    return postuser(
      name: map['name']?.toString() ?? '',
      uId: map['uId']?.toString() ?? '',
      image: map['image']?.toString() ?? '',
      dateTime: map['dateTime']?.toString() ?? '',
      text: map['text']?.toString() ?? '',
      postimage: map['postimage']?.toString() ?? '',
      comments: map['comments'] != null ? (map['comments'] as int) : 0,
      lastComment: map['lastComment']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uId': uId,
      'image': image,
      'dateTime': dateTime,
      'text': text,
      'postimage': postimage,
      'comments': comments ?? 0,
      'lastComment': lastComment ?? '',
};
}
}
