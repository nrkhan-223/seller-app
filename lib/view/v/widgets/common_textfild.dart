import 'package:seller_app/const/const.dart';
import 'package:seller_app/view/v/widgets/text_style.dart';

Widget commonTextField({label, hint, controller, isDesc = false}) {
  return TextFormField(
    controller: controller,
    maxLines: isDesc ? 4 : 1,
    style: const TextStyle(color: Colors.white),
    decoration: InputDecoration(
      isDense: true,
      label: semiboldText(text: label),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(11),
          borderSide: const BorderSide(color: Colors.white)),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(11),
          borderSide: const BorderSide(color: Colors.white)),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(11),
          borderSide: const BorderSide(color: Colors.white)),
      hintText: hint,
      hintStyle: const TextStyle(color: lightGrey),
    ),
  );
}
