import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:textocr/services/history.dart';

class HistoryScreen extends StatefulWidget {
  final HistoryService historyService;
  const HistoryScreen({Key? key, required this.historyService})
      : super(key: key);

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  //final _historyBox = Hive.box('notes_box');
  List<Map<String, dynamic>> _items = [];
  late List history;

  @override
  void initState() {
    //widget.historyService.init();
    history = widget.historyService.getHistory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff101010),
      appBar: AppBar(
        backgroundColor: Color(0xff101010),
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'History',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: history.isEmpty
          ? Center(child: Text('History is empty'))
          : Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: [
                  ...history
                      .map(
                        (e) => Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/infoscreen',
                                  arguments: e.text.replaceAll("\n", " "));
                            },
                            child: Card(
                              elevation: 4,
                              color: Colors.white,
                              child: Column(
                                children: [
                                  Container(
                                      child: Image.file(File(e.photoPath), fit: BoxFit.cover,),
                                  height: 150,
                                  width: MediaQuery.of(context).size.width,),
                                  Ink(width: MediaQuery.of(context).size.width, height: 2, color: Colors.black,),
                                  Padding(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    child: ListTile(
                                      title: Text(
                                        e.text.replaceAll("\n", " "),
                                        maxLines: 3,
                                        style: TextStyle(
                                            fontSize: 16, color: Colors.black),
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList()
                      .reversed
                ],
              ),
            ),
    );
  }
}
