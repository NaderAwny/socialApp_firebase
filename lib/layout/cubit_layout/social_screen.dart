import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shopapp/layout/cubit_layout/social_cubite.dart';
import 'package:shopapp/layout/cubit_layout/socialstates.dart';
import 'package:shopapp/modules/login.dart';
import 'package:shopapp/modules/shared%20prefersnce.dart';
import 'package:shopapp/social%20App%20screens/newpost.dart';

class socialscreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<socialcubite, sociallayout>(
      listener: (context, state) {
        if (state is NewpostbottomNavstates) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => newpost()),
          );
        }
      },
      builder: (context, state) {
        var cubit = socialcubite.get(context);

        return Scaffold(
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            scrolledUnderElevation: 0,

            title: Text(
              cubit.titles[cubit.currentindex],
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            actions: [
              IconButton(onPressed: () {}, icon: FaIcon(FontAwesomeIcons.bell)),
              IconButton(
                onPressed: () {},
                icon: FaIcon(FontAwesomeIcons.magnifyingGlass),
              ),
            ],
          ),
          body: cubit.uermodel == null
              ? CircularProgressIndicator()
              : cubit.screens[cubit.currentindex],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.grey,
            elevation: 20.0,
            backgroundColor: Colors.white,
            currentIndex: cubit.currentindex,
            onTap: (index) {
              cubit.changebottomNavgator(index);
            },
            items: [
              BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.house),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.commentDots),
                label: 'Chats',
              ),

              BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.commentMedical),
                label: 'post',
              ),

              BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.user),
                label: 'User',
              ),
              BottomNavigationBarItem(
                icon: FaIcon(FontAwesomeIcons.gear),
                label: 'Settings',
              ),
            ],
          ),
          /* 
           model == null
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                 /*   if (!model.isEmailverifiled)
                      Container(
                        color: Colors.amber,
                        height: 50,
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            children: [
                              const Icon(Icons.info_outline),
                              const SizedBox(width: 10),
                              const Text("Please verify your email"),
                              const Spacer(),
                          ElevatedButton(
  onPressed: () async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
        print("Verification email sent!");
      }
    } catch (e) {
      print("Error sending email verification: $e");
    }
  },
  child: Text("Send "),
),
                            ],
                          ),
                        ),
                      ),
                      */




                  ],
                ),
                */
        );
      },
    );
  }
}
 /*  TextButton(
                onPressed: () async {
                  await sharedprof.removeData(key: 'uid');
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => socialloginscreen(),
                    ),
                  );
                },
                child: const Text(
                  "Logout",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              */