import 'package:dekoda9/components/bottom_nav_bar.dart';
import 'package:dekoda9/components/drawer.dart';
import 'package:dekoda9/pages/camera_page.dart';
import 'package:dekoda9/pages/news_feed.dart';
import 'package:dekoda9/pages/policy.dart';
import 'package:dekoda9/pages/profile.dart';
import 'package:dekoda9/pages/settings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final user = FirebaseAuth.instance.currentUser!;

  void signOut() {
    FirebaseAuth.instance.signOut();
  }

  int _selectedIndex = 0;

  void navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    const NewsFeed(),
    const CameraScreen(),
    const Profile(),
    const Settings(),
  ];

  void goToPolicyPage() {
    Navigator.pop(context);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Policy()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        //
        title: Text(
          '${user.email}',
          style: const TextStyle(color: Colors.grey),
        ),
        //backgroundColor: Colors.grey[300],
      ),
      drawer: MyDrawer(
        onPrivacyTap: goToPolicyPage,
        onSignOut: signOut,
      ),
      body: _pages[_selectedIndex],

      bottomNavigationBar: BottomNavBar(

        onTabChange: (index) => navigateBottomBar(index),

      ),
    );
  }
}
