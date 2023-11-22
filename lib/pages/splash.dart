import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:richmond_test/pages/first_open.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

import 'package:richmond_test/pages/test.dart';

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SecondPage(),
    );
  }
}

class SecondPage extends StatefulWidget {
  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  @override
  void initState() {
    super.initState();

    Timer(Duration(milliseconds: 400), () {
      setState(() {
        _a = true;
      });
    });
    Timer(Duration(milliseconds: 400), () {
      setState(() {
        _b = true;
      });
    });
    Timer(Duration(milliseconds: 1300), () {
      setState(() {
        _c = true;
      });
    });
    Timer(Duration(milliseconds: 1700), () {
      setState(() {
        _e = true;
      });
    });
    Timer(Duration(milliseconds: 3400), () {
      setState(() {
        _d = true;
      });
    });
    Timer(Duration(milliseconds: 3850), () {
      setState(() {
        Navigator.of(context).pushReplacement(
          ThisIsFadeRoute(route: ThirdPage(), page: Scaffold()),
        );
      });
    });
  }

  bool _a = false;
  bool _b = false;
  bool _c = false;
  bool _d = false;
  bool _e = false;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double _h = MediaQuery.of(context).size.height;
    double _w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.blue.shade500,
      body: Center(
        child: Column(
          children: [
            AnimatedContainer(
              duration: Duration(milliseconds: _d ? 900 : 2500),
              curve: _d ? Curves.fastLinearToSlowEaseIn : Curves.elasticOut,
              height: _d
                  ? 0
                  : _a
                      ? _h / 2
                      : 20,
              width: 20,
              // color: Colors.deepPurpleAccent,
            ),
            AnimatedContainer(
              duration: Duration(
                  seconds: _d
                      ? 1
                      : _c
                          ? 2
                          : 0),
              curve: Curves.fastLinearToSlowEaseIn,
              height: _d
                  ? _h
                  : _c
                      ? 80
                      : 20,
              width: _d
                  ? _w
                  : _c
                      ? 400
                      : 50,
              decoration: BoxDecoration(
                  color: _b ? Colors.white : Colors.transparent,
                  // shape: _c? BoxShape.rectangle : BoxShape.circle,
                  borderRadius:
                      _d ? BorderRadius.only() : BorderRadius.circular(30)),
              child: Center(
                child: _e
                    // ? AnimatedTextKit(
                    //     totalRepeatCount: 1,
                    //     animatedTexts: [
                    //       FadeAnimatedText(
                    //         'RICHMOND TEST',
                    //         duration: Duration(milliseconds: 1700),
                    //         textStyle: TextStyle(
                    //           fontSize: 30,
                    //           fontWeight: FontWeight.w700,
                    //         ),
                    //       ),
                    //     ],
                    //   )
                    ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(image: AssetImage("assets/image/favicon.png")),
                          AnimatedTextKit(
                            totalRepeatCount: 1,
                            animatedTexts: [
                              FadeAnimatedText(
                                'RICHMOND TEST',
                                duration: Duration(milliseconds: 1700),
                                textAlign: TextAlign.center,
                                textStyle: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          )
                        ],
                      )
                    : SizedBox(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ThisIsFadeRoute extends PageRouteBuilder {
  final Widget page;
  final Widget route;

  ThisIsFadeRoute({required this.page, required this.route})
      : super(
          pageBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
          ) =>
              page,
          transitionsBuilder: (
            BuildContext context,
            Animation<double> animation,
            Animation<double> secondaryAnimation,
            Widget child,
          ) =>
              FadeTransition(
            opacity: animation,
            child: route,
          ),
        );
}

class ThirdPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: verifyIfAppOpened(),
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.hasData) {
          return snapshot.data! ? TestsPage() : FirstOpen();
        } else {
          return ErrorWidget("Internal Fatal Error");
        }
      },
    );
  }

  Future<bool> verifyIfAppOpened() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    bool appOpenedBefore = _prefs.getBool('openedBefore') ?? false;
    if (!appOpenedBefore) {
      _prefs.setBool('openedBefore', true);
      return false;
    }
    return true;
  }
}
