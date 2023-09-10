import 'package:seller_app/const/const.dart';

Widget normalText({text,color= Colors.white,size=14.0}){
  return "$text".text.color(color).size(size).make();
}
Widget semiboldText({text,color= Colors.white,size=14.0}){
  return "$text".text.semiBold.color(color).size(size).make();
}
Widget boldText({text,color= Colors.white,size=14.0}){
  return "$text".text.bold.color(color).size(size).make();
}
Widget currencyText({text,color= Colors.white,size=14.0}){
  return Row(mainAxisAlignment: MainAxisAlignment.center,
     children: [
       "\$".text.semiBold.size(16).make(),2.widthBox,
       "$text".numCurrency.text.semiBold.color(color).size(size).make()
     ],
   ).box.width(86).make();
}