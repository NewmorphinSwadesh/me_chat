import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:me_chat/chat_page.dart';
import 'package:me_chat/widgets/widget.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn(this.toggleView);
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final GoogleSignIn googleSignIn = GoogleSignIn();

  ///signin
  Future<String> signInWithGoogle() async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();

    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken,
    );

    final UserCredential authResult =
        await _auth.signInWithCredential(credential);

    final User user = authResult.user;

    assert(!user.isAnonymous);

    assert(await user.getIdToken() != null);

    final User currentUser = _auth.currentUser;

    assert(user.uid == currentUser.uid);

    return 'signInWithGoogle succeeded: $user';
  }

  final formKey = GlobalKey<FormState>();

  TextEditingController emailEditingController = new TextEditingController();
  TextEditingController passwordEditingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Me_Chat',
            style: TextStyle(fontSize: 50, color: Colors.blue),
          ),
          Form(
            key: formKey,
            child: Column(
              children: [
                TextFormField(
                  validator: (val) {
                    return RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(val)
                        ? null
                        : "Please Enter Correct Email";
                  },
                  controller: emailEditingController,
                  style: simpleTextStyle(),
                  decoration: textFieldInputDecoration("email"),
                ),
                TextFormField(
                  obscureText: true,
                  validator: (val) {
                    return val.length < 6
                        ? "Enter Password 6+ characters"
                        : null;
                  },
                  style: simpleTextStyle(),
                  controller: passwordEditingController,
                  decoration: textFieldInputDecoration("password"),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              GestureDetector(
                // onTap: () {
                //   Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //           builder: (context) => ForgotPassword()));
                // },
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(
                      "Forgot Password?",
                      style: simpleTextStyle(),
                    )),
              )
            ],
          ),
          SizedBox(
            height: 16,
          ),
          GestureDetector(
            onTap: () {
              // signIn();
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: LinearGradient(
                    colors: [const Color(0xff007EF4), const Color(0xff2A75BC)],
                  )),
              width: MediaQuery.of(context).size.width,
              child: Text(
                "Sign In",
                style: biggerTextStyle(),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(
            height: 16,
          ),
          GestureDetector(
            onTap: () {
              signInWithGoogle().whenComplete(() {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) {
                      return ChatPage();
                    },
                  ),
                );
              });
            },
            child: Container(
              padding: EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: LinearGradient(
                    colors: [const Color(0xff007EF4), const Color(0xff2A75BC)],
                  )),
              width: MediaQuery.of(context).size.width,
              child: Text(
                "Google Sign In",
                style: biggerTextStyle(),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Don't have account? ",
                style: simpleTextStyle(),
              ),
              GestureDetector(
                onTap: () {
                  widget.toggleView;
                },
                child: Text(
                  "Register now",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      decoration: TextDecoration.underline),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
