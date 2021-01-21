import 'package:flutter/material.dart';
import 'package:flutter_with_firebase/services/sign_up_service.dart';
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
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
      ),
      body: Scaffold(
        key: _scaffoldKey,
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
                                  validator: (value) {
                                    if (value.isEmpty) {
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
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderSide:
                                          BorderSide(color: Colors.orange)),
                                      labelText: "Full Name"),
                                ),
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              Container(
                                child: TextFormField(
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return "Field cannot be empty";
                                    }
                                    return null;
                                  },
                                  focusNode: usernameFN,
                                  textInputAction: TextInputAction.next,
                                  onFieldSubmitted: (v) {
                                    FocusScope.of(context)
                                        .requestFocus(phoneNumberFN);
                                  },
                                  controller: usernameTEC,
                                  autofocus: false,
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderSide:
                                          BorderSide(color: Colors.orange)),
                                      labelText: "Email Address"),
                                ),
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              Container(
                                child: TextFormField(
                                  validator: (value) {
                                    if (value.isEmpty) {
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
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                          borderSide:
                                          BorderSide(color: Colors.orange)),
                                      labelText: "Phone Number"),
                                ),
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              Container(
                                child: TextFormField(
                                  validator: (value) {
                                    if (value.isEmpty) {
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
                                      border: OutlineInputBorder(
                                          borderSide:
                                          BorderSide(color: Colors.orange)),
                                      labelText: "Password",
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
                              _isLoading
                                  ? Container(
                                alignment: Alignment.center,
                                child: CircularProgressIndicator(
                                  strokeWidth: 5.0,
                                  backgroundColor: Colors.grey,
                                ),
                              )
                                  : RaisedButton(
                                color: Theme.of(context).accentColor,
                                onPressed: () {
                                  signUp(context);
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 15.0),
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

  void logIn() {
    Navigator.pop(context);
  }

  Future signUp(BuildContext c) async {
    /// Check validation first!

    // String s = fullNameTEC.text;
    // int idx = s.indexOf(" ");
    //
     // List names = [s.substring(0, idx).trim(), s.substring(idx+1).trim()];
    // String firstName = names[0];
    // String lastName = names[1];
    //
    // print("First name is: $firstName && Last name is $lastName");

    try {
      if (_globalFormKey.currentState.validate()) {
            setState(() {
              _isLoading = true;
            });

            String s = fullNameTEC.text;
            int idx = s.indexOf(" ");

            List names = [s.substring(0, idx).trim(), s.substring(idx+1).trim()];
            String firstName = names[0];
            String lastName = names[1];

            print("First name is: $firstName && Last name is $lastName");
            print(passwordTEC.text.trim());
            print(phoneNumberTEC.text.trim());
            print(usernameTEC.text.trim());

            User newUser = User(
              phoneNumber: phoneNumberTEC.text.trim(),
              email: usernameTEC.text.trim(),
              fullName: fullNameTEC.text.trim(),
              firstName: firstName,
              lastName: lastName
            );

            SignUpStatus signUpStatusAfterNetworkCall =
            await signUpUser(newUser: newUser, password: passwordTEC.text.trim());

            print(signUpStatusAfterNetworkCall.toString());

            if (signUpStatusAfterNetworkCall == SignUpStatus.success) {

              setState(() {
                _isLoading = false;
              });

              _scaffoldKey.currentState.showSnackBar(SnackBar(
                  content: Text(
                      'You successfully signed up! Welcome ${newUser.fullName}')));
            } else if (signUpStatusAfterNetworkCall == SignUpStatus.emailExists) {

              setState(() {
                _isLoading = false;
              });

              _scaffoldKey.currentState.showSnackBar(SnackBar(
                  content: Text(
                      'You dey whine me? EMAIL already exists!')));

            } else if (signUpStatusAfterNetworkCall == SignUpStatus.invalidEmail){
              setState(() {
                _isLoading = false;
              });
              _scaffoldKey.currentState.showSnackBar(SnackBar(
                  content: Text(
                      'You dey whine me? Your email is invalid!')));
            } else if (signUpStatusAfterNetworkCall == SignUpStatus.phoneExists){
              setState(() {
                _isLoading = false;
              });
              _scaffoldKey.currentState.showSnackBar(SnackBar(
                  content: Text(
                      'You dey whine me? PHONE NUMBER already exists!')));
            } else if (signUpStatusAfterNetworkCall == SignUpStatus.weakPassword){
              setState(() {
                _isLoading = false;
              });
              _scaffoldKey.currentState.showSnackBar(SnackBar(
                  content: Text(
                      'Your password is weak!')));
            } else {
              setState(() {
                _isLoading = false;
              });
              _scaffoldKey.currentState.showSnackBar(SnackBar(
                  content: Text(
                      'This one pass me, no vex!')));
            }
          }
    } catch (e) {
      print(e);
    }
  }
}
