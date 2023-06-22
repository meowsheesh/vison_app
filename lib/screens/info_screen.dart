import 'package:flutter/material.dart';
import 'package:textocr/services/api_service.dart';

class InfoScreen extends StatefulWidget {
  const InfoScreen({super.key});

  @override
  State<InfoScreen> createState() => _InfoScreenState();
}

String answer = '';

class _InfoScreenState extends State<InfoScreen> {
  @override
  Widget build(BuildContext context) {
    String message = ModalRoute.of(context)!.settings.arguments as String;
    String id = '';
    bool isPressed = false;

    return Scaffold(
      backgroundColor: Color(0xff101010),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xff101010),
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          PopupMenuButton(
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    child: Text('text-davinci-003'),
                    value: 0,
                  ),
                  PopupMenuItem(
                    child: Text('text-davinci-003'),
                    value: 1,
                  )
                ];
              },
              icon: Icon(Icons.settings),
              onSelected: (value) {
                if (value == 0) {
                  id = 'text-davinci-003';
                } else if (value == 1) {
                  id = 'text-davinci-003';
                }
              })
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: message.isEmpty ? Text('Empty') : Text(
                    message.replaceAll("\n", " "),
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                answer.isEmpty
                    ? SizedBox.shrink()
                    : Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Card(
                          color: Colors.white,
                          child: Center(
                              child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              answer.replaceAll("\n", " "),
                              style: TextStyle(fontSize: 16,color: Colors.black),
                            ),
                          )),
                        ),
                      ),
              ]),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(top: 18.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 22.0, right: 5, left: 15),
                child: InkWell(
                  focusColor: Colors.red,
                  borderRadius: BorderRadius.circular(24),
                  onTap: () async {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return Dialog(
                          backgroundColor: Colors.transparent,
                          surfaceTintColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          elevation: 0,
                          child: Center(child: CircularProgressIndicator(
                            color: Colors.pinkAccent,
                          )),
                        );
                      },
                    );
                    answer =
                    await ApiService.getLongAnswer(message.replaceAll("\n", " "));
                    Navigator.pop(context);
                    setState(() {
                    });
                  },
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Answer',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 22.0, right: 5, left: 15),
                child: InkWell(
                  borderRadius: BorderRadius.circular(24),
                  onTap: () async {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) {
                        return Dialog(
                          backgroundColor: Colors.transparent,
                          surfaceTintColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          elevation: 0,
                          child: Center(child: CircularProgressIndicator(
                            color: Colors.pinkAccent,
                          )),
                        );
                      },
                    );
                    answer =
                        await ApiService.getAnswer(message.replaceAll("\n", " "));
                    Navigator.pop(context);
                    setState(() {
                    });
                  },
                  child: Container(
                    height: 40,
                    decoration: BoxDecoration(
                      color: Colors.pinkAccent,
                      borderRadius: BorderRadius.circular(24),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      'Short answer',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    answer = '';
    super.dispose();
  }
}
