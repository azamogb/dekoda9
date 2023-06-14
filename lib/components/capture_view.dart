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
        title: const Text(
          'Preview',
          style: TextStyle(color: Colors.black),
        ),
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
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                  child: TextFormField(
                    maxLines: 6,
                    minLines: 1,
                    decoration: InputDecoration(
                      //border:InputBorder.none,
                      hintText: "  Caption...",
                      // prefixIcon: Icon(
                      //   Icons.add_photo_alternate,
                      //   color: Colors.grey.shade600,
                      // ),
                      hintStyle: TextStyle(
                        color: Colors.grey.shade400,
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                      suffixIcon: const CircleAvatar(
                        radius: 25,
                        child: Icon(Icons.arrow_forward_rounded),
                      )
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
