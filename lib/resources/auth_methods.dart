import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:instagram_clone/resources/storage_methods.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //sign up user
  Future<String> signUpUser({required String email, required String password, required String username, required String bio, Uint8List? file}) async {
    
    String res = "Some error occured";
    
    try {
      if (email.isNotEmpty || password.isNotEmpty || username.isNotEmpty || bio.isNotEmpty || file != null) {
        
        // register user
        UserCredential credential = await _auth.createUserWithEmailAndPassword(email: email, password: password);

        if (kDebugMode) {
          print(credential.user!.uid);
        }

        String photoUrl = await StorageMethods().uploadImageToStorage('profileImage', file!, false);

        // add user to our database
        await _firestore.collection('users').doc(credential.user!.uid).set({
          'username': username,
          'email': email,
          'bio': bio,
          'photoUrl': photoUrl,
          'uid': credential.user!.uid,
          'followers': [],
          'following': [],
        });

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
    } on FirebaseAuthException catch (err) {
      if (err.code == 'invalid-email') {
        res = 'The email is badly formatted.';
      }
      else if (err.code == 'weak-password') {
        res = 'The password must be 6 characters long or more.';
      }
      else if (err.code == 'email-already-in-use') {
        res = 'The account already exists for that email.';
      }
      else {
        res = err.message!;
      }
    }
    return res;
  }
}