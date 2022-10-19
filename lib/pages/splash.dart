import 'package:blog_post/pages/createBlog.dart';
import 'package:blog_post/pages/login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:page_transition/page_transition.dart';

class Splash extends StatelessWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: 'images/logo.png',
      nextScreen: Login(),
      duration: 2000,
      backgroundColor: Color(0xffffffff),
      splashTransition: SplashTransition.fadeTransition,
      splashIconSize: 300,
      );
  }
}