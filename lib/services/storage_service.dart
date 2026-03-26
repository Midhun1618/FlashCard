import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/flash_card.dart';

class StorageService {
  static const String key = "flashcards";

  Future<void> saveCards(List<Flashcard> cards) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> data =
        cards.map((c) => jsonEncode(c.toJson())).toList();
    prefs.setStringList(key, data);
  }

  Future<List<Flashcard>> loadCards() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? data = prefs.getStringList(key);

    if (data == null) return [];

    return data
        .map((e) => Flashcard.fromJson(jsonDecode(e)))
        .toList();
  }
}