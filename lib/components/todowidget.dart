import 'package:flutter/material.dart';

class TodoWidget extends StatelessWidget {

  final String text;
  final bool isDone;

  TodoWidget({this.text, this.isDone});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 24,vertical: 8
      ),
      child: Row(
        children: [
          Container(
            width: 20,
            height: 20,
            margin: EdgeInsets.only(right: 12),
            decoration: BoxDecoration(
              color: isDone ? Color(0xFF7349FE): Colors.transparent,
              borderRadius: BorderRadius.circular(6),
              border: isDone ? null : Border.all(
                color: Color(0xFF86829D),
                width: 1.5
              )
            ),
            child: Image(
              image: AssetImage("assets/images/check_icon.png"),
            ),
          ),
          Flexible(
            child: Text(
            text ?? "Unnamed Todo",
            style: TextStyle(
              color: isDone ? Color(0xFF211551) : Color(0xFF86829D),
              fontSize: 16,
              fontWeight: isDone ? FontWeight.bold : FontWeight.w500
            ),
            ),
          ),
        ],
      ),
    );
  }
}
