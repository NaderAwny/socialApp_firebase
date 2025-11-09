// ignore_for_file: file_names

import 'dart:convert';

class SocialUserModel {
  String name;
  String email;
  String phone;
  String uId;
  String? image;
  String? bio;
  bool isEmailverifiled;
  late String cover;
  SocialUserModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.uId,
    required this.isEmailverifiled,
    this.image,
    this.bio,
    required this.cover,
  });

  factory SocialUserModel.fromJson(Map<String, dynamic> map) {
    return SocialUserModel(
      name: map['name']?.toString() ?? '',
      email: map['email']?.toString() ?? '',
      phone: map['phone']?.toString() ?? '',
      uId: map['uId']?.toString() ?? '',
      image: map['image']?.toString(),
      isEmailverifiled: map['isEmailverifiled'] ?? false,
      bio: map['bio'] ?? '',
      cover: map['cover'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'uId': uId,
      'isEmailverifiled': isEmailverifiled,
      'image': image,
      'bio': bio,
      'cover': cover
    };
  }

  String toJson() => json.encode(toMap());

  factory SocialUserModel.fromJson2(String source) =>
      SocialUserModel.fromJson(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SocialUserModel &&
          runtimeType == other.runtimeType &&
          other.uId == uId;

  @override
  int get hashCode => uId.hashCode;
}
