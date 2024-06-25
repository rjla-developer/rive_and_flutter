import 'package:flutter/material.dart';

// GoRouter:
import 'package:go_router/go_router.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  int? ageFromUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Edit profile'),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Coloca tu edad',
              ),
              onChanged: (value) => ageFromUser = int.tryParse(value),
            ),
            ElevatedButton(
              onPressed: () {
                context.go('/profile/edit-profile/$ageFromUser');
              },
              child: const Text('Change age'),
            ),
          ],
        ),
      ),
    );
  }
}
