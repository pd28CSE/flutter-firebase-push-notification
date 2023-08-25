import 'package:flutter/material.dart';

class SecondScreen extends StatelessWidget {
  final String info;
  const SecondScreen({super.key, required this.info});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Second Screen, $info'),
      ),
      body: const Center(
        child: Text('App is Foreground and Notification Tap.'),
      ),
    );
  }
}
