import 'package:flutter/material.dart';
import 'package:richmond_test/pages/splash.dart';

void main(){
  runApp(Main());
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Richmond Test",
      home: Splash(),
    );
  }
}
