import 'package:flutter/material.dart';
import 'pages/pages.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Video Streaming App",
      home: StreamingAppHomePage(),
      theme: ThemeData(
        primaryColor: Colors.black,
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
