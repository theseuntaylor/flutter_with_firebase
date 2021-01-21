import 'package:flutter/material.dart';
import 'package:flutter_with_firebase/screens/sign_up.dart';
import 'package:flutter_with_firebase/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LogIn extends StatefulWidget {
  LogIn({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _LogInState createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  bool _showPassword = false;
  bool signInWithAnon = false;
  bool _isLoading = false;
  bool _isLoading2 = false;
  TextEditingController usernameTEC = TextEditingController();
  TextEditingController passwordTEC = TextEditingController();

  FocusNode passwordFN = FocusNode();
  final _formKey = GlobalKey<FormState>();

  AuthServices _authServices = AuthServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Builder(
          builder: (context) {
            return SafeArea(
                child: Center(
                  child: SingleChildScrollView(
                    child: Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(horizontal: 15.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.center,

                        children: [
                          Form(
                              key: _formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    child: TextFormField(
                                      validator: (value) {
                                        if (value.isEmpty) {
                                          return "Username cannot be empty";
                                        }
                                        return null;
                                      },
                                      textInputAction: TextInputAction.next,
                                      onFieldSubmitted: (v) {
                                        FocusScope.of(context).requestFocus(passwordFN);
                                      },
                                      controller: usernameTEC,
                                      autofocus: false,
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: InputDecoration(
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.orange
                                              )
                                          ),
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
                                          return "password cannot be empty";
                                        }
                                        return null;
                                      },
                                      controller: passwordTEC,
                                      focusNode: passwordFN,
                                      autofocus: false,
                                      obscureText: !_showPassword,
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: InputDecoration(
                                          labelText: "Password",
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.orange
                                              )
                                          ),
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
                                    onPressed: (){
                                      login(context);
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                                      child: Text("LOG IN"),
                                    ),
                                  ),
                                ],
                              )),
                          Container(
                            alignment: Alignment.center,
                            margin: EdgeInsets.symmetric(vertical: 20.0),
                            child: Text("or".toUpperCase()),
                          ),
                          _isLoading2
                              ? Container(
                            alignment: Alignment.center,
                            child: CircularProgressIndicator(
                              strokeWidth: 5.0,
                              backgroundColor: Colors.grey,
                            ),
                          )
                              : Container(
                            child: RaisedButton(
                              color: Colors.orange,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(vertical: 15.0),
                                child: Text("sign in anonymously".toUpperCase()),
                              ),
                              onPressed:
                              signInWithAnon ? (){signInAnon(context);} : null,
                            ),
                          ),
                          SizedBox(
                            height: 40.0,
                          ),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  child: Text("Don\'t have an account?"),
                                ),
                                FlatButton(onPressed: goToSignUp, child: Text("Sign Up"))
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ));
          },
        ));
  }

  void login(BuildContext c) async {
    print("User logged in!");
    if (_formKey.currentState.validate()){
      setState(() {
        _isLoading = true;
      });

      dynamic result = await _authServices.signInWithEmailAndPassword(
          usernameTEC.text, passwordTEC.text);
      if (result != null) {
        print("success: ${result.uid}");
        print(result.email);

        Scaffold
            .of(c)
            .showSnackBar(SnackBar(content: Text('Welcome ${result.email}')));
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

  void goToSignUp() {
    print("User wants to sign up");
    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
  }

  Future<void> signInAnon(BuildContext c) async {
    setState(() {
      _isLoading2 = true;
    });
    FirebaseUser result = await _authServices.signInAnonymously();
    if (result != null) {
      print("success: ${result.uid}");

      Scaffold
          .of(c)
          .showSnackBar(SnackBar(content: Text('Welcome ${result.uid}')));

      setState(() {
        _isLoading2 = false;
      });
    } else {
      print("failed result: $result");
      setState(() {
        _isLoading2 = false;
      });
    }
  }
}
