import 'package:flutter/material.dart';
import 'package:flutter_with_firebase/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_with_firebase/utils/models.dart';


class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool _showPassword = false;
  bool _isLoading = false;

  TextEditingController fullNameTEC = TextEditingController();
  TextEditingController usernameTEC = TextEditingController();
  TextEditingController phoneNumberTEC = TextEditingController();
  TextEditingController passwordTEC = TextEditingController();

  FocusNode passwordFN = FocusNode();
  FocusNode phoneNumberFN = FocusNode();
  FocusNode usernameFN = FocusNode();

  final _globalFormKey = GlobalKey<FormState>();

  AuthServices _authServices = AuthServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
      ),
      body: Scaffold(
        body: Center(
          child: SingleChildScrollView(
            child: SafeArea(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Form(
                          key: _globalFormKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                child: TextFormField(
                                  validator: (value){
                                    if (value.isEmpty){
                                      return "Field cannot be empty";
                                    }
                                    return null;
                                  },
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (v) {
                                    FocusScope.of(context).requestFocus(usernameFN);
                                  },
                                  controller: fullNameTEC,
                                  autofocus: false,
                                  keyboardType: TextInputType.name,
                                  decoration: InputDecoration(hintText: "Full Name"),
                                ),
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              Container(
                                child: TextFormField(
                                  validator: (value){
                                    if (value.isEmpty){
                                      return "Field cannot be empty";
                                    }
                                    return null;
                                  },
                                  focusNode: usernameFN,
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (v) {
                                    FocusScope.of(context).requestFocus(phoneNumberFN);
                                  },
                                  controller: usernameTEC,
                                  autofocus: false,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(hintText: "Email Address"),
                                ),
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              Container(
                                child: TextFormField(
                                  validator: (value){
                                    if (value.isEmpty){
                                      return "Field cannot be empty";
                                    }
                                    return null;
                                  },
                                  focusNode: phoneNumberFN,
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (v) {
                                    FocusScope.of(context).requestFocus(passwordFN);
                                  },
                                  controller: phoneNumberTEC,
                                  autofocus: false,
                                  keyboardType: TextInputType.phone,
                                  decoration: InputDecoration(hintText: "Phone Number"),
                                ),
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              Container(
                                child: TextFormField(
                                  validator: (value){
                                    if (value.isEmpty){
                                      return "Field cannot be empty";
                                    }
                                    return null;
                                  },
                                  focusNode: passwordFN,
                                  controller: passwordTEC,
                                  autofocus: false,
                                  obscureText: !_showPassword,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                      hintText: "Password",
                                      suffixIcon: IconButton(
                                        icon: _showPassword
                                            ? Icon(Icons.visibility_off)
                                            : Icon(Icons.visibility),
                                        onPressed: () {
                                          setState(() {
                                            _showPassword = !_showPassword;
                                          });
                                        },
                                      )),
                                ),
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              _isLoading ?
                              Container(
                                alignment: Alignment.center,
                                child: CircularProgressIndicator(
                                  strokeWidth: 5.0,
                                  backgroundColor: Colors.grey,
                                ),
                              ):
                              RaisedButton(
                                color: Theme.of(context).accentColor,
                                onPressed: signUp,
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                                  child: Text("Sign up".toUpperCase()),
                                ),
                              ),
                            ],
                          )),
                      SizedBox(
                        height: 40.0,
                      ),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              child: Text("Already have an account?"),
                            ),
                            FlatButton(onPressed: logIn, child: Text("Sign In"))
                          ],
                        ),
                      )
                    ],
                  ),
                )),
          ),
        ),
      ),
    );
  }

  Future<void> signUp() async {

    if(_globalFormKey.currentState.validate()){
      setState(() {
        _isLoading = true;
      });
      // do sign up process
      User user = User(fullNameTEC.text, usernameTEC.text, phoneNumberTEC.text);
      FirebaseUser result = await _authServices.signUpWithEmailAndPassword(user, passwordTEC.text);
      if (result != null) {
        print("success: ${result.uid}");
        print(result.email);

        setState(() {
          _isLoading = false;
        });
      } else {
        print("failed result: $result");
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void logIn() {
    Navigator.pop(context);
  }
}
