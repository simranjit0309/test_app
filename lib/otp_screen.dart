import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';
import 'package:test_app/provider.dart';
import 'package:test_app/register_screen.dart';

import 'home_screen.dart';


class OTPScreen extends StatefulWidget {
  final String phone;
  static String verify = "";
  bool isPhoneLogin = false;
   OTPScreen(this.phone,this.isPhoneLogin, {super.key});
  @override
  OTPScreenState createState() => OTPScreenState();
}

class OTPScreenState extends State<OTPScreen> {
  final TextEditingController _pinPutController = TextEditingController();

  final defaultPinTheme = PinTheme(
    width: 56,
    height: 56,
    textStyle: const TextStyle(fontSize: 20, color: Color.fromRGBO(30, 60, 87, 1), fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.black),
      borderRadius: BorderRadius.circular(20),
    ),
  );


  @override
  void initState() {
    super.initState();
    Provider.of<ProviderTest>(context,listen: false).verifyPhone(widget.phone,context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OTP Verification'),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 40),
            child: Center(
              child: Text(widget.phone,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 26),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Pinput(
              length: 6,
              defaultPinTheme: defaultPinTheme,

              controller: _pinPutController,
              pinAnimationType: PinAnimationType.fade,
            ),
          ),
          ElevatedButton(onPressed: () async {
            PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId:  Provider.of<ProviderTest>(context,listen: false).verificationCode!, smsCode: _pinPutController.text);
            try{
              await FirebaseAuth.instance
                  .signInWithCredential(credential)
                  .then((value) async {
                final user = value.user;
                if (user != null) {
                  value.credential?.token;
                  Provider.of<ProviderTest>(context,listen: false).mobileNo = user.phoneNumber!;
                  print(user.toString());
                  if(value.additionalUserInfo?.isNewUser!=null){
                    if(value.additionalUserInfo?.isNewUser ==  true){
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => RegisterScreen(user.phoneNumber!,true)),
                      );
                    }else{
                      Navigator.of(context).pushReplacementNamed('/home_screen');
                    }

                  }
                }
              });
            }catch (e){
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
            }

          }, child: const Text("Verify"))
        ],
      ),
    );
  }



}