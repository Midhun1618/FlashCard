class Flashcard {
  String question;
  String answer;
  int difficulty;

  Flashcard({
    required this.question,
    required this.answer,
    this.difficulty = 0,
  });

  Map<String, dynamic> toJson() => {
        'question': question,
        'answer': answer,
        'difficulty': difficulty,
      };

  factory Flashcard.fromJson(Map<String, dynamic> json) {
    return Flashcard(
      question: json['question'],
      answer: json['answer'],
      difficulty: json['difficulty'],
    );
  }
}