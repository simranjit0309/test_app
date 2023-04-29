import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:test_app/home_screen.dart';
import 'package:test_app/start_screen.dart';


class MainScreen extends StatelessWidget{
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            return  const HomeScreen();
          }else{
            return const StartScreen();
          }
        });

  }

}
