import '../../../../const/const.dart';

Widget orderPlaceDetails(
    {  title1,  title2, d1, d2}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            "$title1".text.semiBold.color(purpleColor).make(),
            2.heightBox,
            "$d1".text.semiBold.color(red).make(),
          ],
        ),
        SizedBox(width: 120,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             "$title2".text.semiBold.color(purpleColor).make(),
              2.heightBox,
             "$d2".text.color(purpleColor).make(),
            ],
          ),
        ),
      ],
    ),
  );
}
