import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopapp/layout/cubit_layout/social_cubite.dart';
import 'package:shopapp/layout/cubit_layout/socialstates.dart';
import 'package:shopapp/model/model%20post_user.dart';

class CreateCommentScreen extends StatefulWidget {
  final String postId;
  final int index;

  const CreateCommentScreen({
    Key? key,
    required this.postId,
    required this.index, required postuser postuser,
  }) : super(key: key);

  @override
  State<CreateCommentScreen> createState() => _CreateCommentScreenState();
}

class _CreateCommentScreenState extends State<CreateCommentScreen> {
  final TextEditingController _commentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // بننادي الدالة عشان نجيب الكومنتات أول ما الصفحة تفتح
    socialcubite.get(context).getComments(widget.postId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<socialcubite, sociallayout>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = socialcubite.get(context);

        return Scaffold(
          appBar: AppBar(
            title: const Text('Comments'),
            backgroundColor: Colors.blue,
          ),
          body: Column(
            children: [
              // ✅ عرض الكومنتات الموجودة
              Expanded(
                child: cubit.commentsList.isEmpty
                    ? const Center(
                        child: Text(
                          'No comments yet',
                          style: TextStyle(color: Colors.grey),
                        ),
                      )
                    : ListView.builder(
                        itemCount: cubit.commentsList.length,
                        itemBuilder: (context, i) {
                          var comment = cubit.commentsList[i];
                          return ListTile(
                            leading: CircleAvatar(
                              backgroundImage: comment['image'] != null &&
                                      comment['image'] != ''
                                  ? NetworkImage(comment['image'])
                                  : const AssetImage(
                                          'assets/images/default_profile.png')
                                      as ImageProvider,
                            ),
                            title: Text(
                              comment['name'] ?? 'Unknown User',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                            subtitle: Text(
                              comment['text'] ?? '',
                              style: const TextStyle(fontSize: 13),
                            ),
                            trailing: Text(
                              comment['dateTime'] != null
                                  ? comment['dateTime']
                                      .toString()
                                      .split(' ')
                                      .first
                                  : '',
                              style: TextStyle(
                                  fontSize: 10, color: Colors.grey[600]),
                            ),
                          );
                        },
                      ),
              ),

              // ✅ إدخال تعليق جديد
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                color: Colors.grey[200],
                child: Row(
                  children: [
                    // صورة المستخدم (لو عندك)
                    CircleAvatar(
                      radius: 20,
                      backgroundImage: cubit.uermodel?.image != null
                          ? NetworkImage(cubit.uermodel!.image!)
                          : const AssetImage(
                                  'assets/images/default_profile.png')
                              as ImageProvider,
                    ),
                    const SizedBox(width: 10),

                    // مربع الكتابة
                    Expanded(
                      child: TextField(
                        controller: _commentController,
                        decoration: const InputDecoration(
                          hintText: 'Write a comment...',
                          border: InputBorder.none,
                        ),
                      ),
                    ),

                    // زر الإرسال
                    IconButton(
                      icon: const Icon(Icons.send, color: Colors.blue),
                      onPressed: () {
                        final text = _commentController.text.trim();
                        if (text.isNotEmpty) {
                          cubit.commenthost(
                            widget.postId,
                            widget.index,
                            text,
                          );
                          _commentController.clear();
                        }
                      },
                    ),
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
