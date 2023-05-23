import 'package:dekoda9/components/button.dart';
import 'package:dekoda9/components/text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  final Function()? onTap;
  const Login({super.key, required this.onTap});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  //controllers
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  //sign in method
  void signIn() async {

    showDialog(
        context: context,
        builder: (context) => const Center(
          child: CircularProgressIndicator(),
        )

    );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailTextController.text,
        password: passwordTextController.text,
      );
      if (context.mounted) Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      displayMessage(e.code);
    }
  }

  void displayMessage(String message) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(message),
    )
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // const SizedBox(
              //   height: 30,
              // ),
              //icon
              const Icon(
                Icons.person_pin,
                size: 100,
              ),

              //message
              const Text(
                'DEKODA',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(
                height: 30,
              ),

              //email
              MyTextField(
                  controller: emailTextController,
                  hintText: 'Email',
                  obscureText: false),

              const SizedBox(
                height: 10,
              ),

              //password
              MyTextField(
                  controller: passwordTextController,
                  hintText: 'Password',
                  obscureText: true),
              //forgot password
              const SizedBox(
                height: 15,
              ),
              //sign in button
              MyButton(onTap: signIn, text: 'Login'),

              //continue with google

              const SizedBox(
                height: 20,
              ),
              //signup
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Not a member?'),
                  const SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: Text(
                      'Signup ',
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue.shade500),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
