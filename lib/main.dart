import 'package:camera/camera.dart';
import 'package:dekoda9/Authentication/auth_process.dart';
import 'package:dekoda9/components/my_camera.dart';
import 'package:dekoda9/Resources/firebase_options.dart';
import 'package:dekoda9/theme/light.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:dekoda9/theme/dark.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();

  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: whiteTheme,
      darkTheme: blackTheme,
      home: const AuthProcess(),
    );
  }
}