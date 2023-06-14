import 'package:flutter/material.dart';
import '../components/my_camera.dart';

final firstCamera = cameras.first;

class CameraScreen extends StatelessWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MyCamera(camera: firstCamera);
  }
}
