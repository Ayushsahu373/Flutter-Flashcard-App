import 'package:flashcard_app/view%20model/flashcard_view_model.dart';
import 'package:flashcard_app/widgets/Textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddFlashcardScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _questionController = TextEditingController();
  final TextEditingController _answerController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Flashcard',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.teal,
        elevation: 4, // Adds a subtle shadow to the app bar
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0), // Increased padding for better spacing
        child: SingleChildScrollView(
          // Allows for scrolling if keyboard is visible
          child: Form(
            key: _formKey, // Add Form widget here
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Create a New Flashcard',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w600,
                    color: Colors.teal,
                  ),
                ),
                SizedBox(height: 20),

                // Using the CustomInputField for Question
                CustomInputField(
                  controller: _questionController,
                  label: 'Question',
                  hintText: 'What is the capital of France?',
                  icon: Icons.question_answer,
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter a question' : null,
                ),
                SizedBox(height: 16),

                // Using the CustomInputField for Answer
                CustomInputField(
                  controller: _answerController,
                  label: 'Answer',
                  hintText: 'Paris!',
                  icon: Icons.location_city,
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter an answer' : null,
                ),
                SizedBox(height: 20),

                // Add Flashcard button with validation
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          Colors.teal, // Background color of the button
                      padding:
                          EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(30), // Rounded corners
                      ),
                      elevation: 5, // Shadow effect for the button
                      textStyle:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // If form is valid, add flashcard
                        Provider.of<FlashcardViewModel>(context, listen: false)
                            .addFlashcard(_questionController.text,
                                _answerController.text);
                        Navigator.pop(context); // Close the screen after adding
                      }
                    },
                    child: Text(
                      'Add Flashcard',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
