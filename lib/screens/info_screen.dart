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
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xff1C1E1F),
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
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  message.replaceAll("\n", " "),
                  style: TextStyle(fontSize: 18),
                ),
              ),
              isPressed == false
                  ? SizedBox.shrink()
                  : Center(
                      child: CircularProgressIndicator(
                        color: Colors.red,
                      ),
                    ),
              answer.isEmpty
                  ? SizedBox.shrink()
                  : Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Card(
                        color: Colors.green,
                        child: Center(
                            child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            answer.replaceAll("\n", " "),
                            style: TextStyle(fontSize: 16),
                          ),
                        )),
                      ),
                    ),
            ]),
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 22.0, right: 5, left: 15),
              child: InkWell(
                focusColor: Colors.red,
                borderRadius: BorderRadius.circular(24),
                onTap: () async {
                  await ApiService.getModels();
                },
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    'Kek',
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
                  setState(() {
                    isPressed = true;
                    print(isPressed);
                  });
                  answer =
                      await ApiService.getAnswer(message.replaceAll("\n", " "));
                  setState(() {
                    isPressed = false;
                  });
                },
                child: Container(
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
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
    );
  }

  @override
  void dispose() {
    answer = '';
    super.dispose();
  }
}
