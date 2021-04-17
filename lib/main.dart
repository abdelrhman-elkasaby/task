import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:task_isaak/screens/loginScreen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        elevatedButtonTheme: ElevatedButtonThemeData(style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.grey.withOpacity(0.1)))),
        primarySwatch: Colors.teal,
      ),
      home: LoginScreen(),
    );
  }
}
