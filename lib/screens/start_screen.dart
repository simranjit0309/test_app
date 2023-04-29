import 'package:flutter/material.dart';
import 'login_screen.dart';

class StartScreen extends StatelessWidget{
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(left: 20.0,right: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: (){
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen(true,false)),
                );
              },
              child: Container(
                color: Colors.red,
                  height: 50,
                  alignment: Alignment.center,
                  child:  const Text('Continue with Phone',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontFamily: "Roboto",
                          fontStyle: FontStyle.normal,
                          fontSize: 12.5),
                      textAlign: TextAlign.center)),
            ),
            const SizedBox(height: 10,),
            const Text("OR"),
            const SizedBox(height: 10,),
            InkWell(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen(false,false)),
                );
              },
              child: Container(
                  color: Colors.red,
                  height: 50,
                  alignment: Alignment.center,
                  child:  const Text('Continue with Email/Password',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontFamily: "Roboto",
                          fontStyle: FontStyle.normal,
                          fontSize: 12.5),
                      textAlign: TextAlign.center)),
            ),
            const SizedBox(height: 10,),
            InkWell(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen(false,true)),
                );
              },
              child: Container(
                  color: Colors.red,
                  height: 50,
                  alignment: Alignment.center,
                  child:  const Text('Sign Up with Email/Password',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontFamily: "Roboto",
                          fontStyle: FontStyle.normal,
                          fontSize: 12.5),
                      textAlign: TextAlign.center)),
            ),
          ],
        ),
      ),
    );
  }

}