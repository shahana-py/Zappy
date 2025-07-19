import 'package:flutter/material.dart';


class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with SingleTickerProviderStateMixin {


  @override
  void initState() {
    super.initState();









    Future.delayed(Duration(seconds: 4), () {

    });
  }



  @override
  void dispose() {

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            CircleAvatar(
                radius: 50,

                backgroundColor: Colors.blue,
              child: Text("Z",style: TextStyle(color: Colors.pink),),

            ),
            SizedBox(height: 20),

            Text("Zappy",style: TextStyle(color: Colors.pink),)
          ],
        ),
      ),
    );
  }
}