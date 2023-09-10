import 'package:seller_app/const/const.dart';

Widget productImages({required label,onPress}){
  return Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(11),
        border: Border.all(color: white)
    ),
    child: "$label".text.bold.color(white).size(16).makeCentered(),
  ).box.size(90, 90).make();
}