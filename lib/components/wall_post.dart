import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dekoda9/components/comment_button.dart';
import 'package:dekoda9/components/delete_button.dart';
import 'package:dekoda9/components/like_button.dart';
import 'package:dekoda9/components/share_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dekoda9/components/comment.dart';
import 'package:dekoda9/helper/helper.dart';



class WallPost extends StatefulWidget {
  final String message;
  final String user;
  final String time;
  final String postId;
  final List<String> likes;


  const WallPost({
    super.key,
    required this.message,
    required this.user,
    required this.time,
    required this.likes,
    required this.postId,

  });

  @override
  State<WallPost> createState() => _WallPostState();
}

class _WallPostState extends State<WallPost> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  bool isLiked = false;

  final _commentTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    isLiked = widget.likes.contains(currentUser.email);
  }

  void toggleLike() {
    setState(() {
      isLiked = !isLiked;
    });

    //access in firebase
    DocumentReference postRef =
        FirebaseFirestore.instance.collection('User Posts').doc(widget.postId);

    if (isLiked) {
      //liked? add the user's email to the likes field
      postRef.update({
        'Likes': FieldValue.arrayUnion([currentUser.email])
      });
    } else {
      //!liked? remove the user email from likes field
      postRef.update({
        'Likes': FieldValue.arrayRemove([currentUser.email])
      });
    }
  }

  // add comment
  void addComment(String commentText) {
    //write comment to firestore collection for the post
    FirebaseFirestore.instance
        .collection("User Posts")
        .doc(widget.postId)
        .collection("Comment")
        .add({
      "CommentText": commentText,
      "CommentedBy": currentUser.email,
      "CommentTime": Timestamp.now(), //format when displaying
    });
  }

  //show dialog for adding input
  void showCommentDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Add Comment"),
        content: TextField(
          controller: _commentTextController,
          decoration: const InputDecoration(hintText: "make your comment..."),
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);

                _commentTextController.clear();
              },
              child: const Text("Cancel",
              )),
          TextButton(
              onPressed: () {
                addComment(_commentTextController.text);

                Navigator.pop(context);

                _commentTextController.clear();
              },
              child: const Text("Post",
                )
          ),
        ],
      ),
    );
  }
  //delete post
  void deletePost(){
    //ask for confirmation
    showDialog(context: context,
        builder: (context) => AlertDialog(
          title: const Text("Delete post"),
          content: const Text("Are you sure you want to delete?"),
          actions: [
            // cancel
            TextButton(onPressed: () => Navigator.pop(context),
                child: const Text("Cancel",
                  )),
            //delete
            TextButton(onPressed: () async{
              //delete from firebase
              final commentDocs = await FirebaseFirestore
                  .instance
                  .collection("User Posts")
                  .doc(widget.postId)
                  .collection("Comment")
                  .get();
              for (var doc in commentDocs.docs){
                await FirebaseFirestore.instance
                    .collection("User Posts")
                    .doc(widget.postId)
                    .collection("Comment")
                    .doc(doc.id)
                    .delete();
              }
              //delete from app
              FirebaseFirestore.instance.collection("User Posts")
              .doc(widget.postId).delete()
              .then((value) => const Text("Post deleted"))
                  .catchError((error) => Text("Failed to delete: $error"));

              //close dialogue box
              if (context.mounted) return;
              Navigator.pop(context);
            },
                child: const Text("Delete",
                )
            ),
          ],
        ));
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(8)
      ),
      margin: const EdgeInsets.only(top: 25, left: 25, right: 25),
      padding: const EdgeInsets.all(25),
      child: Column(
       // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            width: 10,
          ),
          //wall post
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              // group of text(message, user email)
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        IconButton(onPressed: (){}, icon: const Icon(Icons.person_rounded)),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.user,
                              style: TextStyle(color: Colors.grey.shade400),),
                            // Text(" . ",
                            //   style: TextStyle(color: Colors.grey.shade400),),
                            Text(widget.time,
                              style: TextStyle(color: Colors.grey.shade400),),
                          ],
                        ),
                      ],
                    ),
                    Text(widget.message,),
                    const SizedBox(
                      height: 5,
                    ),

                  ],
                ),
              ),
              //delete button
              if (widget.user == currentUser.email)
                DeleteButton(onTap: deletePost),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          //buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  //like button
                  LikeButton(
                    isLiked: isLiked,
                    onTap: toggleLike,
                  ),

                  const SizedBox(
                    height: 5,
                  ),

                  //like counter
                  Text(
                    widget.likes.length.toString(),
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(
                width: 10,
              ),
              //comment
              Column(
                children: [
                  //comment button
                  CommentButton(onTap: showCommentDialog),

                  const SizedBox(
                    height: 5,
                  ),

                  //like counter
                  const Text(
                    '0',
                    //widget.likes.length.toString(),
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(
                width: 10,
              ),
              //comment
              Column(
                children: [
                  //comment button
                  ShareButton(onTap: (){}),

                  const  SizedBox(
                    height: 5,
                  ),

                  //like counter
                  const Text(
                    '0',
                    //widget.likes.length.toString(),
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 20,),
          //display comments
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection("User Posts")
                .doc(widget.postId)
                .collection("Comment")
                .orderBy("CommentTime", descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              //no data yet...show circle
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              return ListView(
                shrinkWrap: true, //nested list
                physics: const NeverScrollableScrollPhysics(),
                children: snapshot.data!.docs.map((doc) {
                  //get comment
                  final commentData = doc.data() as Map<String, dynamic>;

                  return Comment(
                    text: commentData["CommentText"],
                    user: commentData["CommentedBy"],
                    time: formatDate(commentData["CommentTime"]),
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}
