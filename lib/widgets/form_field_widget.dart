import 'package:flutter/material.dart';

class FormFieldWidget extends StatelessWidget {
  
  final TextEditingController controller;
  final String label;
  final String? hint;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final int? maxLength;
  final Widget? prefixIcon;
  
  const FormFieldWidget({ 
    Key? key, 
    required this.controller,
    required this.label, 
    this.hint,
    this.validator,
    this.keyboardType,
    this.maxLength, 
    this.prefixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: prefixIcon,
      ),
      maxLength: maxLength,
      validator: validator,
      keyboardType: keyboardType,
    );
  }
}