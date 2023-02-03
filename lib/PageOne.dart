import 'package:flutter/material.dart';

class PageOne extends StatelessWidget {
  PageOne({Key? key, required this.title}) : super(key: key);
  String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue[100],
      child: Center(
        child: Text(
          title,
          style: TextStyle(
            color: Colors.blue[900],
            fontSize: 45,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
