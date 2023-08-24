import 'dart:developer';

import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';

import './firebase_notification_handler.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FirebaseNotificationHandler().initialize();
  await FirebaseNotificationHandler().subscribeToTopic('TopicName');
  String? ab = await FirebaseNotificationHandler().getToken();
  log(ab ?? '');
  FirebaseNotificationHandler().onTokenRefresh();

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Firebase Push Notification'),
      ),
      body: const Center(
        child: Text('Flutter Firebase Push Notification'),
      ),
    );
  }
}
