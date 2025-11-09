import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../layout/cubit_layout/social_cubite.dart';
import '../layout/cubit_layout/socialstates.dart';
import '../model/model%20social_user.dart';
import '../social%20App%20screens/chat_deatils.dart';

class Chats extends StatelessWidget {
  const Chats({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubite, SocialLayout>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        return SocialCubite.get(context).alluser.isNotEmpty
            ? ListView.separated(
                physics: BouncingScrollPhysics(),
                itemBuilder: (context, index) => bulidchats(
                    SocialCubite.get(context).alluser[index], context),
                separatorBuilder: (context, index) => Container(
                  width: double.infinity,
                  height: 1,
                  color: Colors.grey,
                ),
                itemCount: SocialCubite.get(context).alluser.length,
              )
            : Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget bulidchats(SocialUserModel model, context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => Chatdeatils(
                      userModel: model,
                    )));
      },
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Row(
          children: [
            model.image != null
                ? CircleAvatar(
                    radius: 27,
                    backgroundImage: NetworkImage('${model.image}'),
                  )
                : Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(25),
                      border: Border.all(color: Colors.blue, width: 2),
                    ),
                    child: Icon(
                      Icons.person,
                      size: 30,
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
                        model.name,
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
