import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/auth_cubit/authstates.dart';
import 'package:shopapp/layout/cubit_layout/social_cubite.dart';
import 'package:shopapp/model/model%20social_user.dart';
import 'package:shopapp/modules/on_bording.dart';
import 'package:shopapp/modules/shared%20prefersnce.dart';
import 'package:shopapp/social%20App%20screens/users.dart';

class authcubit extends Cubit<authstates> {
  authcubit() : super(authintialsate());

  final FirebaseAuth _auth = FirebaseAuth.instance;

  static authcubit get(context) => BlocProvider.of(context);
  SocialUserModel? model;

  // Register
  Future<void> registerUser(
    String name,
    String email,
    String password,
    String phone,
   // String image,
  ) async {
    emit(authloading());
    try {
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) {
            usercreate(
              name: name,
              email: email,
              phone: phone,
              uId: value.user!.uid,
              
            );
          });

      emit(authsucessffulregsiter());
    } on FirebaseAuthException catch (e) {
      emit(autherrorregister(e.message.toString()));
    }
  }

  void usercreate({
    required String name,
    required String email,
    required String phone,
    required String uId,
    
  }) {
    SocialUserModel model = SocialUserModel(
      name: name,
      email: email,
      phone: phone,
      uId: uId,
      isEmailverifiled: false,
      image:
          "https://cdn.dribbble.com/userupload/15513632/file/original-e94a3589fa2f0e01762cd8ab6a0e5e59.jpg?resize=1504x1128&vertical=center",

          bio: 'Write you bio...',
          cover: 'https://media.istockphoto.com/id/498688500/vector/webinar-concept.jpg?s=612x612&w=0&k=20&c=SfDxAFwiuhvnPjjVR817qELx88iH6sZmy5L-7dQxt34=',
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
          emit(socialcreateuserssuccfulstate());
        })
        .catchError((error) {
          emit(socialcreateuserserror(error.toString()));
        });
  }

  // Login
  Future<void> loginUser(String email, String password) async {
    emit(authloading());
    try {
      final result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = result.user;
      await sharedprof.savadata(key: 'uid', value: user!.uid);
      emit(authsucessffullogin());
    } on FirebaseAuthException catch (e) {
      emit(autherror(e.message.toString()));
    }
  }

  // Get current user
  User? get currentUser => _auth.currentUser;

  // Logout
  Future<void> logout(context) async {
  try {
    await FirebaseAuth.instance.signOut(); // تسجيل خروج فعلي من Firebase
    await sharedprof.removeData(key: 'uid');
     // مسح uid من التخزين المحلي
   socialcubite.get(context).clearlocaldata();
   
    emit(logoutstates());
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => OnBording()), // أو LoginScreen()
      (route) => false,
    );
  } catch (e) {
    print('Error logging out: $e');
}
}
}
