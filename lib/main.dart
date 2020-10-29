import 'package:flutter/material.dart';
import 'pages/pages.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Video Streaming App",
      home: NavScreen(),
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey[900],
        primaryColor: Colors.black,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
