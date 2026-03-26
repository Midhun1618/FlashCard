import 'package:flutter/material.dart';
import '../models/flash_card.dart';
import '../services/storage_service.dart';
import '../widgets/flashcard_widget.dart';

class Practice extends StatefulWidget {
  @override
  _PracticeState createState() => _PracticeState();
}

class _PracticeState extends State<Practice> {
  final StorageService storage = StorageService();

  List<Flashcard> cards = [];
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    loadCards();
  }

  void loadCards() async {
    List<Flashcard> loaded = await storage.loadCards();
    setState(() {
      cards = getPracticeCards(loaded);
    });
  }

  List<Flashcard> getPracticeCards(List<Flashcard> cards) {
    List<Flashcard> result = [];

    for (var card in cards) {
      result.add(card);
      if (card.difficulty == 2) {
        result.add(card);
      }
    }

    result.shuffle();
    return result;
  }

  void markKnown() async {
    Flashcard card = cards[currentIndex];
    if (card.difficulty > 0) card.difficulty--;

    await saveAndNext();
  }

  void markUnknown() async {
    Flashcard card = cards[currentIndex];
    if (card.difficulty < 2) card.difficulty++;

    await saveAndNext();
  }

  Future<void> saveAndNext() async {
    await storage.saveCards(cards);

    if (currentIndex < cards.length - 1) {
      setState(() {
        currentIndex++;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Session Complete 🎉")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (cards.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text("Practice")),
        body: Center(child: Text("No flashcards available")),
      );
    }

    Flashcard currentCard = cards[currentIndex];

    return Scaffold(
      appBar: AppBar(title: Text("Practice")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              "Card ${currentIndex + 1}/${cards.length}",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),

            FlashcardWidget(
              question: currentCard.question,
              answer: currentCard.answer,
            ),

            SizedBox(height: 30),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: markUnknown,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  child: Text("Again"),
                ),
                ElevatedButton(
                  onPressed: markKnown,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                  ),
                  child: Text("Known"),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}