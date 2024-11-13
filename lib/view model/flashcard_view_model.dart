import 'package:flutter/material.dart';
import '../models/flashcard.dart';

class FlashcardViewModel extends ChangeNotifier {
  final List<Flashcard> _flashcards = [];
  final List<Flashcard> _deletedFlashcards =
      []; // List to store deleted flashcards temporarily

  List<Flashcard> get flashcards => List.unmodifiable(_flashcards);
  List<Flashcard> get deletedFlashcards =>
      List.unmodifiable(_deletedFlashcards);

  // Add a new flashcard
  void addFlashcard(String question, String answer) {
    final newCard = Flashcard(
      id: UniqueKey().toString(),
      question: question,
      answer: answer,
    );
    _flashcards.add(newCard);
    notifyListeners();
  }

  // Edit an existing flashcard
  void editFlashcard(String id, String question, String answer) {
    final index = _flashcards.indexWhere((card) => card.id == id);
    if (index != -1) {
      _flashcards[index].question = question;
      _flashcards[index].answer = answer;
      notifyListeners();
    }
  }

  // Delete a flashcard
  // Delete a flashcard
  void deleteFlashcard(String id) {
    // Safely handle the case where the flashcard may not be found
    final flashcardToDelete = _flashcards.firstWhere(
      (card) => card.id == id,
      orElse: () => Flashcard(
          id: '', question: '', answer: ''), // Default empty flashcard object
    );

    if (flashcardToDelete.id.isNotEmpty) {
      _flashcards.remove(flashcardToDelete);
      _deletedFlashcards.add(
          flashcardToDelete); // Temporarily store it for undo functionality
      notifyListeners();
    } else {
      // Optionally handle the case where the flashcard was not found
      print('Flashcard not found');
    }
  }

  // Restore a deleted flashcard
  void restoreFlashcard(Flashcard flashcard) {
    if (!_flashcards.contains(flashcard)) {
      _flashcards.add(flashcard);
      _deletedFlashcards.remove(flashcard);
      notifyListeners();
    }
  }
}
