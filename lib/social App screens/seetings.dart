import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/auth_cubit/authcubit.dart';
import 'package:shopapp/auth_cubit/authstates.dart';
import 'package:shopapp/layout/cubit_layout/social_cubite.dart';
import 'package:shopapp/layout/cubit_layout/socialstates.dart';
import 'package:shopapp/modules/login.dart';
import 'package:shopapp/modules/on_bording.dart';
import 'package:shopapp/social%20App%20screens/edit_profile.dart';

class Seetings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<socialcubite, sociallayout>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        var usermodel = socialcubite.get(context).uermodel;
       
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Center(
                    child: Stack(
                      clipBehavior:
                          Clip.none, // علشان الـ avatar يطلع بره الـ container
                      alignment: Alignment.center,
                      children: [
                        // الخلفية الأساسية
                        Container(
                          height: 160,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                            ),
                            image: DecorationImage(
                              image: NetworkImage('${usermodel?.cover}'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),

                        // CircleAvatar نازل شوية من النص التحت
                        Positioned(
                          bottom: -40, // بينزلها نصها تحت الكنتينر
                          child: Container(
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Theme.of(
                                  context,
                                ).scaffoldBackgroundColor, // لون البوردر زي خلفية التطبيق
                                width: 4,
                              ),
                            ),
                            child: CircleAvatar(
                              radius: 55,

                              backgroundColor: Colors.blueGrey,
                              backgroundImage: NetworkImage(
                                '${usermodel?.image}',
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 45),
                  Text(
                    "${usermodel?.name}",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(height: 3),
                  Text(
                    "${usermodel?.bio}",
                    style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
                  ),
                  SizedBox(height: 20),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 17),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 17),
                          child: InkWell(
                            onTap: () {},
                            child: Column(
                              children: [
                                Text(
                                  "100",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  "post",
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(width: 28),
                        InkWell(
                          onTap: () {},
                          child: Column(
                            children: [
                              Text(
                                "265",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "Photos",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(width: 35),
                        InkWell(
                          onTap: () {},
                          child: Column(
                            children: [
                              Text(
                                "10K",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "Followers",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(width: 40),
                        InkWell(
                          onTap: () {},
                          child: Column(
                            children: [
                              Text(
                                "64",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "Followings",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 25),

                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {},
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                                width: 0.9,
                              ),
                              borderRadius: BorderRadius.circular(5),
                            ),

                            child: Center(
                              child: Text(
                                "Add photos",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 15),

                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditProfile(),
                            ),
                          );
                        },
                        child: Container(
                          height: 40,
                          width: 50,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 0.9),
                            borderRadius: BorderRadius.circular(5),
                          ),

                          child: Center(
                            child: Icon(
                              CupertinoIcons.square_pencil,
                              size: 15,
                              color: Colors.blue,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 40),

                  TextButton(
                    onPressed: () {
                      authcubit.get(context).logout(context);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Logut",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: Colors.red,
                          ),
                        ),
                        Icon(Icons.logout, color: Colors.red),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      
  }
}
