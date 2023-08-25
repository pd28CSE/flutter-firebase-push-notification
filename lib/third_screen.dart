import 'package:flutter/material.dart';

class ThirdScreen extends StatelessWidget {
  final String info;
  const ThirdScreen({super.key, required this.info});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Third Screen, '),
      ),
      body: const Center(
        child: Text(
            'App was terminated and currently Opened by Notification Tap.'),
      ),
    );
  }
}
