import 'package:flashcard_app/view%20model/flashcard_view_model.dart';
import 'package:flashcard_app/widgets/Textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/flashcard.dart';

class EditFlashcardScreen extends StatelessWidget {
  final Flashcard flashcard;

  EditFlashcardScreen({required this.flashcard});

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _questionController = TextEditingController();
  final TextEditingController _answerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _questionController.text = flashcard.question;
    _answerController.text = flashcard.answer;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Flashcard',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.teal,
        elevation: 5,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header Text for Screen
              Text(
                'Edit Flashcard',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w600,
                  color: Colors.teal,
                ),
              ),
              SizedBox(height: 20),

              // Question Field
              CustomInputField(
                controller: _questionController,
                label: 'Question',
                hintText: 'What is the capital of France?',
                icon: Icons.question_answer,
                validator: (value) =>
                    value!.isEmpty ? 'Enter a question' : null,
              ),
              SizedBox(height: 20),

              // Answer Field
              CustomInputField(
                controller: _answerController,
                label: 'Answer',
                hintText: 'Paris!',
                icon: Icons.location_city,
                validator: (value) => value!.isEmpty ? 'Enter an answer' : null,
              ),
              SizedBox(height: 30),

              // Save Button
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Provider.of<FlashcardViewModel>(context, listen: false)
                        .editFlashcard(flashcard.id, _questionController.text,
                            _answerController.text);
                    Navigator.pop(context);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30), // Rounded corners
                  ),
                  elevation: 5, // Adds shadow for a raised effect
                  textStyle:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                child: Text(
                  'Save Changes',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SizedBox(height: 20),

              // Cancel Button
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.teal,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
