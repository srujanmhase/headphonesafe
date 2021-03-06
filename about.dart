import 'package:flutter/material.dart';
import 'main.dart';

class mainAbout extends StatefulWidget {
  @override
  _mainAboutState createState() => _mainAboutState();
}

class _mainAboutState extends State<mainAbout> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Container(
                height: 30,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SizedBox(
                      width: 100,
                    ),
                    Container(
                        width: 50,
                        child: FlatButton(
                          onPressed: (){
                            Navigator.of(context).pop();
                          },
                            child: Icon(Icons.close)
                        )
                    ),
                  ],
                ),
              ),
              Column(
                children: <Widget>[
                  Text(
                    "About App",
                    style: TextStyle(
                      fontSize: 25,
                      color: Colors.blueAccent,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0, bottom: 15.0, left: 15.0, right: 15.0),
                    child: Text(
                      "$longAbt"
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15.0),
                    child: Text("Important: keep your ringer on silent mode or vibrate and then start. The first notification is a troubleshoot hence ignore that. Inconvinience is regretted."),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 15.0, bottom: 15.0),
                    child: Text("All Rights Reserved Srujan S. Mhase [2020] except where explicitly mentioned otherwise."),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                    child: Column(
                      children: <Widget>[
                        Align(alignment: Alignment.topLeft, child: Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text("Individual Component Copyright Information"),
                        )),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text("Share Module: Copyright 2017, the Flutter project authors. All rights reserved."),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text("Flutter Local Notifications: Copyright 2018 Michael Bui. All rights reserved."),
                        ),
                        Align(alignment: Alignment.topLeft,child: Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text("Noise Meter by \"cachet.dk\" from \"pub.dev\""),
                        )),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text("Avatar Glow: MIT License Copyright (c) [2019] [Ayush P Gupta]"),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text("Circular Menu: Copyright (c) 2020 Hasan Mohammed github.com/hasan-hm1"),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Text("fl_chart: BSD 3-Clause License Copyright (c) 2019, Iman Khoshabi <iman.neofight@gmail.com> All rights reserved."),
                        )
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

var longAbt = "App is designed & developed by keeping in mind a requirement of being able to use earphones and headphones responsibly & giving the user a better \"wired in\" experience.";