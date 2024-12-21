import 'package:flutter/material.dart';

import 'package:bouncing_card/bouncing_card.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Bouncing Card'),
        ),
        body: const Center(
          child: BouncingCard('I Can bounce'),
        ),
      ),
    );
  }
}
