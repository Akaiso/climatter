

import 'package:firebase_auth/firebase_auth.dart';

class LoginController  {

  Future<dynamic> getUserId() async {
     final FirebaseAuth _auth = FirebaseAuth.instance;
    var currentUserId = await _auth.currentUser?.uid;
     print('yyyyyyyyyyyyy$currentUserId');
    return currentUserId;
  }
}