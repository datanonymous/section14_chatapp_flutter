import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: Firestore.instance
            .collection('chats/Gbpt8A8N1eUEvpGyFnll/messages')
            .snapshots(),
        builder: (ctx, streamSnapshot) {
          if (streamSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final documents = streamSnapshot.data.documents;
          return ListView.builder(
            itemCount: streamSnapshot.data.documents.length,
            itemBuilder: (ctx, index) => Container(
              padding: EdgeInsets.all(8.0),
              child: Text(documents[index]['text']),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Firestore.instance
              .collection('chats/Gbpt8A8N1eUEvpGyFnll/messages')
              .add({'text': 'This was added by clicking the button!'});
          //lecture 311
//          Firestore.instance
//              .collection('chats/Gbpt8A8N1eUEvpGyFnll/messages')
//              .snapshots()
//              .listen((data) {
//            print(data.documents[0]['text']);
//            data.documents.forEach((element) {
//              print(element['text']);
//            });
//          });
        },
      ),
    );
  }
}
