import 'package:flutter/material.dart';
import 'package:glubapp/view/error404.dart';
import 'package:glubapp/view/listaircraftpage.dart';
import 'package:glubapp/view/homepage.dart';
import 'package:glubapp/view/newaircraftpage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GlubApp',
      initialRoute: '/',
      routes: {
        '/list': (context) => const ListAircraftPage(),
        '/newAircraft': (context) => const NewAircraft(),
      },
      onGenerateRoute: (settings) =>
          MaterialPageRoute(builder: (context) => const Error404()),
      theme: ThemeData(
        primaryColor: const Color.fromARGB(255, 170, 170, 253),
        highlightColor: const Color(0XFFB7B7D2),
        // ignore: deprecated_member_use
        textTheme: const TextTheme(
            displayLarge: TextStyle(
          fontSize: 19.0,
          fontWeight: FontWeight.bold,
          color: Color(0XFF030047),
        )),
      ),
      home: const SplashScreen(),
    );
  }
}
