import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/chat/new_message.dart';
import '../widgets/chat/messages.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    super.initState();
    //for IOS push notification - lecture 339
    final fbm = FirebaseMessaging();
    fbm.requestNotificationPermissions();
    fbm.configure(
      onMessage: (msg) {
        print(msg);
        return;
      },
      onLaunch: (msg) {
        print(msg);
        return;
      },
      onResume: (msg) {
        print(msg);
        return;
      },
    );
//    fbm.getToken(); //lecture 344
    fbm.subscribeToTopic('chat');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cat Chat'),
        actions: [
          DropdownButton(
            underline: Container(), //gets rid of slight grey border
            icon: Icon(
              Icons.more_vert,
              color: Theme.of(context).primaryIconTheme.color,
            ),
            items: [
              DropdownMenuItem(
                child: Container(
                  child: Row(
                    children: [
                      Icon(Icons.exit_to_app),
                      SizedBox(width: 8),
                      Text('Logout'),
                    ],
                  ),
                ),
                value: 'logout',
              ),
            ],
            onChanged: (itemIdentifier) {
              if (itemIdentifier == 'logout') {
                FirebaseAuth.instance.signOut();
              }
            },
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: Messages(),
            ),
            NewMessage(),
          ],
        ),
      ),
// build from earlier demonstrating messages
//      StreamBuilder(
//        stream: Firestore.instance
//            .collection('chats/Gbpt8A8N1eUEvpGyFnll/messages')
//            .snapshots(),
//        builder: (ctx, streamSnapshot) {
//          if (streamSnapshot.connectionState == ConnectionState.waiting) {
//            return Center(
//              child: CircularProgressIndicator(),
//            );
//          }
//          final documents = streamSnapshot.data.documents;
//          return ListView.builder(
//            itemCount: streamSnapshot.data.documents.length,
//            itemBuilder: (ctx, index) => Container(
//              padding: EdgeInsets.all(8.0),
//              child: Text(documents[index]['text']),
//            ),
//          );
//        },
//      ),
//      floatingActionButton: FloatingActionButton(
//        child: Icon(Icons.add),
//        onPressed: () {
//          Firestore.instance
//              .collection('chats/Gbpt8A8N1eUEvpGyFnll/messages')
//              .add({'text': 'This was added by clicking the button!'});
//          //lecture 311
////          Firestore.instance
////              .collection('chats/Gbpt8A8N1eUEvpGyFnll/messages')
////              .snapshots()
////              .listen((data) {
////            print(data.documents[0]['text']);
////            data.documents.forEach((element) {
////              print(element['text']);
////            });
////          });
//        },
//      ),
    );
  }
}
