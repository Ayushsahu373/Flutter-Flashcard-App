import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hintText;
  final IconData icon;
  final FormFieldValidator<String>? validator;

  const CustomInputField({
    required this.controller,
    required this.label,
    required this.hintText,
    required this.icon,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey),
        prefixIcon: Icon(icon, color: Colors.teal), // Icon for the input field
        filled: true,
        fillColor: Colors.teal.shade50,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.teal, width: 2),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 18, horizontal: 20),
      ),
      validator: validator ?? (value) => value!.isEmpty ? 'This field cannot be empty' : null,
    );
  }
}
