import 'package:flutter/material.dart';
import 'package:globalia/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Globalia',
      theme: AppTheme.lightTheme(),
      darkTheme: AppTheme.darkTheme(),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(onPressed: () {}, child: Text("Dummy")),
          Center(
            child: Text(
              "Mastermind Rules",
              style: TextStyle(fontFamily: "Axiforma", fontSize: 50),
            ),
          ),
        ],
      ),
    );
  }
}
