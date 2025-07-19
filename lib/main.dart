import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:zappy/view/home_page.dart';
import 'package:zappy/view/splash_page.dart';

import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await dotenv.load(fileName: ".env");
  runApp(MyApp(apiKey: dotenv.env['API_KEY'],));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key,this.apiKey});
  final String? apiKey;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Zappy",
      theme: ThemeData(
        useMaterial3: true,

        colorScheme: ColorScheme.fromSeed(
            // brightness: Brightness.dark,
            seedColor: Colors.white)
      ),

      home: ChatScreen(apiKey: apiKey,title: "Zappy",),
    );
  }
}

