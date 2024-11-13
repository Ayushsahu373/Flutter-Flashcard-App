// lib/views/flashcard_list_screen.dart
import 'package:flashcard_app/view%20model/flashcard_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'add_flashcard_screen.dart';
import '../widgets/flashcard_widget.dart';

class FlashcardListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final flashcardViewModel = Provider.of<FlashcardViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('My Flashcards',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600)),
        centerTitle: true,
        backgroundColor: Colors.teal,
      ),
      body: ListView.builder(
        itemCount: flashcardViewModel.flashcards.length,
        itemBuilder: (context, index) {
          final flashcard = flashcardViewModel.flashcards[index];
          return FlashcardWidget(flashcard: flashcard);
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.teal,
        child: Icon(Icons.add, color: Colors.white),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => AddFlashcardScreen()),
        ),
      ),
    );
  }
}
