import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String label;
  final IconData? leadingIcon;
  const CustomTextField(
    {
      super.key, 
      required this.controller,
      required this.label, 
      required this.leadingIcon
    }
  );

  @override
  Widget build(BuildContext context) {

    // Border for the TextField
    final border = OutlineInputBorder(
      borderRadius: const BorderRadius.all(
        Radius.circular(20),
      ),
      borderSide: BorderSide(
          // color: Colors.white,
          color: Theme.of(context).colorScheme.secondary,
        ),
    );

    // Main TextField with customisations
    return TextField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(
        decimal: false,
        signed: false,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: Theme.of(context).colorScheme.secondary,
        label: Text(label),
        border: border,
        enabledBorder: border,
        focusedBorder: border,
        labelStyle: TextStyle(
          color: Theme.of(context).colorScheme.onSecondary,
        ),
        prefixIcon: Icon(leadingIcon),
      ),
    );
  }
}