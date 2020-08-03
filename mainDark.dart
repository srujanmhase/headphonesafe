import 'package:flutter/material.dart';
import 'package:circular_menu/circular_menu.dart';
import 'homecomponents.dart';
import 'aboutDark.dart';
import 'settingsDark.dart';
import 'darkcomponents.dart';
import 'package:share/share.dart';


class darkMain extends StatefulWidget {
  @override
  _darkMainState createState() => _darkMainState();
}

class _darkMainState extends State<darkMain> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: SafeArea(
        child: CircularMenu(
          alignment: Alignment.topLeft,
          toggleButtonColor: Colors.grey[700],
          backgroundWidget: myHomeDark(),
          items: [
            CircularMenuItem(
                icon: Icons.info_outline,
                color: Colors.grey[700],
                onTap: () {
                  Navigator.of(context).push(startToAboutRoute());
                }),
            CircularMenuItem(
                icon: Icons.share,
                color: Colors.grey[700],
                onTap: () {
                  final RenderBox box = context.findRenderObject();
                  Share.share("I am using the HeadPhoneSafe App to make sure I use my Earphones/Headphones responsibly. You can too! http://srujanmhase.in/",
                      sharePositionOrigin:
                      box.localToGlobal(Offset.zero) &
                      box.size);
                }),
            CircularMenuItem(
                icon: Icons.report_problem,
                color: Colors.grey[700],
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
    pageBuilder: (context, animation, secondaryAnimation) => mainAboutDark(),
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
    pageBuilder: (context, animation, secondaryAnimation) => mainSettingsDark(),
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
