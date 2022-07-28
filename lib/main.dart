import 'package:flutter/material.dart';
import 'package:formforimage/mycustomform.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.red,
        primaryColor: Colors.amber,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Form'),
        ),
        body: const MyCustomForm(),
      ),
    );
  }
}
