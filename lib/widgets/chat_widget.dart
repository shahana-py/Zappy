// import 'package:flutter/material.dart';
// import 'package:generative_ai_dart/generative_ai_dart.dart';
// import 'package:image_picker/image_picker.dart';
//
// import 'message_widget.dart';
//
// class ChatWidget extends StatefulWidget {
//   final String? apiKey;
//   const ChatWidget({super.key, required this.apiKey});
//
//   @override
//   State<ChatWidget> createState() => _ChatWidgetState();
// }
//
// class _ChatWidgetState extends State<ChatWidget> {
//   late final GenerativeModel _model;
//   late final ChatSession _chat;
//
//   final ScrollController _scrollController=ScrollController();
//   bool _loading=false;
//   final TextEditingController _textController = TextEditingController();
//   final FocusNode _textFieldFocus = FocusNode();
//   final List<({Image? image, String? text, bool fromUser})> _generatedContent =
//       [];
//
//   @override
//   void initState() {
//     _model = GenerativeModel(
//       model:'gemini-1.5-flash-latest',
//       apiKey:widget.apiKey ??''
//     );
//     _chat=_model.startChat();
//     super.initState();
//   }
//   void _scrollDown(){
//     WidgetsBinding.instance.addPostFrameCallback(
//         (_)=>_scrollController.animateTo(
//             _scrollController.position.maxScrollExtent,
//             duration: const Duration(microseconds: 750),
//             curve: Curves.easeInOutCirc)
//     );
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Expanded(
//               child: widget.apiKey?.isNotEmpty ?? false
//                   ? ListView.builder(
//                 controller: _scrollController,
//                 itemCount: _generatedContent.length,
//                   itemBuilder: (context, index) {
//                       final content = _generatedContent[index];
//                       return MessageWidget(
//                         text: content.text,
//                         image: content.image,
//                         isFromUser: content.fromUser,
//                       );
//                     })
//                   : ListView(
//                       children: const [Text("No API key found")],
//                     )),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     onSubmitted:_sendMessage,
//                     autofocus: true,
//                     focusNode: _textFieldFocus,
//                     controller: _textController,
//                     decoration: InputDecoration(
//                         contentPadding: EdgeInsets.all(15.0),
//                         hintText: "How can I help you today",
//                         border: OutlineInputBorder(
//                             borderRadius:
//                                 const BorderRadius.all(Radius.circular(15)),
//                             borderSide: BorderSide(
//                                 color:
//                                     Theme.of(context).colorScheme.secondary)),
//                         focusedBorder: OutlineInputBorder(
//                             borderRadius:
//                                 const BorderRadius.all(Radius.circular(15)),
//                             borderSide: BorderSide(
//                                 color:
//                                     Theme.of(context).colorScheme.secondary))),
//                   ),
//                 ),
//                 const SizedBox.square(
//                   dimension: 15,
//                 ),
//                 IconButton(
//                     onPressed: () {
//                       _pickImage();
//
//                     },
//                     icon: Icon(
//                       Icons.image,
//                       color: Theme.of(context).colorScheme.secondary,
//                     )),
//                 if(!_loading)
//                 IconButton(
//                     onPressed: () {
//                       _sendMessage(_textController.text);
//                     },
//                     icon: Icon(
//                       Icons.send,
//                       color: Theme.of(context).colorScheme.secondary,
//                     ))
//                 else
//                   const CircularProgressIndicator()
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
//   Future<void>_sendMessage(String message) async {
//     setState(() {
//       _loading = true;
//     });
//     try {
//       _generatedContent.add((image:null, text: message, fromUser:true));
//       final response = await _chat.sendMessage(
//         Content.text(message),
//       );
//       final text = response.text;
//       _generatedContent.add((image:null, text: text, fromUser:false) as ({bool fromUser, Image? image, String? text}));
//
//     if (text == null) {
//       showError("No Response from Zappy");
//       return;
//     } else {
//       setState(() {
//         _loading = false;
//         _scrollDown();
//       });
//     }
//   }catch (e){
//       showError(e.toString());
//       setState(() {
//         _loading=false;
//       });
//     }finally {
//       _textController.clear();
//       setState(() {
//         _loading=false;
//       });
//       _textFieldFocus.requestFocus();
//     }
//   }
//
//   Future<dynamic> showError(String message) {
//     return showDialog(context: context, builder: (context){
//       return AlertDialog(
//         title: Text("Something went wrong"),
//         content: SingleChildScrollView(
//           child: SelectableText(message),
//         ),
//         actions: [
//           TextButton(onPressed: (){
//             Navigator.of(context).pop();
//           }, child: Text("OK"))
//         ],
//       );
//     });
//   }
//   Future<void> _pickImage()async{
//     final ImagePicker _picker=ImagePicker();
//     final XFile? image=await _picker.pickImage(source:ImageSource.gallery);
//   if(image != null){
//     setState(() {
//       _loading=true;
//     });
//     try{
//       final bytes=await image.readAsBytes();
//       final content=[
//         Content.multi([
//           TextPart(_textController.text),
//           dataPart('image.jpeg',bytes)
//         ])
//       ];
//       _generatedContent.add((
//       text: _textController.text,
//       image: Image.memory(bytes),
//       fromUser=true,
//       ));
//       var response=await _model.generateContent(content);
//       var text=response.text;
//       _generatedContent.add((image:null, text: text, fromUser:false) as ({bool fromUser, Image? image, String? text}));
//       if (text == null) {
//         showError("No Response from Zappy");
//         return;
//       } else {
//         setState(() {
//           _loading = false;
//           _scrollDown();
//         });
//       }
//     }catch (e){
//       showError(e.toString());
//       setState(() {
//         _loading=false;
//       });
//     }finally {
//       _textController.clear();
//       setState(() {
//         _loading=false;
//       });
//       _textFieldFocus.requestFocus();
//     }
//   }
//   }
//
//
// }


// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:google_generative_ai/google_generative_ai.dart';
// import 'package:image_picker/image_picker.dart';
//
// import 'message_widget.dart';
//
// class ChatWidget extends StatefulWidget {
//   final String? apiKey;
//   const ChatWidget({super.key, required this.apiKey});
//
//   @override
//   State<ChatWidget> createState() => _ChatWidgetState();
// }
//
// class _ChatWidgetState extends State<ChatWidget> {
//   late final GenerativeModel _model;
//   late final ChatSession _chat;
//
//   final ScrollController _scrollController = ScrollController();
//   bool _loading = false;
//   final TextEditingController _textController = TextEditingController();
//   final FocusNode _textFieldFocus = FocusNode();
//   final List<({Image? image, String? text, bool fromUser})> _generatedContent = [];
//
//   @override
//   void initState() {
//     super.initState();
//     if (widget.apiKey != null && widget.apiKey!.isNotEmpty) {
//       _model = GenerativeModel(
//         model: 'gemini-1.5-flash', // Replacing 'gemini-pro-vision' with the new model
//         apiKey: widget.apiKey!,
//       );
//       _chat = _model.startChat();
//     }
//   }
//
//   void _scrollDown() {
//     WidgetsBinding.instance.addPostFrameCallback(
//           (_) => _scrollController.animateTo(
//         _scrollController.position.maxScrollExtent,
//         duration: const Duration(milliseconds: 750),
//         curve: Curves.easeInOutCirc,
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Column(
//         children: [
//           Expanded(
//             child: widget.apiKey?.isNotEmpty ?? false
//                 ? ListView.builder(
//               controller: _scrollController,
//               itemCount: _generatedContent.length,
//               itemBuilder: (context, index) {
//                 final content = _generatedContent[index];
//                 return MessageWidget(
//                   text: content.text,
//                   image: content.image,
//                   isFromUser: content.fromUser,
//                 );
//               },
//             )
//                 : const Center(child: Text("Please provide a valid API key")),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 8.0),
//             child: Row(
//               children: [
//                 Expanded(
//                   child: TextField(
//                     onSubmitted: _sendMessage,
//                     controller: _textController,
//                     decoration: InputDecoration(
//                       hintText: "Type your message...",
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(20),
//                       ),
//                     ),
//                   ),
//                 ),
//                 IconButton(
//                   icon: const Icon(Icons.image),
//                   onPressed: _pickImage,
//                 ),
//                 IconButton(
//                   icon: _loading
//                       ? const CircularProgressIndicator()
//                       : const Icon(Icons.send),
//                   onPressed: _loading ? null : () => _sendMessage(_textController.text),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Future<void> _sendMessage(String message) async {
//     if (message.trim().isEmpty) return;
//
//     setState(() {
//       _loading = true;
//       _generatedContent.add((image: null, text: message, fromUser: true));
//       _textController.clear();
//     });
//
//     try {
//       final response = await _chat.sendMessage(
//         Content.text(message),
//       );
//
//       setState(() {
//         _generatedContent.add(
//           (image: null, text: response.text ?? "No response", fromUser: false),
//         );
//       });
//     } catch (e) {
//       showError(e.toString());
//     } finally {
//       setState(() => _loading = false);
//       _scrollDown();
//     }
//   }
//
//   Future<void> _pickImage() async {
//     final picker = ImagePicker();
//     final XFile? image = await picker.pickImage(source: ImageSource.gallery);
//
//     if (image == null) return;
//
//     setState(() {
//       _loading = true;
//     });
//
//     try {
//       final bytes = await image.readAsBytes();
//       final imageWidget = Image.memory(bytes);
//
//       setState(() {
//         _generatedContent.add(
//           (image: imageWidget, text: _textController.text, fromUser: true),
//         );
//       });
//
//       final prompt = _textController.text.isNotEmpty
//           ? _textController.text
//           : "What's in this image?";
//
//       final content = [
//         Content.multi([
//           TextPart(prompt),
//           DataPart('image/jpeg', bytes),
//         ])
//       ];
//
//       final response = await _model.generateContent(content);
//
//       setState(() {
//         _generatedContent.add(
//           (image: null, text: response.text ?? "No response", fromUser: false),
//         );
//         _textController.clear();
//       });
//     } catch (e) {
//       showError(e.toString());
//     } finally {
//       setState(() => _loading = false);
//       _scrollDown();
//     }
//   }
//
//   Future<void> showError(String message) {
//     return showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: const Text("Error"),
//         content: Text(message),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text("OK"),
//           ),
//         ],
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:image_picker/image_picker.dart';

import 'message_widget.dart';

class ChatWidget extends StatefulWidget {
  final String? apiKey;
  const ChatWidget({super.key, required this.apiKey});

  @override
  State<ChatWidget> createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {
  late final GenerativeModel _model;
  late final ChatSession _chat;

  final ScrollController _scrollController = ScrollController();
  bool _loading = false;
  final TextEditingController _textController = TextEditingController();
  final FocusNode _textFieldFocus = FocusNode();
  final List<({Image? image, String? text, bool fromUser})> _generatedContent = [];

  @override
  void initState() {
    super.initState();
    if (widget.apiKey != null && widget.apiKey!.isNotEmpty) {
      _model = GenerativeModel(
        // Update to use the recommended model instead of the deprecated one
        model: 'gemini-1.5-flash', // Replacing 'gemini-pro-vision' with the new model
        apiKey: widget.apiKey!,
      );
      _chat = _model.startChat();
    }
  }

  void _scrollDown() {
    WidgetsBinding.instance.addPostFrameCallback(
          (_) => _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 750),
        curve: Curves.easeInOutCirc,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Column(
        children: [
          Expanded(
            child: widget.apiKey?.isNotEmpty ?? false
                ? ListView.builder(
              controller: _scrollController,
              itemCount: _generatedContent.length,
              itemBuilder: (context, index) {
                final content = _generatedContent[index];
                return MessageWidget(
                  text: content.text,
                  image: content.image,
                  isFromUser: content.fromUser,
                );
              },
            )
                : const Center(child: Text("Please provide a valid API key")),
          ),
          Container(
            width: double.infinity,
            height: 80,

            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.blue[100],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.image),
                    onPressed: _pickImage,
                  ),
                  Expanded(
                    child: TextField(
                      onSubmitted: _sendMessage,
                      controller: _textController,
                      decoration: InputDecoration(
                        hintText: "Type your message...",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ),

                  IconButton(
                    icon: _loading
                        ? const CircularProgressIndicator()
                        : const Icon(Icons.send),
                    onPressed: _loading ? null : () => _sendMessage(_textController.text),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _sendMessage(String message) async {
    if (message.trim().isEmpty) return;

    setState(() {
      _loading = true;
      _generatedContent.add((image: null, text: message, fromUser: true));
      _textController.clear();
    });

    try {
      final response = await _chat.sendMessage(
        Content.text(message),
      );

      setState(() {
        _generatedContent.add(
          (image: null, text: response.text ?? "No response", fromUser: false),
        );
      });
    } catch (e) {
      showError(e.toString());
    } finally {
      setState(() => _loading = false);
      _scrollDown();
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image == null) return;

    setState(() {
      _loading = true;
    });

    try {
      final bytes = await image.readAsBytes();
      final imageWidget = Image.memory(bytes);

      setState(() {
        _generatedContent.add(
          (image: imageWidget, text: _textController.text, fromUser: true),
        );
      });

      final prompt = _textController.text.isNotEmpty
          ? _textController.text
          : "What's in this image?";

      final content = [
        Content.multi([
          TextPart(prompt),
          DataPart('image/jpeg', bytes),
        ])
      ];

      final response = await _model.generateContent(content);

      setState(() {
        _generatedContent.add(
          (image: null, text: response.text ?? "No response", fromUser: false),
        );
        _textController.clear();
      });
    } catch (e) {
      showError(e.toString());
    } finally {
      setState(() => _loading = false);
      _scrollDown();
    }
  }

  Future<void> showError(String message) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Error"),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("OK"),
          ),
        ],
      ),
    );
  }
}
