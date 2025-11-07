import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shopapp/layout/cubit_layout/socialstates.dart';
import 'package:shopapp/model/messagemodel.dart';
import 'package:shopapp/model/model%20post_user.dart';
import 'package:shopapp/model/model%20social_user.dart';
import 'package:shopapp/modules/on_bording.dart';
import 'package:shopapp/modules/shared%20prefersnce.dart';
import 'package:shopapp/social%20App%20screens/chats.dart';
import 'package:shopapp/social%20App%20screens/feed.dart';
import 'package:shopapp/social%20App%20screens/newpost.dart';
import 'package:shopapp/social%20App%20screens/seetings.dart';
import 'package:shopapp/social%20App%20screens/users.dart';

class socialcubite extends Cubit<sociallayout> {
  socialcubite() : super(socialintialstate());

  static socialcubite get(context) => BlocProvider.of(context);
  SocialUserModel? uermodel;
  void getuserdata() {
    emit(socialloadin());
    var uid = sharedprof.getData(key: 'uid');
    if(uid==null){
      print('no uid found in sharedprefrence');
      emit(socialError(message: 'no uid found'));
      return;
    }

    uermodel=null;
    posts.clear();
    postid.clear();
    likes.clear();
    comment.clear();
    alluser.clear();
    commentsList.clear();
    message.clear();
    FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get()
        .then((value) {
          print(value.data());
          uermodel = SocialUserModel.fromJson(value.data()!);
          emit(socialsufful());
        })
        .catchError((error) {
          print(error);
          emit(socialError(message: error.toString()));
        });
  }

  int currentindex = 0;
  List<Widget> screens = [Feed(), Chats(), newpost(), user(), Seetings()];
  List<String> titles = ['Home', 'chats', 'post', 'Users', 'Settings'];
  void changebottomNavgator(int index) {
    if (index == 0) getpost();
    if (index == 1) getalluers();

    if (index == 2)
      emit(NewpostbottomNavstates());
    else {
      currentindex = index;
      emit(changebottomNavstates());
    }
  }

  File? profileimage;

  Future<void> profile_image() async {
    final iamge = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (iamge != null) {
      profileimage = File(iamge.path);
      print(profileimage);
      emit(socialprofileimagestatesSuccful());
    } else {
      print('NO profileimage select');
      emit(socialprofileimagestatesError());
    }
  }

  File? coverimage;

  Future<void> cover_image() async {
    final iamge = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (iamge != null) {
      coverimage = File(iamge.path);
      print(coverimage);
      emit(socialcoverimagestatesSuccful());
    } else {
      print('NO coverimage select');
      emit(socialcoverimagestatesError());
    }
  }

  void updateprofile({
    required String name,

    required String phone,

    required String bio,
  }) {
    emit(socialupdatstatesloading());
    SocialUserModel model = SocialUserModel(
      name: name,
      email: uermodel!.email,
      phone: phone,
      uId: uermodel!.uId,
      isEmailverifiled: false,
      image: uermodel!.image,

      bio: bio,
      cover: uermodel!.cover,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uermodel!.uId)
        .update(model.toMap())
        .then((value) {
          getuserdata();
        })
        .catchError((error) {
          emit(socialupdatstatesError());
        });
  }

  void createpost({String? dateTime, String? text, String? cover}) {
    emit(socialupdatstatesloading());
    postuser model = postuser(
      name: uermodel!.name,
      image: uermodel?.image,
      postimage: cover,
      text: text,
      dateTime: dateTime ?? DateTime.now().toString(),
      uId: uermodel!.uId,
      // لاحظ: لا تضع comment هنا كسطر نصي — العدّاد هيكون في الفيلد comments
    );

    // نستخدم map مباشر عشان نضمن وجود الحقول comments و lastComment
    FirebaseFirestore.instance
        .collection('posts')
        .add({
          'name': model.name,
          'uId': model.uId,
          'image': model.image,
          'postimage': model.postimage,
          'text': model.text,
          'dateTime': model.dateTime,
          'likes': 0,
          'comments': 0, // عدّاد الكومنتات
          'lastComment': '', // نص آخر تعليق (فاضي افتراضياً)
        })
        .then((value) {
          emit(socialcreatepoststatesSuccful());
        })
        .catchError((error) {
          emit(socialcreatepoststatesError());
        });
  }

  List<postuser> posts = [];
  List<String> postid = [];
  List<int> likes = [];
  List<int> comment = [];

  void getpost() {
    // عشان تظهر loading في الأول
    posts = [];
    FirebaseFirestore.instance
        .collection('posts')
        .orderBy('dateTime', descending: true)
        .get()
        .then((value) async {
          posts.clear();
          postid.clear();
          likes.clear();
          comment.clear();

          // loop على كل بوست
          for (var element in value.docs) {
            // ✅ احسب عدد اللايكات
            var likeSnapshot = await element.reference
                .collection('likes')
                .get();

            // ✅ احسب عدد الكومنتات
            var commentSnapshot = await element.reference
                .collection('comments')
                .get();

            likes.add(likeSnapshot.docs.length);
            comment.add(commentSnapshot.docs.length);

            postid.add(element.id);
            posts.add(postuser.fromJson(element.data()));
          }

          emit(getpostsuccful());
        })
        .catchError((error) {
          emit(getpostError(message: error.toString()));
        });
  }

  // void likehost(String postid,int Index) {
  //   FirebaseFirestore.instance
  //       .collection('posts')
  //       .doc(postid)
  //       .collection('likes')
  //       .doc(uermodel!.uId)
  //       .set({'like': true})
  //       .then((value) {
  //         likes[Index]=likes[Index]+1;
  //         emit(sociallikehostsuccfull());
  //       })
  //       .catchError((Error) {
  //         emit(sociallikehosterror(message: Error.toString()));
  //       });
  // }

  void likehost(String postid, int index) async {
    // بنوصل لملف اللايك الخاص بالمستخدم على البوست ده
    final likeRef = FirebaseFirestore.instance
        .collection('posts')
        .doc(postid)
        .collection('likes')
        .doc(uermodel!.uId);

    // نشوف هل المستخدم ده عمل لايك قبل كده ولا لأ
    final doc = await likeRef.get();

    if (!doc.exists) {
      // أول مرة يعمل لايك → نحفظ اللايك ونزود العدّاد
      await likeRef.set({'like': true});
      likes[index] = likes[index] + 1;
      emit(sociallikehostsuccfull());
    } else {
      // المستخدم ده عمل لايك قبل كده → مانعملش حاجة
      print('User already liked this post before');
    }
  }

  void commenthost(String postId, int index, String commentText) async {
    try {
      final commentsRef = FirebaseFirestore.instance
          .collection('posts')
          .doc(postId)
          .collection('comments');

      // أضف المستند في الـ subcollection (كل تعليق مستند جديد)
      await commentsRef.add({
        'uId': uermodel!.uId,
        'name': uermodel!.name,
        'image': uermodel!.image,
        'text': commentText,
        'dateTime': DateTime.now().toString(),
      });

      // حدّث عداد الكومنتات داخل مستند البوست نفسه باستخدام increment (آمن للـ concurrent)
      final postRef = FirebaseFirestore.instance
          .collection('posts')
          .doc(postId);

      await postRef.update({
        'comments': FieldValue.increment(1),
        'lastComment':
            commentText, // خزّن آخر تعليق عشان تعرضه في الـ Feed بسرعة
      });

      // حدّث العدّادات المحلية داخل الابلكيشن (لو انت بتستخدم المصفوفات المحلية)
      if (index >= 0 && index < comment.length) {
        comment[index] = comment[index] + 1;
      }

      emit(socialcommenthostsuccfull());
    } catch (e) {
      print('commenthost error: $e');
      emit(SocialCommentserror(message: e.toString()));
    }
  }

  List<Map<String, dynamic>> commentsList = [];

  void getComments(String postId) {
    FirebaseFirestore.instance
        .collection('posts')
        .doc(postId)
        .collection('comments')
        .orderBy('dateTime', descending: true)
        .snapshots()
        .listen((event) {
          commentsList = event.docs.map((e) => e.data()).toList();
          emit(SocialCommentsLoaded());
        });
  }

  List<SocialUserModel> alluser = [];

  SocialUserModel? man;
  void getalluers() {
    alluser = [];
    //او if(alluers.length==0)
    FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((value) async {
          posts.clear();
          postid.clear();
          likes.clear();
          comment.clear();

          // loop على كل بوست
          for (var element in value.docs) {
            // ✅ احسب عدد اللايكات
            if (element.data()['uId'] != uermodel!.uId)
              //السطر الى فوق عشان فى الشات يعرض كل المستخدمين غيرى يعنى هيضيف كل المستخدمين غيرى صاحب الحساب
              alluser.add(SocialUserModel.fromJson(element.data()));
          }

          emit(getalluerssuccful());
        })
        .catchError((error) {
          emit(getallusersError(message: error.toString()));
        });
  }

  void sendmessage({
    required String datetime,
    required String text,
    required String receiverid,
    // required String senderid,
    //senderid معايا مش محتاج اجيبه من بره الى هو
    //uidبتاعى الى فى
    //usermodel
  }) {
    messageUserModel model = messageUserModel(
      datetime: datetime,
      text: text,
      receiverid: receiverid,
      senderid: uermodel!.uId,
    );
    //set my chats
    FirebaseFirestore.instance
        .collection('users')
        .doc(uermodel!.uId)
        .collection('chats')
        .doc(receiverid)
        .collection('message')
        .add(model.toMap())
        .then((value) {
          emit(sendmessagestatessuccfull());
        })
        .catchError((error) {
          emit(sendmessagestatesError(message: error.toString()));
        });
    //set receiver chats
    FirebaseFirestore.instance
        .collection('users')
        .doc(receiverid)
        .collection('chats')
        .doc(uermodel!.uId)
        .collection('message')
        .add(model.toMap())
        .then((value) {
          emit(sendmessagestatessuccfull());
        })
        .catchError((error) {
          emit(sendmessagestatesError(message: error.toString()));
        });
  }

  List<messageUserModel> message=[];
  void getmessage({required String receiverid}) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(uermodel!.uId)
        .collection('chats')
        .doc(receiverid)
        .collection('message')
        .orderBy('datetime')
        .snapshots()
        .listen((event) {
          //not double from date*2
          message=[];

event.docs.forEach((element){

message.add(messageUserModel.fromJson(element.data()));


});
emit(getmessagestatessuccfull());
        });
  }
  void clearlocaldata(){

     uermodel=null;
    posts.clear();
    postid.clear();
    likes.clear();
    comment.clear();
    alluser.clear();
    commentsList.clear();
    message.clear();
  }
}
