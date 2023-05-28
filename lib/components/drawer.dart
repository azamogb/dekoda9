import 'package:dekoda9/components/list_tile.dart';
import 'package:flutter/material.dart';



class MyDrawer extends StatelessWidget {
  final void Function()? onSignOut;
  final void Function()? onPrivacyTap;
  const MyDrawer({
    super.key,
    required this.onSignOut,
    required this.onPrivacyTap,
  });

  // void signOut() {
  //   FirebaseAuth.instance.signOut();
  // }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.grey[300],
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:  [
          // Drawer header
            Column(children: [
              const DrawerHeader(
                child: Center(
                  child: Icon(
                    Icons.person,
                    size: 64,
                  ),
                ),
              ),


              //home
              //  MyListTile(
              //     icon: Icons.home,
              //     text: 'Home',
              //     onTap: ,
              //
              //  ),


              // ABOUT PAGE
              //  MyListTile(
              //     icon: Icons.info,
              //     text: 'About',
              //     onTap: ,
              //  ),

              MyListTile(
                  icon: Icons.privacy_tip,
                  text: 'Privacy Policy',
                  onTap: onPrivacyTap),


            ],),
          // LOGOUT BUTTON
          Padding(
            padding: const EdgeInsets.only(bottom: 25.0),
            child: MyListTile(
                icon: Icons.logout,
                text: 'Logout',
                onTap: onSignOut,
            ),
          )

        ],
      ),
    );
  }
}
