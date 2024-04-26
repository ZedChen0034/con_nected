import 'package:flutter/material.dart';
import '01_welcome.dart';
import '02_login.dart';
import '03_register.dart';
import '04_home.dart';
import 'package:con_nected/Event/createevent.dart';
import 'Event/calendar.dart';
import 'Event/detail.dart';
import 'peer.dart';
import 'package:con_nected/Event/doneevent.dart';
import 'help.dart';
import 'Help/chat.dart';
import 'Help/DocumentDetail.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Con-nected',
      initialRoute: '/',
      routes: {
        '/': (context) => MainScreen(),
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/home': (context) => HomePage(),
        '/calendar': (context) => const Calendar(),
        '/createEvent': (context) => Createevent(),
        '/doneEvent': (context) => Doneevent(),
        '/detail': (context) => Detail(),
        '/help': (context) => Help(),
        '/chat': (context) => Chat(),
        '/documentDetail': (context) => DocumentDetail(),
        '/peer': (context) => Peer(),
      },
    );
  }
}
