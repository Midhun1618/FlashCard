import 'package:flutter/material.dart';
import 'practice.dart';
import 'add_card.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("FlashMaster")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text("Start Practice"),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => Practice()));
              },
            ),
            ElevatedButton(
              child: Text("Add Flashcard"),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => AddCard()));
              },
            ),
          ],
        ),
      ),
    );
  }
}