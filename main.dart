import 'package:flutter/material.dart';
import 'package:circular_menu/circular_menu.dart';
import 'homecomponents.dart';
import 'about.dart';
import 'settings.dart';
import 'package:share/share.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}


class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: SafeArea(
          child: CircularMenu(
            alignment: Alignment.topLeft,
            toggleButtonColor: Colors.blueAccent,
            backgroundWidget: homeComponents(),
            items: [
              CircularMenuItem(
                  icon: Icons.info_outline,
                  color: Colors.blueAccent,
                  onTap: () {
                    Navigator.of(context).push(startToAboutRoute());
                  }),
              CircularMenuItem(
                  icon: Icons.share,
                  color: Colors.blueAccent,
                  onTap: () {
                    final RenderBox box = context.findRenderObject();
                    Share.share("I am using the HeadPhoneSafe App to make sure I use my Earphones/Headphones responsibly. You can too! http://headphonesafe.srujanmhase.in/",
                        sharePositionOrigin:
                        box.localToGlobal(Offset.zero) &
                        box.size);
                  }),
              CircularMenuItem(
                  icon: Icons.report_problem,
                  color: Colors.blueAccent,
                  onTap: () {
                    Navigator.of(context).push(startToSettingsRoute());
                  }),
            ],
          ),
      ),
    );
  }
}

Route startToAboutRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => mainAbout(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(0.0, 1.0);
      var end = Offset.zero;
      var curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

Route startToSettingsRoute() {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => mainSettings(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      var begin = Offset(0.0, 1.0);
      var end = Offset.zero;
      var curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
