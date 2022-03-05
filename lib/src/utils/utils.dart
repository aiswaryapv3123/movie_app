import 'package:flutter/material.dart';

double screenHeight(context, {double dividedBy = 1}) {
  return MediaQuery.of(context).size.height / dividedBy;
}

double screenWidth(context, {double dividedBy = 1}) {
  return MediaQuery.of(context).size.width / dividedBy;
}

void push(context, Widget route) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => route));
}

void pop(context) {
  Navigator.pop(context);
}