import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'Help/GuideVideo.dart';
// Using guide:
// Use Stack Widget to allow widget floating on surface
// Use Positioned Widgets to allocate the location of dialog and message
// **Do not display message in child of dialog, the direction of letters will
// **change as the dialog rotate.
// Make sure Stack is including the whole page, refer to detail.dart to see how
// it works in a padding page.
// Make sure Positioned widgets are at the end of widget lists, so the dialog and
// Message are at the fount.

bool visible = false;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Dialog(),
      routes: {
        '/guideVideo': (context) => GuideVideo(),
      },
    );
  }
}

class Dialog extends StatelessWidget {
  const Dialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: <Widget>[
            Transform.rotate(
              angle: math.pi,
              child: ClipPath(
                clipper: DialogClipper(radius: 30, point: 1, slope: 0.8),
                child: Container(
                  width: 300,
                  height: 150,
                  color: Colors.lightBlueAccent,
                  child: const Center(child: Text('Hello')),
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, '/guideVideo');
              },
              icon:
                  const Icon(Icons.notifications_outlined, color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}

class DialogClipper extends CustomClipper<Path> {
  DialogClipper({this.radius = 16, this.point = 0, this.slope = 0.5});
  final double radius; //Radius of corner
  final int point; //Position of pointer, between{0,4}
  final double slope; //slope of the pointer, between{0,1} 0.5 is the middle
  @override
  Path getClip(Size size) {
    double width = size.width;
    double height = size.height;
    double rheight = height - height / 5;
    double oneFifth = width / 5;
    double pointer = (point + slope) * oneFifth;

    final path = Path();
    path.moveTo(0, radius);
    path.lineTo(0, rheight - radius);
    if (point != 0) {
      path.cubicTo(0, rheight - radius, 0, rheight, radius, rheight);
      path.lineTo(point * oneFifth, rheight);
    }
    path.lineTo(pointer, height);
    if (point == 4) {
      path.lineTo((point + 1) * oneFifth, rheight - radius);
    } else {
      path.lineTo((point + 1) * oneFifth, rheight);
      path.lineTo(width - radius, rheight);
      path.cubicTo(
          width - radius, rheight, width, rheight, width, rheight - radius);
    }
    path.lineTo(width, radius);
    path.cubicTo(width, radius, width, 0, width - radius, 0);
    path.lineTo(radius, 0);
    path.cubicTo(radius, 0, 0, 0, 0, radius);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => true;
}
