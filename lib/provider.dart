import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ProviderTest extends ChangeNotifier {
  String? verificationCode;
  bool isLoading = false;
  late UserCredential userCredential;
  String mobileNo = "";
  List<Map<String, dynamic>?> documentData = [];
  String emailId = "";

   get firebaseAuth=>FirebaseAuth.instance;

  bool checkMobileNumber(String mobileNumber){
    if(mobileNumber.isNotEmpty){
      bool value = mobileNumber.startsWith(RegExp("[6-9]"));
      // print(value);
      // print(mobileNumber);
      if(value){
        bool isValid = isPhoneNoValid(mobileNumber);
        if (!isValid) {
          return false;
        } else {
         return true;
        }
      }else{
        return false;
      }
    }else{
      return false;
    }
    // else{
    //   errfnd(true);
    // }
  }


  bool checkEmailPass(String email,String pass){
    if(email.length >12 && pass.length>5){
      return true;
    }
    return false;
  }

  bool isPhoneNoValid(String phoneNo) {
    final regExp =
    RegExp(r'^(?:(?:\+|0{0,2})91(\s*[\-]\s*)?|[0]?)?[6789]\d{9}$');
    return regExp.hasMatch(phoneNo);
  }

  void verifyPhone(String phone,BuildContext context) async {
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: '+91$phone',
          verificationCompleted: (PhoneAuthCredential credential) async {},
          verificationFailed: (FirebaseAuthException e) {
            ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text(e.toString())));
            print(e.toString());
          },
          codeSent: (String? verficationID, int? resendToken) {
              verificationCode = verficationID!;
          },
          codeAutoRetrievalTimeout: (String verificationID) {
              verificationCode = verificationID;

          },
          timeout: const Duration(seconds: 120));
    } on FirebaseAuthException catch (error) {
      ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text(error.toString())));
    }
  }

  Future<UserCredential> signUpWithEmailPass(String email,String password,BuildContext context) async {
    try {
      userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (error) {
      ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text(error.toString())));
    }
    FirebaseAuth.instance.currentUser;
    return userCredential;
  }

  Future<UserCredential> signInWithEmailPass(String email,String password,BuildContext context) async {
    try {
      userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (error) {
      ScaffoldMessenger.of(context).showSnackBar( SnackBar(content: Text(error.toString())));
    }
    FirebaseAuth.instance.currentUser;
    return userCredential;
  }

  Future<bool> userSetup(String phone,String email,String firstName,String lastName) async{
    String? uid = firebaseAuth.currentUser?.uid.toString();
    CollectionReference users = FirebaseFirestore.instance.collection(uid!);

    users.add(
        {'phone':phone,
          'email':email,
          'firstName':firstName,
          'lastName':lastName,
        }
    );
    return true;
  }

  Future<void> getData() async {
    isLoading= true;
    try {
      String? uid = firebaseAuth.currentUser?.uid.toString();
      if (uid != null) {

        CollectionReference user = FirebaseFirestore.instance.collection(uid);
        QuerySnapshot querySnapshot = await user.get();
        documentData = querySnapshot.docs.map((e) => e.data() as Map<String, dynamic>?).toList();
      }

    }catch (e) {
      print(e.toString());
    }finally {
      isLoading= false;
      notifyListeners();
    }
  }
}
