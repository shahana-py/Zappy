// import 'package:flutter/material.dart';
// import 'package:flutter_markdown/flutter_markdown.dart';
//
// class MessageWidget extends StatelessWidget {
//   final Image? image;
//   final String? text;
//   final bool isFromUser;
//   const MessageWidget({super.key,this.image,this.text,required this.isFromUser});
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: isFromUser?MainAxisAlignment.end:MainAxisAlignment.start,
//       children: [
//         Flexible(child: Container(
//           constraints: BoxConstraints(maxWidth: 520),
//           decoration: BoxDecoration(
//             border: Border.all(color: Colors.black54),
//             color: isFromUser?Colors.white30:Colors.white30,
//             borderRadius: BorderRadius.circular(10)
//           ),
//           padding: EdgeInsets.symmetric(
//             vertical: 15,
//             horizontal: 20
//           ),
//           margin: EdgeInsets.only(bottom: 20),
//           child: Column(
//             children: [
//               if(text case final text?) MarkdownBody(
//                 data: text,
//               ),
//               if(image case final image?) image,
//             ],
//           ),
//         ))
//       ],
//     );
//   }
// }


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
            // Enhanced shadow for depth
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 8,
                offset: Offset(0, 2),
              ),
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 20,
                offset: Offset(0, 8),
              ),
            ],
            // Improved gradient backgrounds that blend with blue[100]
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: isFromUser
                  ? [
                Color(0xFF3B82F6).withOpacity(0.9), // Blue-500
                Color(0xFF1D4ED8).withOpacity(0.85), // Blue-700
              ]
                  : [
                Color(0xFFDBEAFE), // Blue-100
                Color(0xFFF1F8FF), // Very light blue tint
              ],
            ),
            // Subtle border with blue tones
            border: Border.all(
              color: isFromUser
                  ? Color(0xFF3B82F6).withOpacity(0.3)
                  : Color(0xFFBFDBFE), // Blue-200
              width: 1,
            ),
            // More refined border radius
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18),
              topRight: Radius.circular(18),
              bottomLeft: Radius.circular(isFromUser ? 18 : 4),
              bottomRight: Radius.circular(isFromUser ? 4 : 18),
            ),
          ),
          padding: EdgeInsets.symmetric(
              vertical: 16,
              horizontal: 20
          ),
          margin: EdgeInsets.only(bottom: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if(text case final text?)
                Theme(
                  data: Theme.of(context).copyWith(
                    textTheme: Theme.of(context).textTheme.copyWith(
                      bodyMedium: TextStyle(
                        color: isFromUser ? Colors.white : Color(0xFF1E3A8A), // Blue-900
                        fontSize: 15,
                        height: 1.5,
                        fontWeight: FontWeight.w400,
                      ),
                      headlineSmall: TextStyle(
                        color: isFromUser ? Colors.white : Color(0xFF1E40AF), // Blue-800
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        height: 1.3,
                      ),
                      titleMedium: TextStyle(
                        color: isFromUser ? Colors.white : Color(0xFF1D4ED8), // Blue-700
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        height: 1.4,
                      ),
                    ),
                  ),
                  child: MarkdownBody(
                    data: text,
                    styleSheet: MarkdownStyleSheet(
                      p: TextStyle(
                        color: isFromUser ? Colors.white.withOpacity(0.95) : Color(0xFF1E3A8A), // Blue-900
                        fontSize: 15,
                        height: 1.5,
                      ),
                      h1: TextStyle(
                        color: isFromUser ? Colors.white : Color(0xFF1E40AF), // Blue-800
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        height: 1.3,
                      ),
                      h2: TextStyle(
                        color: isFromUser ? Colors.white : Color(0xFF1E40AF), // Blue-800
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        height: 1.3,
                      ),
                      code: TextStyle(
                        backgroundColor: isFromUser
                            ? Colors.white.withOpacity(0.15)
                            : Color(0xFFF0F9FF), // Blue-50
                        color: isFromUser ? Colors.white : Color(0xFF1E40AF), // Blue-800
                        fontFamily: 'monospace',
                        fontSize: 14,
                      ),
                      codeblockDecoration: BoxDecoration(
                        color: isFromUser
                            ? Colors.white.withOpacity(0.1)
                            : Color(0xFFF0F9FF), // Blue-50
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: isFromUser
                              ? Colors.white.withOpacity(0.2)
                              : Color(0xFFBFDBFE), // Blue-200
                        ),
                      ),
                      blockquoteDecoration: BoxDecoration(
                        color: isFromUser
                            ? Colors.white.withOpacity(0.1)
                            : Color(0xFFF0F9FF), // Blue-50
                        borderRadius: BorderRadius.circular(4),
                        border: Border(
                          left: BorderSide(
                            color: isFromUser ? Colors.white : Color(0xFF3B82F6), // Blue-500
                            width: 3,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              if(image case final image?)
                Container(
                  margin: EdgeInsets.only(top: text != null ? 12 : 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: image,
                ),
            ],
          ),
        ))
      ],
    );
  }
}
