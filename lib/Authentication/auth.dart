import 'package:dekoda9/pages/login.dart';
import 'package:dekoda9/pages/register.dart';
import 'package:flutter/material.dart';


class Auth extends StatefulWidget {
  const Auth({Key? key}) : super(key: key);

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {

  bool showLogin = true;

  //toggle
  void togglePages(){
    setState(() {
      showLogin = !showLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
   if (showLogin) {
     return Login(onTap: togglePages);
   }else {
     return SignUp(onTap: togglePages);
   }
  }
}
