import 'package:cinema_booking_v2/common_widget/common_widget.dart';
import 'package:cinema_booking_v2/screen/home_screen.dart';
import 'package:cinema_booking_v2/screen/sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _nameTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _confirmPasswordTextController = TextEditingController();
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
                child: Text('Register',
                    style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black)),
              ),
            ),
            Center(
              child: Container(
                margin: EdgeInsets.only(bottom: 150.0),
                child: Text('Singup for a new account',
                    style: TextStyle(fontSize: 16.0, color: Colors.grey)),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(left: 10.0),
              child: Text(
                'YOUR NAME',
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
            Container(
                margin: EdgeInsets.only(left: 10.0),
                child: reuseableTextField(
                    'Enter your name', false, _nameTextController)),
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(top: 20.0, left: 10.0),
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
                  'Enter your email', false, _emailTextController),
            ),
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
            Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(top: 20.0, left: 10.0),
              child: Text(
                'CONFIRM PASSWORD',
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10.0),
              child: reuseableTextField('Corfirm your password', true,
                  _confirmPasswordTextController),
            ),
            singInSignUpButton(context, false, () {
              FirebaseAuth.instance
                  .createUserWithEmailAndPassword(
                      email: _emailTextController.text,
                      password: _passwordTextController.text)
                  .then((value) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => MyHomePage()));
                      }).onError((error, stackTrace) {
                        print("Error: ${error.toString()}");
                      });
            }),
            signInOption(),
          ]),
        )),
      ),
    );
  }

  Row signInOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.only(right: 10.0),
          child: const Text("Already a user?",
              style: TextStyle(
                color: Colors.black,
              )),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SignInScreen()));
          },
          child: const Text(
            "Login now",
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
