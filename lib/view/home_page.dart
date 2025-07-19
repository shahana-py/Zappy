import 'package:flutter/material.dart';

import '../widgets/chat_widget.dart';

class ChatScreen extends StatefulWidget {
  final String title;
  final String? apiKey;
  const ChatScreen({super.key,required this.apiKey,required this.title});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[100],
        leading:Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Image(image: AssetImage("assets/images/zappy logo.png"),width: 30,height: 30,),
        ) ,

        // leading: Padding(
        //   padding: const EdgeInsets.all(8.0),
        //   child: Container(
        //     width: 30,
        //     height: 30,
        //     decoration: BoxDecoration(
        //       borderRadius: BorderRadius.circular(10),
        //       color: Colors.pinkAccent[100]
        //     ),
        //     child: Center(
        //       child: Text("Z",style: TextStyle(
        //         color: Colors.blue[800],
        //         fontWeight: FontWeight.bold,
        //         fontSize: 25
        //       ),),
        //     ),
        //   ),
        // ),
        title: Text(widget.title,style: TextStyle(
            color: Colors.blue[800],
            fontWeight: FontWeight.bold,
            fontSize: 25),),
      ),
      body: ChatWidget(apiKey:widget.apiKey),
    );
  }
}
