import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:halisahaapp/models/chat_messages.dart';
import 'package:halisahaapp/models/current_user.dart';

class ChatDetailPage extends StatefulWidget {
  final CurrentUser currentUser;
  const ChatDetailPage({Key? key, required this.currentUser}) : super(key: key);
  @override
  _ChatDetailPageState createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  late final TextEditingController _messageController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  late String userId = _auth.currentUser!.uid;
  late String originalRefKeyValue;
  late DatabaseReference databaseReference =
      FirebaseDatabase.instance.reference().child("ChatList");
  late DatabaseReference databaseReference2 =
      FirebaseDatabase.instance.reference().child("ChatList");
  late DatabaseReference databaseReferenceChat =
      FirebaseDatabase.instance.reference().child("Chats");
  late StreamSubscription _chatStream;
  bool isReady = false;
  List<ChatMessages> messageList = [];

  Future<void> getAllMessages() async {
    _chatStream = databaseReferenceChat.onValue.listen((event) {
      messageList.clear();
      final DataSnapshot snapshot = event.snapshot;

      if (snapshot.exists) {
        Map<dynamic, dynamic> value = snapshot.value as Map<dynamic, dynamic>;
        value.forEach((key, response) {
          response as Map<dynamic, dynamic>;
          if ((response['idFrom'] == userId &&
                  response['idTo'] == widget.currentUser.id) ||
              (response['idTo'] == userId &&
                  response['idFrom'] == widget.currentUser.id)) {
            messageList.add(ChatMessages(
              timestamp: response['timestamp'],
              idFrom: response['idFrom'],
              idTo: response['idTo'],
              content: response['content'],
              type: response['type'],
            ));
          }
        });
      }
      if (mounted) {
        setState(() {
          isReady = true;
        });
      }
    });
  }

  Future<void> sendMessage() async {
    await databaseReferenceChat.push().set({
      "idFrom": userId,
      "idTo": widget.currentUser.id,
      "timestamp": "1",
      "content": _messageController.text,
      "type": 0,
    });
  }

  Future<void> addChatList() async {
    if (messageList.isEmpty) {
      await databaseReference.child(userId).child(widget.currentUser.id).set({
        "chatId": widget.currentUser.id,
      });
      await databaseReference2.child(widget.currentUser.id).child(userId).set({
        "chatId": userId,
      });
    } else {
      debugPrint("Zaten ekli");
    }
  }

  @override
  void dispose() {
    _chatStream.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    getAllMessages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        flexibleSpace: SafeArea(
          child: Container(
            padding: EdgeInsets.only(right: 16),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                  width: 2,
                ),
                CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://images.unsplash.com/photo-1518791841217-8f162f1e1131?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60"),
                  maxRadius: 20,
                ),
                SizedBox(
                  width: 12,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        widget.currentUser.fullName,
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      Text(
                        "Online",
                        style: TextStyle(
                            color: Colors.grey.shade600, fontSize: 13),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.settings,
                  color: Colors.black54,
                ),
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          ListView.builder(
            itemCount: messageList.length,
            shrinkWrap: true,
            padding: EdgeInsets.only(top: 10, bottom: 10),
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Container(
                padding:
                    EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
                child: Align(
                  alignment: (messageList[index].idTo == userId
                      ? Alignment.topLeft
                      : Alignment.topRight),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: (messageList[index].idTo == userId
                          ? Colors.grey.shade200
                          : Colors.blue[200]),
                    ),
                    padding: EdgeInsets.all(16),
                    child: Text(
                      messageList[index].content,
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ),
              );
            },
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
              height: 60,
              width: double.infinity,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Colors.lightBlue,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      decoration: InputDecoration(
                          hintText: "Write message...",
                          hintStyle: TextStyle(color: Colors.black54),
                          border: InputBorder.none),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      if (_messageController.text.trim().isNotEmpty) {
                        if (messageList.isNotEmpty) {
                          sendMessage();
                          _messageController.clear();
                        } else {
                          sendMessage();
                          addChatList();
                          _messageController.clear();
                        }
                      } else {
                        getAllMessages();
                      }
                    },
                    child: Icon(
                      Icons.send,
                      color: Colors.white,
                      size: 18,
                    ),
                    backgroundColor: Colors.blue,
                    elevation: 0,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
