import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_with_firebase/utils/models.dart';

// Future<void> signUp() async {
//   final _authServices = FirebaseAuth.instance;
//
//   if (_globalFormKey.currentState.validate()) {
//     setState(() {
//       _isLoading = true;
//     });
//     // do sign up process
//     User user = User(
//         fullName: fullNameTEC.text,
//         email: usernameTEC.text,
//         phoneNumber: phoneNumberTEC.text);
//     FirebaseUser result =
//         await _authServices.signUpWithEmailAndPassword(user, passwordTEC.text);
//     if (result != null) {
//       print("success: ${result.uid}");
//       print(result.email);
//
//       setState(() {
//         _isLoading = false;
//       });
//     } else {
//       print("failed result: $result");
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }
// }

var userCreated;

Future<SignUpStatus> signUpUser(
    {@required User newUser, @required String password}) async {
  final _auth = FirebaseAuth.instance;
  _auth.signOut();

  try {
    final checkEmail = await Firestore.instance
        .collection('users')
        .where('email', isEqualTo: newUser.email.trim())
        .limit(1)
        .getDocuments();

    final checkPhoneNumber = await Firestore.instance
        .collection('users')
        .where('phone_number', isEqualTo: newUser.phoneNumber.trim())
        .limit(1)
        .getDocuments();

    if (checkPhoneNumber.documents.length == 0) {
      try {
        final result = await _auth.createUserWithEmailAndPassword(
            email: newUser.email.trim(), password: password);
        if (result != null) {
          userCreated = await _auth.currentUser();
          sendVerificationMail();
          saveNewUserData(newUser);
          return SignUpStatus.success;
        }
      } catch (ex) {
        print("Exception is: $ex");
        if (ex.toString().contains('WEAK')) {
          return SignUpStatus.weakPassword;
        } else if (ex.toString().contains('INVALID_EMAIL')) {
          return SignUpStatus.invalidEmail;
        } else if (ex.toString().contains('ERROR_EMAIL_ALREADY_IN_USE')) {
          return SignUpStatus.emailExists;
        } else {
          return SignUpStatus.unknownException;
        }
      }
      return SignUpStatus.unknownException;
    } else {
      return SignUpStatus.phoneExists;
    }
  } catch (e) {
    print("Exception from checking for number or email: $e");
    return SignUpStatus.unknownException;
  }
}

enum SignUpStatus {
  success,
  weakPassword,
  invalidEmail,
  emailExists,
  unknownException,
  phoneExists
}

Future sendVerificationMail() async {
  try {
    userCreated.sendEmailVerification();
  } catch (e) {
    //TODO: take action to handle sending email failure.
    print(e);
  }
}

void saveNewUserData(User user) async {
  final _fireStoreInstance = Firestore.instance;
  _fireStoreInstance.collection('users').document(userCreated.uid).setData({
    'first_name': user.firstName,
    'last_name': user.lastName,
    'phone_number': user.phoneNumber,
    'email': user.email
  });
}
