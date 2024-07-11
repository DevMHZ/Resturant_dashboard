import 'package:flutter/material.dart';

Widget buildCard(BuildContext context, {required List<Widget> children}) {
  return LayoutBuilder(
    builder: (context, constraints) {
      bool isWideScreen = constraints.maxWidth > 600;
      return Card(
        color: Colors.orange[50],
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: isWideScreen ? EdgeInsets.all(32.0) : EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: children,
          ),
        ),
      );
    },
  );
}