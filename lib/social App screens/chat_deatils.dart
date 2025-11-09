import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../layout/cubit_layout/social_cubite.dart';
import '../layout/cubit_layout/socialstates.dart';
import '../model/messagemodel.dart';
import '../model/model%20social_user.dart';

// ignore: must_be_immutable
class Chatdeatils extends StatelessWidget {
  Chatdeatils({super.key, required this.userModel});
  SocialUserModel userModel;

  final TextEditingController _messagecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //عشان عاوز استدعى حاجه قبل مايبداblock consumer
    return Builder(
      builder: (context) {
        SocialCubite.get(context).getmessage(receiverid: userModel.uId);
        return BlocConsumer<SocialCubite, SocialLayout>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(
                titleSpacing: 0.0,
                title: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      userModel.image != null
                          ? CircleAvatar(
                              radius: 27,
                              backgroundImage: NetworkImage(
                                '${userModel.image}',
                              ),
                            )
                          : Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(25),
                                border: Border.all(
                                  color: Colors.blue,
                                  width: 2,
                                ),
                              ),
                              child: Icon(Icons.person, size: 30),
                            ),
                      SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  userModel.name,
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
              ),
              //  بنلعب على طول list
              body: SocialCubite.get(context).message.isNotEmpty
                  ? Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          Expanded(
                            child: ListView.separated(
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (context, index) {
                                //دى الحظهالى باكد فيها الرساله دى بتاعتى عشان لو بتاعتى تبا على اليمين والعكس صحيح
                                var messagelist =
                                    SocialCubite.get(context).message[index];
                                if (SocialCubite.get(context).uermodel!.uId ==
                                    messagelist.senderid) {
                                  return mymessage(messagelist);
                                }

                                return message(messagelist);
                              },
                              separatorBuilder: (context, index) =>
                                  SizedBox(height: 15),
                              itemCount:
                                  SocialCubite.get(context).message.length,
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey.shade300,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 10,
                                    ),
                                    child: TextFormField(
                                      controller: _messagecontroller,
                                      decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText:
                                            "type yout with message here...",
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  height: 50,
                                  width: 50,
                                  color: Colors.blue,
                                  child: MaterialButton(
                                    onPressed: () {
                                      SocialCubite.get(context).sendmessage(
                                            datetime: DateTime.now().toString(),
                                            text: _messagecontroller.text,
                                            receiverid: userModel.uId,
                                          );
                                    },
                                    child: Icon(
                                      Icons.send,
                                      size: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )
                  : Center(child: CircularProgressIndicator()),
            );
          },
        );
      },
    );
  }

  Widget mymessage(MessageUserModel model) => Align(
        alignment: AlignmentDirectional.centerStart,
        child: Container(
          padding: EdgeInsetsDirectional.symmetric(vertical: 5, horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.grey[300],
            borderRadius: BorderRadiusDirectional.only(
              bottomEnd: Radius.circular(10),
              topEnd: Radius.circular(10),
              topStart: Radius.circular(10),
            ),
          ),
          child: Text("${model.text}"),
        ),
      );

  Widget message(MessageUserModel model) => Align(
        alignment: AlignmentDirectional.centerEnd,
        child: Container(
          padding: EdgeInsetsDirectional.symmetric(vertical: 5, horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.blue.withValues(alpha: 0.2),
            borderRadius: BorderRadiusDirectional.only(
              bottomStart: Radius.circular(10),
              topEnd: Radius.circular(10),
              topStart: Radius.circular(10),
            ),
          ),
          child: Text("${model.text}"),
        ),
      );
}
