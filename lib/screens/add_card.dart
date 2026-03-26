import 'package:flutter/material.dart';
import '../models/flash_card.dart';
import '../services/storage_service.dart';

class AddCard extends StatefulWidget {
  @override
  _AddCardState createState() => _AddCardState();
}

class _AddCardState extends State<AddCard> {
  final questionController = TextEditingController();
  final answerController = TextEditingController();

  final StorageService storage = StorageService();

  void saveCard() async {
    if (questionController.text.isEmpty ||
        answerController.text.isEmpty) return;

    List<Flashcard> cards = await storage.loadCards();

    cards.add(Flashcard(
      question: questionController.text,
      answer: answerController.text,
    ));

    await storage.saveCards(cards);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Add Flashcard")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: questionController,
              decoration: InputDecoration(
                labelText: "Question",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: answerController,
              decoration: InputDecoration(
                labelText: "Answer",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: saveCard,
              child: Text("Save Card"),
            )
          ],
        ),
      ),
    );
  }
}