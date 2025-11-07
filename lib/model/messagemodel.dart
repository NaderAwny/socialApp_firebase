import 'dart:convert';

class messageUserModel {
  String? datetime;
  String? text;
  String? receiverid;
  String? senderid;

  messageUserModel({this.datetime, this.text, this.receiverid, this.senderid});

  factory messageUserModel.fromJson(Map<String, dynamic> map) {
    return messageUserModel(
      datetime: map['datetime']?.toString() ?? '',
      text: map['text']?.toString() ?? '',
      receiverid: map['receiverid']?.toString() ?? '',
      senderid: map['senderid']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'datetime': datetime,
      'text': text,
      'receiverid': receiverid,
      'senderid': senderid,
    };
  }
}
