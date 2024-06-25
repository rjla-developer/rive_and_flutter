import 'package:flutter/material.dart';

//GoRouter:
import 'package:go_router/go_router.dart';

//Constants:
import 'package:rive_and_flutter/constants.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('PROFILE PAGE'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              backgroundColor: kTertiaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              minimumSize: Size(screenSize.width * 0.8, 50),
            ),
            child: const Text(
              'Editar perfil',
              style: TextStyle(color: kSecondaryColor),
            ),
            onPressed: () {
              context.goNamed('Edit profile');
            },
          ),
        ),
      ),
    );
  }
}
