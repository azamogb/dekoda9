import 'dart:io';
import 'package:flutter/material.dart';

class CaptureView extends StatelessWidget {
  final String imagePath;

  const CaptureView({Key? key, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text('Preview',style: TextStyle(color: Colors.black),),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.crop_rotate,
              size: 25,
             // color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.emoji_emotions,
              size: 25,
              //color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.title,
              size: 25,
              //color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.edit,
              size: 25,
              //color: Colors.white,
            ),
          ),
        ],
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height - 150,
              width: MediaQuery.of(context).size.width,
              child: Image.file(
                File(imagePath),
                fit: BoxFit.cover,
              ),
            ),
            Positioned(
                bottom: 0,
                child: Container(
                  //color: Colors.black,
                  width: MediaQuery.of(context).size.width,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  child: TextFormField(
                    decoration:  const InputDecoration(
                        //border:InputBorder.none,
                        hintText: "  Caption...",
                      //hintStyle: TextStyle(color: Colors.white),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
