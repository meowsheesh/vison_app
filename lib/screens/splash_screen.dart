import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:textocr/bloc/blocs.dart';

const colorizeColors = [
  Colors.red,
  Colors.redAccent,
  Colors.pink,
  Colors.pinkAccent,
];

const colorizeTextStyle = TextStyle(
  fontSize: 50.0,
  fontFamily: 'Horizon',
);

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SplashScreenBloc,SplashScreenState>(
        builder: (BuildContext context, state) {
          return Scaffold(
            backgroundColor: Color(0xff101010),
            body: Center(
              child: AnimatedTextKit(
                animatedTexts: [
                  ColorizeAnimatedText(
                    'Text OCR',
                    textStyle: colorizeTextStyle,
                    colors: colorizeColors,
                  )
                ],
              ),
            ),
          );
        },
        listener: (BuildContext context, Object? state) {
          print(state);
          if (state is ReadyState) {
            Timer(Duration(seconds: 1),
                    () => Navigator.pushReplacementNamed(context, '/auth'));
          }
        },
    );
  }
}
