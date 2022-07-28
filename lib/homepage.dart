import 'package:country_codes/country_codes.dart';
import 'package:country_pickers/country_pickers.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(),
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
    );
  }
}
