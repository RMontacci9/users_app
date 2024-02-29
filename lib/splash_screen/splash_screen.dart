import 'dart:async';

import 'package:flutter/material.dart';

import '../assistants/assistant_methods.dart';
import '../authentication/login_screen.dart';
import '../global/global.dart';
import '../mainScreens/main_screen.dart';

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({super.key});

  @override
  State<MySplashScreen> createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {

  startTimer(){
   fAuth.currentUser != null ? AssistantMethods.readCurrentOnlineUserInfo() : null ;

    Timer( const Duration(seconds: 3), () async{
      if(fAuth.currentUser != null){

        currentFirebaseUser = fAuth.currentUser;

        Navigator.push(context, MaterialPageRoute(builder: (context) => MainScreen()));

      } else {

        Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startTimer();
  }
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('images/logo.png'),
          const SizedBox(height: 10,),
          const  Text('Uber & inDriver Clone App', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),)
          ],
        ),
      ),
    );
  }
}
