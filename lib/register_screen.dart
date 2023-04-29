import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_app/provider.dart';

import 'home_screen.dart';

class RegisterScreen extends StatelessWidget {
  String emailOrNumber = "";
  bool isPhoneLogin = false;
 final TextEditingController fisrtName = TextEditingController();
 final TextEditingController lastName = TextEditingController();
  final TextEditingController phoneOrEmail = TextEditingController();
   RegisterScreen(this.emailOrNumber, this.isPhoneLogin,{super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 55,
                padding: const EdgeInsets.only(left: 10.0,right: 10.0),
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)),
                child:   TextField(
                  controller: fisrtName,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "First Name"
                  ),

                ),
              ),
              const SizedBox(height: 15.0,),
              Container(
                height: 55,
                padding: const EdgeInsets.only(left: 10.0,right: 10.0),
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)),
                child:   TextField(
                  controller: lastName,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "Last Name"
                  ),

                ),
              ),
              const SizedBox(height: 15.0,),
              Container(
                height: 55,
                padding: const EdgeInsets.only(left: 10.0,right: 10.0),
                decoration: BoxDecoration(
                    border: Border.all(width: 1, color: Colors.grey),
                    borderRadius: BorderRadius.circular(10)),
                child:   TextField(
                  controller: phoneOrEmail,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: isPhoneLogin?"Email Id":"Phone Number"
                  ),

                ),
              ),
              const SizedBox(height: 15.0,),
              InkWell(
                onTap: (){
                  if(emailOrNumber.length>10 && phoneOrEmail.text.length>10 && fisrtName.text.length>5 && lastName.text.length>5) {
                    Provider.of<ProviderTest>(context, listen: false).
                    userSetup(isPhoneLogin ? emailOrNumber : phoneOrEmail.text,
                        isPhoneLogin ? phoneOrEmail.text : emailOrNumber,
                        fisrtName.text, lastName.text).then((value) {
                      if (value) {
                        Navigator.of(context).pushReplacementNamed(
                            '/home_screen');
                      }
                    });
                  }else{
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Invalid Details")));
                  }
                },
                child: Container(
                    color: Colors.red,
                    height: 50,
                    alignment: Alignment.center,
                    child:  const Text('Continue',
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
      ),
    );
  }

}