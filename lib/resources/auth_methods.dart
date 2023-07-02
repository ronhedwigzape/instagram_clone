import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //sign up user
  Future<String> signUpUser(
      {required String email,
      required String password,
      required String username,
      required String bio,
      Uint8List? file}) async {
    String res = "Some error occured";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty ||
          file != null) {
        // register user
        UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, 
          password: password
        );

        if (kDebugMode) {
          print(credential.user!.uid);
        }
        // add user to our database
        await _firestore.collection('users').doc(credential.user!.uid).set(
          {
            'username': username,
            'email': email,
            'bio': bio,
            'profileImage': file,
            'uid': credential.user!.uid,
            'followers': [],
            'following': [],
          }
        );

        // 
        // await _firestore.collection('users').add(
        //   {
        //     'username': username,
        //     'email': email,
        //     'bio': bio,
        //     'profileImage': file,
        //     'uid': credential.user!.uid,
        //     'followers': [],
        //     'following': [],
        //   }
        // );

        res = "Success";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }
}
