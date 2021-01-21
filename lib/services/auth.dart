import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_with_firebase/utils/models.dart';

class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      return user;
    } catch (ex){
      print(ex.toString());
      return null;
    }
  }

  Future signInAnonymously() async{
    try {
      var result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return user;
    } catch (e) {
      print(e);
    }
    return null;
  }

  // void saveNewUser(User newUser) async {
  //   final _newUserFireStore = Firestore.instance;
  //
  //   _newUserFireStore.collection("Users").document(newUserCreated.uid).setData({
  //     'FirstName': newUser.firstName,
  //     'LastName': newUser.lastName,
  //     'PhoneNumber': newUser.phoneNumber,
  //     'Email': newUser.email,
  //     'DisplayName': newUser.firstName
  //   });
  //   return ;
  // }

}
