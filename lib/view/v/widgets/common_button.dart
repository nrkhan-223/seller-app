import 'package:flutter/material.dart';
import 'package:seller_app/const/colors.dart';
import 'package:seller_app/view/v/widgets/text_style.dart';

Widget commonButton({title, color = purpleColor, onPress}) {
  return ElevatedButton(
    onPressed:onPress,
    style: ElevatedButton.styleFrom(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(11)),
        backgroundColor: color, padding: const EdgeInsets.all(10)),
    child: semiboldText(text: title, size: 16.0),
  );
}
