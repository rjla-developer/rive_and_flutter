import 'package:flutter/material.dart';

class ChangeAgeScreen extends StatelessWidget {
  const ChangeAgeScreen({super.key, required this.age});
  final int age;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Age Change'),
      ),
      body: Center(
        child: Text('Age: $age'),
      ),
    );
  }
}
