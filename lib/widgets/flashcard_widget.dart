// lib/widgets/flashcard_widget.dart
import 'dart:async';
import 'package:flashcard_app/view%20model/flashcard_view_model.dart';
import 'package:flutter/material.dart';
import '../models/flashcard.dart';
import '../views/edit_flashcard_screen.dart';
import 'package:provider/provider.dart';

class FlashcardWidget extends StatefulWidget {
  final Flashcard flashcard;

  FlashcardWidget({required this.flashcard});

  @override
  _FlashcardWidgetState createState() => _FlashcardWidgetState();
}

class _FlashcardWidgetState extends State<FlashcardWidget>
    with SingleTickerProviderStateMixin {
  bool _showAnswer = false;
  late AnimationController _controller;
  late Animation<double> _flipAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize the AnimationController and Animation
    _controller = AnimationController(
      duration: Duration(milliseconds: 600),
      vsync: this,
    );
    _flipAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
  }

  void _toggleCard() {
    setState(() {
      _showAnswer = !_showAnswer;
      if (_showAnswer) {
        _controller.forward();
        Timer(Duration(seconds: 3), () {
          if (mounted) {
            setState(() {
              _showAnswer = false;
            });
            _controller.reverse();
          }
        });
      } else {
        _controller.reverse();
      }
    });
  }

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Delete Flashcard'),
        content: Text('Are you sure you want to delete this flashcard?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Provider.of<FlashcardViewModel>(context, listen: false)
                  .deleteFlashcard(widget.flashcard.id);
              Navigator.pop(context);
            },
            child: Text('Delete'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _toggleCard,
      child: AnimatedBuilder(
        animation: _flipAnimation,
        builder: (context, child) {
          final isFlipped = _flipAnimation.value >= 0.5;
          final transform = Matrix4.identity()
            ..rotateY(
                _flipAnimation.value * 3.14159); // Rotate the card 180 degrees

          return Stack(
            alignment: Alignment.center,
            children: [
              // The rotating card
              Transform(
                transform: transform,
                alignment: Alignment.center,
                child: Card(
                  elevation: 8,
                  margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  color: Colors.teal[isFlipped ? 300 : 100],
                  child: Container(
                    height: 150,
                    alignment: Alignment.center,
                  ),
                ),
              ),

              // The text, visible only when the card is not flipped
              Opacity(
                opacity: isFlipped
                    ? 0.0
                    : 1.0, // Hide text while the card is flipped
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      widget.flashcard.question,
                      style: TextStyle(
                        fontSize: 22,
                        color: Colors.black87,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.blueAccent),
                          onPressed: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => EditFlashcardScreen(
                                  flashcard: widget.flashcard),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.redAccent),
                          onPressed: () => _showDeleteConfirmation(context),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // The answer text, visible only when the card is flipped
              Opacity(
                opacity:
                    isFlipped ? 1.0 : 0.0, // Show answer when card is flipped
                child: Text(
                  widget.flashcard.answer,
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
