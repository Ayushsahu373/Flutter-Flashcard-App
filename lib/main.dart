// lib/main.dart
import 'package:flashcard_app/view%20model/flashcard_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'views/flashcard_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FlashcardViewModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flashcard App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSwatch(
            primarySwatch: Colors.teal,
          ).copyWith(
            secondary: Colors.orangeAccent,
          ),
          textTheme: TextTheme(
            headlineSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            bodyMedium: TextStyle(fontSize: 18),
          ),
        ),
        home: Banner(
          message: "Ayush Sahu", // Custom message
          location: BannerLocation.topEnd, // Top-right corner
          color: Colors.red, // Banner background color
          child: FlashcardListScreen(), // Your main screen
        ),
      ),
    );
  }
}
