import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:http/http.dart';

import './firebase_notification_handler.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // FirebaseNotificationHandler firebaseNotificationHandler =
  //     FirebaseNotificationHandler();
  // await firebaseNotificationHandler.initialize();
  // await firebaseNotificationHandler.subscribeToTopic('TopicName');
  // String? ab = await firebaseNotificationHandler.getToken();
  // log(ab ?? '');
  // firebaseNotificationHandler.onTokenRefresh();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Firebase Push Notification',
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FirebaseNotificationHandler firebaseNotificationHandler =
      FirebaseNotificationHandler();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      initNotification();
    });
  }

  Future<void> initNotification() async {
    await firebaseNotificationHandler.initialize(context);
    await firebaseNotificationHandler.subscribeToTopic('TopicName');
    firebaseNotificationHandler.getToken().then((value) {
      log(value ?? '');
    });

    firebaseNotificationHandler.onTokenRefresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Firebase Push Notification'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            firebaseNotificationHandler.getToken().then((String? value) async {
              Map<String, dynamic> requestBody = {
                'to': '$value',
                'priority': 'high',
                'notification': {
                  'title': 'This is Title',
                  'body': 'This is Body',
                },
                'data': {'type': 'msg'},
              };
              await post(
                Uri.parse('https://fcm.googleapis.com/fcm/send'),
                headers: {
                  'Content-Type': 'application/json',
                  'Authorization':
                      'key=AAAAr-YtR_8:APA91bFluLRwajp5TKC4ZpNNnjX36hdW8g3Fg_gS31R8__i2XZmiuT4glUcI3PiD-8UPSumBVxrrcvT4uHYl3_49O3VCnxbnRmJubXk0h93nrvKMFcVwHhxEPoCocHHUqFJ_u1ISqxN-',
                },
                body: jsonEncode(requestBody),
              );
            });
          },
          child: const Text('Flutter Firebase Push Notification'),
        ),
      ),
    );
  }
}
