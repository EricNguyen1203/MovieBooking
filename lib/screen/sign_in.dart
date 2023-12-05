import 'package:cinema_booking_v2/common_widget/common_widget.dart';
import 'package:cinema_booking_v2/screen/home_screen.dart';
import 'package:cinema_booking_v2/screen/sign_up.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(children: [
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 100.0, bottom: 10.0),
                child: Text('Login',
                    style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
              ),
            ),
            Center(
              child: Container(
                margin: EdgeInsets.only(bottom: 200.0),
                child: Text('Signin to your account to continue',
                    style: TextStyle(fontSize: 16.0, color: Colors.grey)),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: 10.0),
              child: Text(
                'EMAIL ID',
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
            Container(
                margin: EdgeInsets.only(left: 10.0),
                child: reuseableTextField(
                    'Enter your email', false, _emailTextController)),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(top: 20.0, left: 10.0),
              child: Text(
                'PASSWORD',
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10.0),
              child: reuseableTextField(
                  'Enter your password', true, _passwordTextController),
            ),
            singInSignUpButton(context, true, () {
              FirebaseAuth.instance
                  .signInWithEmailAndPassword(
                      email: _emailTextController.text,
                      password: _passwordTextController.text)
                  .then((value) {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => MyHomePage()));
              }).onError((error, stackTrace) {
                print("Error: ${error.toString()}");
              });
            }),
            signUpOption(),
          ]),
        )),
      ),
    );
  }

  Row signUpOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(right: 10.0),
          child: const Text("Don't have account?",
              style: TextStyle(
                color: Colors.black,
              )),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SignUpScreen()));
          },
          child: const Text(
            "Sign up now",
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
