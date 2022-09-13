import 'package:flutter/material.dart';
class Answer extends StatelessWidget {
 final String answerText;
 final Color answerColor;
 final VoidCallback answerTap;
  Answer({required this.answerText, required this.answerColor, required this.answerTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: answerTap,
      child: Container(
        height: 40,
        width: double.infinity,
        margin:const  EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        padding:const  EdgeInsets.symmetric(horizontal: 30),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.blue),
          color: answerColor,
        ),
        child: Center(
            child: Text(answerText,
            style: const TextStyle(
              fontSize: 15,
            ),
            )),
      ),
    );
  }
}
