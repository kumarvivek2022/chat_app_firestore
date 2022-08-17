// ignore_for_file: deprecated_member_use

import 'dart:async';
import 'dart:io';
import 'package:chatapp/helper/constants.dart';
import 'package:chatapp/presentation/chatrooms.dart';
import 'package:chatapp/services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Chat extends StatefulWidget {
  final String chatRoomId;
  Chat({this.chatRoomId});

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {

  Stream<QuerySnapshot> chats;
  TextEditingController messageEditingController = new TextEditingController();
   ScrollController _scrollController =  ScrollController();
   File images;
  Future getImage(bool iscamera) async{
    images = null;
    File image;
    if(iscamera){
      image = await ImagePicker.pickImage(source: ImageSource.camera);
    }
    else{
      image = await ImagePicker.pickImage(source: ImageSource.gallery);
    }
    setState(() {
      images = image;

    });
    if(images!=null){
      showImage(images);
    }else{
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:
      Text(iscamera==true?"Unable to capture image":"Unable to pick image")));
    }

  }

  void showImage(File image){
    showModalBottomSheet<void>(

      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height/2,
          width: MediaQuery.of(context).size.width,
          child: Stack(
            children: [
              Column(
                children: [
                  Expanded(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Image.file(images,
                          fit: BoxFit.cover,),
                      )
                  )
                ],
              ),
              Positioned(
                  bottom: 10,
                  right: 10,
                  child: SizedBox(
                height: 80,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    RaisedButton(onPressed: (){
                      Navigator.pop(context);
                    },
                      color: Colors.black,
                      child: Text("Cancel", style: TextStyle(
                          color: Colors.white
                      ),),),
                    const SizedBox(width: 10,),
                    RaisedButton(onPressed: (){},
                      color: Colors.blue,
                    child: Text("Send", style: TextStyle(
                      color: Colors.white
                    ),),),
                    const SizedBox(width: 10,),
                  ],
                ),
              ))
            ],
          )
        );
      },
    );
  }



  Widget chatMessages({ScrollController controller}){
    return StreamBuilder(
      stream: chats,
      builder: (context, snapshot){
         if(snapshot.hasData){
           WidgetsBinding.instance.addPostFrameCallback((_) {
               _scrollToBottom();
           });
           return Expanded(
             child: ListView.builder(
                 controller: _scrollController,
                 shrinkWrap: true,
                 itemCount: snapshot.data.documents.length,
                 itemBuilder: (context, index){
                   return MessageTile(
                     message: snapshot.data.documents[index].data["message"],
                     sendByMe: Constants.myName == snapshot.data.documents[index].data["sendBy"],
                   );
                 }
             ),
           );
         }else{
        return  CircularProgressIndicator();
         }

      },
    );
  }

  addMessage() {
    if (messageEditingController.text.isNotEmpty) {
      Map<String, dynamic> chatMessageMap = {
        "sendBy": Constants.myName,
        "message": messageEditingController.text,
        'time': DateTime
            .now()
            .millisecondsSinceEpoch,
      };

      DatabaseMethods().addMessage(widget.chatRoomId, chatMessageMap);

      setState(() {
        messageEditingController.text = "";
      });
    }
  }
  bool doneOnce = false;
  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 40), () {
      setState(() {
        doneOnce=true;
      });
    });
    if(doneOnce==false) {
      _scrollController.animateTo(_scrollController.position.maxScrollExtent,
          duration: Duration(seconds: 1), curve: Curves.ease);
    }
  }

  @override
  void initState() {
    DatabaseMethods().getChats(widget.chatRoomId).then((val) {
      setState(() {
        chats = val;
        });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      ///bottomSheet:
      appBar: AppBar(
        title: Center(child: Text('Message',style: TextStyle(fontSize: 25),)),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.topLeft,
                  colors: [
                    Color.fromARGB(225, 157, 112, 229),
                    Colors.blue,
                  ])),
        ),
        leading: Padding(
          padding: const EdgeInsets.only(left: 18),
          child: Row(
            children: [
              InkWell(
                onTap: (){Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => ChatRoom()));},
                child: Icon(Icons.arrow_back_ios),
              ),

            ],
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {  },
            icon: Icon(Icons.videocam_rounded),),
          IconButton(
            onPressed: () {  },
            icon: Icon(Icons.call),),
          IconButton(
            onPressed: () {  },
            icon: Icon(Icons.more_vert),),
        ],
      ),
      body: Container(
        child: Column(
          children: [
            chatMessages(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    height: 60,
                    width: 260,
                    child: TextField(
                      controller: messageEditingController,
                      decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.emoji_emotions),
                          enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(width: 3, color: Colors.blue),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(width: 3, color: Colors.blue),
                            borderRadius: BorderRadius.circular(15),
                          ),

                          suffixIcon: IconButton(
                              onPressed: (){
                                _scrollController.animateTo(_scrollController.position.maxScrollExtent,
                                    duration: Duration(microseconds: 300), curve: Curves.easeOut);
                                addMessage();
                              },
                              icon: Icon(Icons.send)),
                          hintText: "Message ...",
                          hintStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                          border: InputBorder.none
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      getImage(true);
                    },
                      child: Icon(Icons.camera_alt)),
                  InkWell(
                    onTap: () {
                      getImage(false);
                    },
                      child: Icon(Icons.photo_library_outlined)),
                  Icon(Icons.add_circle,color: Color(0xFF6186e6),),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

}

class MessageTile extends StatelessWidget {
  final String message;
  final bool sendByMe;

  MessageTile({@required this.message, @required this.sendByMe});


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: 8,
          bottom: 8,
          left: sendByMe ? 0 : 24,
          right: sendByMe ? 24 : 0),
      alignment: sendByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: sendByMe
            ? EdgeInsets.only(left: 30)
            : EdgeInsets.only(right: 30),
        padding: EdgeInsets.only(
            top: 17, bottom: 17, left: 20, right: 20),
        decoration: BoxDecoration(
            borderRadius: sendByMe ? BorderRadius.only(
                topLeft: Radius.circular(23),
                topRight: Radius.circular(23),
                bottomLeft: Radius.circular(23)
            ) :
            BorderRadius.only(
        topLeft: Radius.circular(23),
          topRight: Radius.circular(23),
          bottomRight: Radius.circular(23)),
            gradient: LinearGradient(
              colors: sendByMe ? [
                const Color(0xff2A75BC),
                const Color(0xba6d4c81),
              ]
                  : [
                const Color(0xA8545654),
                const Color(0xD51E242A)
              ],
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp,
            )
        ),
        child: Text(message,
            textAlign: TextAlign.start,
            style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontFamily: 'OverpassRegular',
            fontWeight: FontWeight.w300)),
      ),
    );
  }
}


