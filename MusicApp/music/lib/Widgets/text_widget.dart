import 'package:flutter/material.dart';


Widget Text_Widget(String text, double? fontSize, Color color,String family){
  return Text(text,style: TextStyle(fontSize: fontSize,color:color, fontFamily:  family),);
}