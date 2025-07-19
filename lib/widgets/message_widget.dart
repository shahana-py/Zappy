import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';

class MessageWidget extends StatelessWidget {
  final Image? image;
  final String? text;
  final bool isFromUser;
  const MessageWidget({super.key,this.image,this.text,required this.isFromUser});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isFromUser?MainAxisAlignment.end:MainAxisAlignment.start,
      children: [
        Flexible(child: Container(
          constraints: BoxConstraints(maxWidth: 520),
          decoration: BoxDecoration(
            color: isFromUser?Colors.blue[300]:Colors.blue,
            borderRadius: BorderRadius.circular(10)
          ),
          padding: EdgeInsets.symmetric(
            vertical: 15,
            horizontal: 20
          ),
          margin: EdgeInsets.only(bottom: 20),
          child: Column(
            children: [
              if(text case final text?) MarkdownBody(
                data: text,
              ),
              if(image case final image?) image,
            ],
          ),
        ))
      ],
    );
  }
}
