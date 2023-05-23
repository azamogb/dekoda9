import 'package:dekoda9/Authentication/auth.dart';
import 'package:dekoda9/pages/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class AuthProcess extends StatelessWidget {
  const AuthProcess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot){
        if (snapshot.hasData){
          return const Home();
        }else{
          return const Auth();
        }
      }
      ),
    );
  }
}
