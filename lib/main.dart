import 'package:flutter/material.dart';

//Widgets:
import 'package:rive_and_flutter/app_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppNavigation.router,
      title: 'Rive Animation Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
