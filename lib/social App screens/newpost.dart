import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../layout/cubit_layout/social_cubite.dart';
import '../layout/cubit_layout/socialstates.dart';

class NewPost extends StatefulWidget {
  const NewPost({super.key});

  @override
  State<NewPost> createState() => _NewPostState();
}

class _NewPostState extends State<NewPost> {
  final TextEditingController _textController = TextEditingController();
  bool showCover = false; // الحالة اللي بتحدد هل نعرض cover ولا لأ

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubite, SocialLayout>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = SocialCubite.get(context);
        var usermodel = cubit.uermodel;

        return Scaffold(
          appBar: AppBar(
            title: const Text('Create Post'),
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
                    DateTime now = DateTime.now();

                    /// لو showCover = true يبعت الصورة
                    /// لو false يبعت ""
                    cubit.createpost(
                      dateTime: now.toString(),
                      text: _textController.text,
                      cover: showCover ? usermodel!.cover : "",
                    );
                  },
                  child: const Text(
                    "POST",
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// ------- user info --------
                Row(
                  children: [
                    CircleAvatar(
                      radius: 27,
                      backgroundImage: NetworkImage("${usermodel!.image}"),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      usermodel.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),

                /// ------- Text field --------
                Expanded(
                  child: TextFormField(
                    controller: _textController,
                    decoration: const InputDecoration(
                      hintText: 'What is on your mind?',
                      border: InputBorder.none,
                    ),
                  ),
                ),

                /// ------- show cover if selected --------
                if (showCover)
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
                            image: NetworkImage(usermodel.cover),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            showCover = false; // يشيل الصورة لو عايز يخفيها
                          });
                        },
                        icon: const Icon(
                          Icons.close,
                          size: 30,
                          color: Colors.redAccent,
                        ),
                      ),
                    ],
                  ),

                /// ------- buttons (Add photo + tags) --------
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextButton(
                          onPressed: () {
                            setState(() {
                              showCover = !showCover; // يبدّل الحالة
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.image_outlined,
                                color: Colors.blue,
                                size: 20,
                              ),
                              const SizedBox(width: 5),
                              Text(
                                showCover ? 'Remove photo' : 'Add photo',
                                style: const TextStyle(color: Colors.blue),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextButton(
                          onPressed: () {},
                          child: const Text(
                            '# tags',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
