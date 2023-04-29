import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/email_verification.dart';
import 'package:test_app/otp_screen.dart';
import 'package:test_app/provider.dart';
import 'package:test_app/register_screen.dart';

import 'home_screen.dart';

class LoginScreen extends StatelessWidget{
  TextEditingController phoneMailEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();
  bool isPhoneLogin = false;
  static String verification = "";
  bool isSignUp = false;

  LoginScreen(this.isPhoneLogin, this.isSignUp);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: Container(
        margin: const EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                isPhoneLogin?"Phone Login":"Email/Password Login",
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 55,
                padding: const EdgeInsets.only(left: 10.0,right: 10.0),
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)),
                child:  TextField(
                  controller: phoneMailEditingController,
                  keyboardType: isPhoneLogin?TextInputType.phone:TextInputType.emailAddress,
                  decoration: InputDecoration(
                  counterText: "",
                    border: InputBorder.none,
                    hintText: isPhoneLogin?"Phone Number":"Email",
                  ),
                  maxLength: isPhoneLogin?10:30,

                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Visibility(
                visible: !isPhoneLogin,
                child: Container(
                  height: 55,
                  padding: const EdgeInsets.only(left: 10.0,right: 10.0),
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey),
                      borderRadius:  BorderRadius.circular(10)),
                  child:   TextField(
                    controller: passwordEditingController,
                    obscureText: true,
                    keyboardType: isPhoneLogin?TextInputType.phone:TextInputType.emailAddress,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "Password",
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              InkWell(
                onTap: (){
                  if(isPhoneLogin) {
                    bool isPhoneValid = Provider.of<ProviderTest>(context,listen: false).checkMobileNumber(phoneMailEditingController.text);
                   if(isPhoneValid){
                     Navigator.pushReplacement(
                       context,
                       MaterialPageRoute(
                           builder: (context) =>  OTPScreen(phoneMailEditingController.text,isPhoneLogin)),
                     );
                   }else{
                     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Invalid Phone Number")));
                   }
                  }else{
                    bool isEmailPassValid = Provider.of<ProviderTest>(context,listen: false).checkEmailPass(phoneMailEditingController.text,passwordEditingController.text);
                   if(isEmailPassValid){
                     if(isSignUp){
                       Provider.of<ProviderTest>(context,listen: false).
                       signUpWithEmailPass(phoneMailEditingController.text,passwordEditingController.text,context).then((value)  {
                         final user = value.user;
                         if(value.additionalUserInfo!=null){
                             Provider.of<ProviderTest>(context, listen: false).emailId = user!.email!;
                             Navigator.pushReplacement(
                               context,
                               MaterialPageRoute(
                                   builder: (context) =>  const EmailVerificationScreen()),
                             );

                         }
                       });
                     }else{
                       Provider.of<ProviderTest>(context,listen: false).
                       signInWithEmailPass(phoneMailEditingController.text,passwordEditingController.text,context).then((value)  {
                         if(value.additionalUserInfo!=null){
                           Navigator.of(context).pushReplacementNamed('/home_screen');

                         }
                       });
                     }

                   }else{
                     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Invalid Email/Password")));
                   }
                  }
                },
                child: Container(
                    height: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.green,
                        border: Border.all(width: 1,color: Colors.green,),
                        borderRadius: BorderRadius.circular(10)),
                    child:   Text(isPhoneLogin?'Continue with Phone':'Continue with Email',
                        style: const TextStyle(
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
      ),
    );
  }

}