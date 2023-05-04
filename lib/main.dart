import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:textocr/bloc/home_screen/home_screen_bloc.dart';
import 'package:textocr/screens/info_screen.dart';
import 'package:textocr/screens/splash_screen.dart';

import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => SplashScreen(),
        '/home': (context) => BlocProvider<HomeScreenBloc>(
              create: (context) => HomeScreenBloc(),
              child: HomeScreen(),
            ),
        '/infoscreen': (context) => InfoScreen(),
      },
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: const Color(0xff1C1E1F),
          secondary: const Color(0xff1C1E1F),
        ),
        scaffoldBackgroundColor: const Color(0xff1C1E1F),
        textTheme: const TextTheme(
          headline1: TextStyle(color: Colors.white),
          headline2: TextStyle(color: Colors.white),
          bodyText2: TextStyle(color: Colors.white),
          subtitle1: TextStyle(color: Colors.white),
          subtitle2: TextStyle(color: Colors.white),
          bodyText1: TextStyle(color: Colors.white),
          headline4: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
