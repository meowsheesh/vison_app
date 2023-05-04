import 'package:flutter/material.dart';

Widget cardWidget(
    {required String text,
    required IconData icon,
    required Color iconColor,
    required Function() onTap}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        width: 100,
        height: 100,
        child: Card(
          elevation: 2,
          color: iconColor,
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: onTap,
            child: Icon(icon),
          ),
        ),
      ),
      Text(text),
    ],
  );
}
