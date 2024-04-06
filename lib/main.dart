import 'package:flutter/material.dart';
import 'package:job_radar/jobform.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Job Form',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: JobForm(),
    );
  }
}
