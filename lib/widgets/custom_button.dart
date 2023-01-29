import 'package:flutter/material.dart';


class CustomButton extends StatelessWidget {
  const CustomButton({Key? key, required this.title, this.onTap}) : super(key: key);
  final String title;
  final GestureTapCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:onTap ,
      child: Container(
        width: double.infinity,
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.teal,
        ),
        child: Center(
            child: Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 22,
                  color: Colors.white
                ),
            ),
        ),
      ),
    );
  }
}