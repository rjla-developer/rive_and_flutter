import 'package:flutter/material.dart';

//GoRouter:
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PROFILE PAGE'),
      ),
      body: Center(
        child: OutlinedButton(
          child: const Text('Editar perfil'),
          onPressed: () {
            context.goNamed('Edit profile');
          },
        ),
      ),
    );
  }
}
