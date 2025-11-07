import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shopapp/layout/cubit_layout/social_cubite.dart';
import 'package:shopapp/layout/cubit_layout/socialstates.dart';

class EditProfile extends StatelessWidget {
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _bioController = TextEditingController();

  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<socialcubite, sociallayout>(
      listener: (context, state) {},
      builder: (context, state) {
        var usermodel = socialcubite.get(context).uermodel;
        var profileimage = socialcubite.get(context).profileimage;

        var coverimage = socialcubite.get(context).coverimage;
        _nameController.text = usermodel!.name;
        _bioController.text = usermodel.bio!;
        _phoneController.text = usermodel.phone;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Edit Profile'),
            titleSpacing: 0,
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_left, size: 35),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: TextButton(
                  onPressed: () {
                    socialcubite
                        .get(context)
                        .updateprofile(
                          name: _nameController.text,
                          phone: _phoneController.text,
                          bio: _bioController.text,
                        );
                  },
                  child: const Text(
                    "UPDATE",
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Center(
                    child: Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.center,
                      children: [
                        // Cover photo
                        Stack(
                          alignment: AlignmentDirectional.topEnd,
                          children: [
                            Container(
                              height: 160,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  topRight: Radius.circular(12),
                                ),
                                image: DecorationImage(
                                  image: coverimage == null
                                      ? NetworkImage('${usermodel.cover}')
                                      : FileImage(coverimage),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                socialcubite.get(context).cover_image();
                                print("cover camera clicked");
                              },
                              icon: const Icon(
                                CupertinoIcons.camera_circle_fill,
                                size: 35,
                                color: Colors.deepOrange,
                              ),
                            ),
                          ],
                        ),

                        // Profile photo + camera icon
                        Positioned(
                          bottom: -45,
                          child: Stack(
                            alignment: Alignment.bottomRight,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Theme.of(
                                      context,
                                    ).scaffoldBackgroundColor,
                                    width: 4,
                                  ),
                                ),

                                child: GestureDetector(
                                  onTap: () {
                                    socialcubite.get(context).profile_image();

                                    print("man");
                                  },
                                  child: CircleAvatar(
                                    radius: 55,
                                    backgroundColor: Colors.blueGrey,
                                    backgroundImage: profileimage == null
                                        ? NetworkImage('${usermodel.image}')
                                        : FileImage(profileimage),
                                  ),
                                ),
                              ),

                              // ✅ أيكونة الكاميرا اللي بيداس عليها فعلاً
                              Container(
                                padding: const EdgeInsets.all(3),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  CupertinoIcons.camera_circle_fill,
                                  size: 25,
                                  color: Colors.deepOrange,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 60),

                  TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: "Name",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      prefixIcon: Icon(Icons.person),
                    ),
                    validator: (value) =>
                        value!.isEmpty ? "Enter your name" : null,
                  ),

                  SizedBox(height: 10),

                  TextFormField(
                    controller: _bioController,
                    decoration: InputDecoration(
                      labelText: "Bio",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      prefixIcon: Icon(Icons.info),
                    ),
                    validator: (value) =>
                        value!.isEmpty ? "Enter your bio" : null,
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _phoneController,
                    decoration: InputDecoration(
                      labelText: "phone",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      prefixIcon: Icon(Icons.call),
                    ),
                    validator: (value) =>
                        value!.isEmpty ? "Enter your phone" : null,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
