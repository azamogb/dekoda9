import 'package:dekoda9/components/button.dart';
import 'package:dekoda9/components/text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  final Function()? onTap;
  const SignUp({super.key,required this.onTap});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  //controllers
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final confirmPasswordTextController = TextEditingController();

  void signUp()async{

    showDialog(
        context: context,
        builder: (context)=> const Center(
          child: CircularProgressIndicator(),
        ));

    if (passwordTextController.text != confirmPasswordTextController.text){
      Navigator.pop(context);
      displayMessage("Passwords do not match");
      return;
    }

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailTextController.text,
          password: passwordTextController.text,
      );
      if (context.mounted) Navigator.pop(context);
    }on FirebaseAuthException catch (e){
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
                height: 10,
              ),

              //confirm password
              MyTextField(
                  controller: confirmPasswordTextController,
                  hintText: 'Confirm Password',
                  obscureText: true),
              //forgot password
              const SizedBox(
                height: 15,
              ),
              //sign in button
              MyButton(onTap: signUp, text: 'SignUp'),

              //continue with google

              const SizedBox(
                height: 20,
              ),
              //signup
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already a member?'),
                  const SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: Text(
                      'Login ',
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
