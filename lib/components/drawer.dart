// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';



class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  // method to log user out
  // void logUserOut(BuildContext context) {
  //   FirebaseAuth.instance.signOut();
  // }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey[300],
      child: Column(
        children: [
          // Drawer header
          const DrawerHeader(
            child: Center(
              child: Icon(
                Icons.phone_iphone_rounded,
                size: 64,
              ),
            ),
          ),

          const SizedBox(height: 25),

          // ABOUT PAGE
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: GestureDetector(
              onTap: () {
                // Navigator.pop(context);
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => const (),
                //   ),
                // );
              },
              child: ListTile(
                leading: const Icon(Icons.info),
                title: Text(
                  "A B O U T",
                  style: TextStyle(color: Colors.grey[700]),
                ),
              ),
            ),
          ),

          // LOGOUT BUTTON
          // Padding(
          //   padding: const EdgeInsets.symmetric(horizontal: 25.0),
          //   child: ListTile(
          //     leading: const Icon(Icons.logout),
          //     onTap: () => logUserOut(context),
          //     title: Text(
          //       "L O G O U T",
          //       style: TextStyle(color: Colors.grey[700]),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
