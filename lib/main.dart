import 'package:flutter/material.dart';
import 'package:flutter_with_firebase/screens/log_in.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter With Firebase',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: LogIn(title: 'Log In'),
    );
  }
}

// class ApplicationState extends ChangeNotifier {
//   ApplicationState() {
//     init();
//   }
//
//   Future<void> init() async {
//     await Firebase.initializeApp();
//
//     FirebaseAuth.instance.userChanges().listen((user) {
//       if (user != null) {
//         _loginState = ApplicationLoginState.loggedIn;
//       } else {
//         _loginState = ApplicationLoginState.loggedOut;
//       }
//       notifyListeners();
//     });
//   }
//
//   ApplicationLoginState _loginState;
//
//   ApplicationLoginState get loginState => _loginState;
//
//   final _authInstance = FirebaseAuth.instance;
//
//   String _email;
//
//   String get email => _email;
//
//   void startLogIn() {
//     _loginState = ApplicationLoginState.emailAddress;
//     notifyListeners();
//   }
//
//   void verifyEmail(String email,
//       void Function(FirebaseAuthException e) errorCallback) async {
//     try {
//       var methods = await _authInstance.fetchSignInMethodsForEmail(email);
//
//       if (methods.contains("password")) {
//         _loginState = ApplicationLoginState.password;
//       } else {
//         _loginState = ApplicationLoginState.register;
//       }
//       _email = email;
//       notifyListeners();
//     } on FirebaseAuthException catch (e) {
//       errorCallback(e);
//     }
//   }
//
//   void signInWithEmailAndPassword(String email, String password,
//       void Function(FirebaseAuthException e) errorCallback) async {
//     try {
//       await _authInstance.signInWithEmailAndPassword(
//           email: email, password: password);
//     } on FirebaseAuthException catch (e) {
//       errorCallback(e);
//     }
//   }
//
//   void cancelRegistration() {
//     _loginState = ApplicationLoginState.emailAddress;
//     notifyListeners();
//   }
//
//   void registerUser(String email, String password, String username,
//       void Function(FirebaseAuthException e) errorCallback) async {
//     try {
//       var credentials = await _authInstance.createUserWithEmailAndPassword(email: email, password: password);
//       await credentials.user.updateProfile(displayName: username);
//     } on FirebaseAuthException catch (e){
//       errorCallback(e);
//       // notifyListeners()
//     }
//   }
//
//
//   void signOut(void Function(FirebaseAuthException e) errorCallback){
//     try {
//       _authInstance.signOut();
//     } on FirebaseAuthException catch (e) {
//       errorCallback(e);
//     }
//   }
//
//   void signInAnonymously(void Function(FirebaseAuthException e) errorCallback){
//     try {
//       _authInstance.signInAnonymously();
//     } on FirebaseAuthException catch (e) {
//       errorCallback(e);
//     }
//   }
//
//   void resetPassword(String email, void Function(FirebaseAuthException e) errorCallback){
//     try {
//       _authInstance.sendPasswordResetEmail(email: email);
//     } on FirebaseAuthException catch (e) {
//       errorCallback(e);
//     }
//   }
// }
