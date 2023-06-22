import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:image_picker/image_picker.dart';

import 'dart:io';
import 'dart:async';
import '../bloc/home_screen/home_screen.dart';
import '../widgets/card_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    final box = Hive.openBox('notes_box');
    print('inited');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeScreenBloc, HomeScreenState>(
      listener: (context, state) {
        print(state);
        if (state is ImageChoosenState) {
          Navigator.pushNamed(context, '/infoscreen', arguments: state.text);
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Color(0xff101010),
          appBar: AppBar(
            backgroundColor: Color(0xff101010),
            title: Text(''),
            actions: [
              IconButton(
                  onPressed: () => Navigator.pushNamed(context, '/historyScreen'),
                  icon: Icon(Icons.history, color: Colors.greenAccent,),
              ),
            ],
          ),
          body: Center(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              cardWidget(
                text: 'Take Photo',
                icon: Icons.add,
                iconColor: Colors.green,
                onTap: () async {
                  BlocProvider.of<HomeScreenBloc>(context)
                      .add(OnTakeImageTapped());
                },
              ),
              cardWidget(
                text: 'From Gallery',
                icon: Icons.photo,
                iconColor: Colors.redAccent,
                onTap: () async {
                  BlocProvider.of<HomeScreenBloc>(context)
                      .add(OnChooseImageTapped());
                },
              ),
            ],
          )),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
