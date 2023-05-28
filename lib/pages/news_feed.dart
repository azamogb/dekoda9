import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dekoda9/components/text_field.dart';
import 'package:dekoda9/components/wall_post.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:dekoda9/helper/helper.dart';



class NewsFeed extends StatefulWidget {
  const NewsFeed({super.key});

  @override
  State<NewsFeed> createState() => _NewsFeedState();
}
class _NewsFeedState extends State<NewsFeed> {

  final currentUser = FirebaseAuth.instance.currentUser;
  final textController = TextEditingController();

  void postMessage() {
  //only if there is something in the text field
  if (textController.text.isNotEmpty) {
    //store in firebase
    FirebaseFirestore.instance.collection("User Posts").add({
      'UserEmail': currentUser?.email,
      'Message': textController.text,
      'TimeStamp': Timestamp.now(),
      'Likes' : [],

    });
  }
    setState((){
    textController.clear();
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          children: [
            //the wall
            Expanded(
                child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("User Posts")
                  .orderBy(
                    "TimeStamp",
                    descending: true,
                  )
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final post = snapshot.data!.docs[index];
                        return WallPost(
                          user: post['UserEmail'],
                          message: post['Message'],
                          postId: post.id,
                          likes: List<String>.from(post['Likes'] ?? {}),
                          time: formatDate(post['TimeStamp']),
                        );
                      });
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error!${snapshot.error}'));
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            )),
            //post message
            Row(
              children: [
                Expanded(
                  child: MyTextField(
                    controller: textController,
                    hintText: 'write sum...',
                    obscureText: false,
                  ),
                ),
                //const SizedBox(width: 6,),

                //post button
                 IconButton(
                    onPressed: postMessage,
                  icon: const Icon(
                      Icons.arrow_circle_up),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}
