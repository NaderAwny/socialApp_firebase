import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'authstates.dart';
import '../layout/cubit_layout/social_cubite.dart';
import '../model/model%20social_user.dart';
import '../modules/on_bording.dart';
import '../modules/shared%20prefersnce.dart';

class AuthCubit extends Cubit<AuthStates> {
  AuthCubit() : super(AuthInitialState());

  final FirebaseAuth _auth = FirebaseAuth.instance;

  static AuthCubit get(context) => BlocProvider.of(context);
  SocialUserModel? model;

  // Register
  Future<void> registerUser(
    String name,
    String email,
    String password,
    String phone,
    // String image,
  ) async {
    emit(AuthLoading());
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

      emit(AuthSuccessFullRegister());
    } on FirebaseAuthException catch (e) {
      emit(AuthErrorRegister(e.message.toString()));
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
      cover:
          'https://media.istockphoto.com/id/498688500/vector/webinar-concept.jpg?s=612x612&w=0&k=20&c=SfDxAFwiuhvnPjjVR817qELx88iH6sZmy5L-7dQxt34=',
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
      emit(SocialCreateUsersSuccessfulState());
    }).catchError((error) {
      emit(SocialCreateUsersError(error.toString()));
    });
  }

  // Login
  Future<void> loginUser(String email, String password) async {
    emit(AuthLoading());
    try {
      final result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      final user = result.user;
      await SharedProf.savadata(key: 'uid', value: user!.uid);
      emit(AuthSuccessFullLogin());
    } on FirebaseAuthException catch (e) {
      emit(AuthError(e.message.toString()));
    }
  }

  // Get current user
  User? get currentUser => _auth.currentUser;

  // Logout
  Future<void> logout(context) async {
    try {
      await FirebaseAuth.instance.signOut(); // تسجيل خروج فعلي من Firebase
      await SharedProf.removeData(key: 'uid');
      // مسح uid من التخزين المحلي
      SocialCubite.get(context).clearlocaldata();

      emit(LogoutStates());
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
            builder: (context) => OnBording()), // أو LoginScreen()
        (route) => false,
      );
    } catch (e) {
      // Error logging out
    }
  }
}
