import 'package:intl/intl.dart';
import 'package:flutter/material.dart';

class DateTimeModel {
  int? id;
  final String date;
  final String startTime;
  final String endTime;

  DateTimeModel({
    this.id,
    required this.date,
    required this.startTime,
    required this.endTime,
  });
  factory DateTimeModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return DateTimeModel(
      id: json['id'],
      date: json['date'],
      startTime: json['from'],
      endTime: json['to'],
    );
  }

  Map<String, dynamic> toJson() {
    // String formattedStartTime = startTime.hour.toString().padLeft(2, '0') +
    //     ":" +
    //     startTime.minute.toString().padLeft(2, '0');
    // String formattedEndTime = endTime.hour.toString().padLeft(2, '0') +
    //     ":" +
    //     endTime.minute.toString().padLeft(2, '0');
    return {
      'date': date,
      'from': startTime,
      'to': endTime,
    };
  }
}
