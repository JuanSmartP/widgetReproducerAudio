 
 
import 'package:flutter/material.dart';
import 'package:fluttertest/ui/screens/home_body.dart';

/// The `main` function initializes the `AppState` widget which provides multiple BLoC providers for
/// managing different states in the Flutter application.

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: HomeBody(),
    );
  }
}
