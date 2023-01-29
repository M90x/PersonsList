import 'package:flutter/material.dart';


class CustomInput extends StatelessWidget {
  const CustomInput({required this.label, required this.textEditingController, required this.icon}) : super();

  final String label;
  final IconData icon;
  final TextEditingController textEditingController;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.0 ),
      child: TextFormField(
        controller: textEditingController,
        decoration: InputDecoration(
            prefixIcon: Icon(icon),
            label: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 22,
              ),
            ),
        ),
      ),
    );
  }
}