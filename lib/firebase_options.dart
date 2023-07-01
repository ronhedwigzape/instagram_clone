import 'package:firebase_core/firebase_core.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get webPlatform {
    return const FirebaseOptions(
      apiKey: "AIzaSyDe3G-Zphwn0ijXyq0PuF6M_lIwnjBLZvo",
      authDomain: "instagram-clone-3f35c.firebaseapp.com",
      projectId: "instagram-clone-3f35c",
      storageBucket: "instagram-clone-3f35c.appspot.com",
      messagingSenderId: "55020532696",
      appId: "1:55020532696:web:3affed943ef83de18638ad"
    );
  }

  static FirebaseOptions get androidPlatform {
    return const FirebaseOptions(
      apiKey: 'AIzaSyDe3G-Zphwn0ijXyq0PuF6M_lIwnjBLZvo',
      appId: '1:55020532696:android:4800dc380e0e109a8638ad',
      messagingSenderId: '55020532696',
      projectId: 'instagram-clone-3f35c',
    );
  }

  static FirebaseOptions get iosPlatform {
    return const FirebaseOptions(
      apiKey: 'AIzaSyDe3G-Zphwn0ijXyq0PuF6M_lIwnjBLZvo',
      appId: '1:55020532696:ios:6536b1aa71bf81a48638ad',
      messagingSenderId: '55020532696',
      projectId: 'instagram-clone-3f35c',
    );
  }
}
