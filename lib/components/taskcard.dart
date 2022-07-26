import 'package:flutter/material.dart';

class TaskCard extends StatelessWidget {
  final String title;
  final String description;

  const TaskCard({ this.title, this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: 32.0,
        horizontal: 24.0,
      ),
      margin: EdgeInsets.only(bottom: 20.0),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(20.0)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title ?? "No Title Given",
            style: TextStyle(
                color: Color(0xFF211551),
                fontSize: 22.0,
                fontWeight: FontWeight.bold),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: Text(
              description ?? "No Description Added",
              style: TextStyle(
                  fontSize: 16.0, color: Color(0xFF86829D), height: 1.5),
            ),
          )
        ],
      ),
    );
  }
}
