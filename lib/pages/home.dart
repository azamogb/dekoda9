import 'package:dekoda9/components/bottom_nav_bar.dart';
import 'package:dekoda9/pages/camera.dart';
import 'package:dekoda9/pages/news_feed.dart';
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
    const Camera(),
    const Profile(),
    const Settings(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: Builder(
          builder: (context) => IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.menu,
                color: Colors.black,
              )),
        ),
        title: Text(
          'Welcome ${user.email!}',
          style: TextStyle(color: Colors.grey.shade800),
        ),
        //backgroundColor: Colors.grey[300],
        actions: [
          IconButton(
              onPressed: signOut, icon: const Icon(Icons.logout_outlined,color: Colors.black,))
        ],
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavBar(
        onTabChange: (index) => navigateBottomBar(index),
      ),
    );
  }
}
