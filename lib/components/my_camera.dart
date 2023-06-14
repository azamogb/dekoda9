import 'package:camera/camera.dart';
import 'package:dekoda9/components/capture_view.dart';
import 'package:flutter/material.dart';
import 'dart:async';



late List<CameraDescription> cameras;

class MyCamera extends StatefulWidget {
  final CameraDescription camera;
  const MyCamera({super.key, required this.camera});

  @override
  State<MyCamera> createState() => _MyCameraState();
}

class _MyCameraState extends State<MyCamera> {

  late CameraController _cameraController;
  late Future<void> cameraValue;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _cameraController = CameraController(
      cameras[0],
      ResolutionPreset.max,
    );
    cameraValue = _cameraController.initialize();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _cameraController.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          FutureBuilder(
              future: cameraValue,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return CameraPreview(
                    _cameraController,
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }
              ),
          Positioned(
            bottom: 0.0,
            child: Container(
              padding: const EdgeInsets.only(
                top: 5,
                bottom: 5,
              ),
              color: Colors.black,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.flash_off,
                            color: Colors.white,
                            size: 28,
                          ),
                      ),
                      InkWell(
                        onTap: () {
                          takePhoto(context);
                        },
                        child: const Icon(
                          Icons.panorama_fish_eye,
                          color: Colors.white,
                          size: 70,
                        ),
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.flip_camera_android,
                            color: Colors.white,
                            size: 28,
                          ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  const Text(
                    'Hold for video, Tap for camera',
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void takePhoto(BuildContext context) async {
    try {
      await cameraValue;

      final image = await _cameraController.takePicture();

      if (!mounted) return;

      await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CaptureView(imagePath: image.path,)
          ),
      );
    } catch (e) {
      const Text('e');
    }
  }
}
