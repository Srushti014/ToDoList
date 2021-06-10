import 'package:flutter/material.dart';

class ToDoModel {
  String listType;
  String title;
  String desc;
  Color color;
  String date;
  String time;

  bool isEmpty;

  ToDoModel({
    this.listType = "",
    this.title = "",
    this.desc = "",
    this.color = Colors.black38,
    this.isEmpty = true,
    this.date = "",
    this.time = "",
  });
}
