import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:halleys_comet/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(color: Colors.black, titleTextStyle: TextStyle(color: Colors.white)),
        // textTheme: GoogleFonts.kanitTextTheme(
        //   Theme.of(context).textTheme.apply(
        //         bodyColor: Colors.white, // Default text color
        //         displayColor: Colors.white, // Headline text color
        //       ),
        // ),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.black,
          surface: Colors.black,
        ),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}
