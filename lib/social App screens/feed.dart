import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shopapp/layout/cubit_layout/social_cubite.dart';
import 'package:shopapp/layout/cubit_layout/socialstates.dart';
import 'package:shopapp/model/model%20post_user.dart';
import 'package:shopapp/social%20App%20screens/createcomment.dart';
import 'package:intl/intl.dart';
class Feed extends StatelessWidget {
  const Feed({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<socialcubite, sociallayout>(
      listener: (context, state) {},
      builder: (context, state) {
        return socialcubite.get(context).posts.length > 0 &&
                socialcubite.get(context).uermodel != null
            ? Padding(
                padding: const EdgeInsets.all(10),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // أول بوست
                      Card(
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        elevation: 5.0,
                        margin: EdgeInsets.all(8),
                        child: Stack(
                          alignment: AlignmentDirectional.bottomEnd,
                          children: [
                            Image.asset(
                              'assets/image/home.jpg',
                              height: 200,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                'communicate with friends',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) => bulidpostitem(
                          socialcubite.get(context).posts[index],
                          context,
                          index,
                        ),
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 8),
                        itemCount: socialcubite.get(context).posts.length,
                      ),
                      SizedBox(height: 8),
                    ],
                  ),
                ),
              )
            : Center(child: CircularProgressIndicator());
      },
    );
  }

  // post user
  Widget bulidpostitem(postuser model, context, Index) => Card(
    clipBehavior: Clip.antiAliasWithSaveLayer,
    elevation: 5.0,
    margin: EdgeInsets.symmetric(horizontal: 8),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // العنوان (صورة + الاسم)
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: CircleAvatar(
                radius: 27,
                backgroundImage: NetworkImage('${model.image}'),
              ),
            ),
            SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        "${model.name}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          height: 1.5,
                        ),
                      ),
                      SizedBox(width: 5),
                      Icon(
                        Icons.check_circle,
                        color: Color.fromARGB(255, 21, 132, 223),
                        size: 16,
                      ),
                    ],
                  ),
                  Text(
                    _formatDate(model.dateTime),
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.more_horiz, size: 20),
            ),
          ],
        ),

        // فاصل رمادي
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15.0),
          child: Container(
            width: double.infinity,
            height: 1,
            color: Colors.grey[300],
          ),
        ),

        // نص البوست
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            '${model.text}',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
        ),

        // الهاشتاجات
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Wrap(
            children: [
              MaterialButton(
                onPressed: () {},
                minWidth: 1,
                padding: EdgeInsets.zero,
                child: Text(
                  '#software',
                  style: TextStyle(
                    color: Color.fromARGB(255, 21, 132, 223),
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              MaterialButton(
                onPressed: () {},
                minWidth: 1,
                padding: EdgeInsets.zero,
                child: Text(
                  '#flutter',
                  style: TextStyle(
                    color: Color.fromARGB(255, 21, 132, 223),
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
        // صورة داخل البوست
        if (model.postimage != "")
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Container(
              height: 140,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                image: DecorationImage(
                  image: NetworkImage('${model.postimage}'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

        // صف الإعجابات والتعليقات
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Row(
            children: [
              Expanded(
                child: InkWell(
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: FaIcon(
                          FontAwesomeIcons.heart,
                          size: 18,
                          color: Colors.red,
                        ),
                      ),
                      Text(
                        '${socialcubite.get(context).likes[Index]}',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: FaIcon(
                            FontAwesomeIcons.commentDots,
                            size: 18,
                            color: Colors.amber,
                          ),
                        ),
                        Text(
                          '${socialcubite.get(context).comment[Index]}comment',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey[600],
                          ),
                        ),
                        // if (model.lastComment != null &&
                        //     model.lastComment!.isNotEmpty)
                        //   Padding(
                        //     padding: const EdgeInsets.symmetric(
                        //       horizontal: 8.0,
                        //       vertical: 4,
                        //     ),
                        //     child: Text(
                        //       'Last: ${model.lastComment}',
                        //       style: TextStyle(
                        //         fontSize: 12,
                        //         color: Colors.grey[700],
                        //       ),
                        //     ),
                        //   ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),

        // فاصل
        Container(width: double.infinity, height: 1, color: Colors.grey[300]),

        // كتابة تعليق
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      CreateCommentScreen(index: Index, postuser: model, postId:socialcubite.get(context).postid[Index],),
                ),
              );
            },
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: CircleAvatar(
                    radius: 18,
                    backgroundImage: NetworkImage(
                      '${socialcubite.get(context).uermodel?.image}',
                    ),
                  ),
                ),
                
                SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Write to comment...'),
                      Text(
                        'Last comment: ${model.lastComment}',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ),
                ),

                Row(
                  children: [
                    InkWell(
                      onTap: () {
                        socialcubite
                            .get(context)
                            .likehost(
                              socialcubite.get(context).postid[Index],
                              Index,
                            );
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: FaIcon(
                                FontAwesomeIcons.heart,
                                size: 18,
                                color: Colors.red,
                              ),
                            ),
                            Text(
                              'like',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );

String _formatDate(String dateTimeString) {
  try {
    // نحول النص اللي جاي من Firebase لـ DateTime
    DateTime dateTime = DateTime.parse(dateTimeString);

    // نستخدم intl عشان نعمل format
    String formatted = DateFormat('dd/MM/yyyy – hh:mm a').format(dateTime);

    return formatted;
  } catch (e) {
    // لو حصل خطأ (زي قيمة فاضية أو null)
    return dateTimeString;
}
}


}
