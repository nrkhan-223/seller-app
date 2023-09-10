import 'package:seller_app/const/const.dart';
import 'package:seller_app/controller/products_controller.dart';
import 'package:seller_app/view/v/widgets/text_style.dart';

Widget productDropdown(
    hint, List<String> list, dropvalue, ProductsController controller) {
  return Container(
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(11),
        border: Border.all(color: white)),
    child: DropdownButtonHideUnderline(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 1.2),
        child: DropdownButton(
          dropdownColor: purpleColor,
          style: const TextStyle(
            color: Colors.white
          ),
            hint: semiboldText(text: "$hint"),
            value: dropvalue.value == '' ? null : dropvalue.value,
             isExpanded: true,
            items: list.map((e) {
              return DropdownMenuItem(
                  value: e, child: e.toString().text.make());
            }).toList(),
            onChanged: (newValue) {
              if (hint == "Category") {
                controller.subcategoryValue.value = '';
                controller.generateSubCategoryList(newValue.toString());
              }
              dropvalue.value = newValue.toString();
            }),
      ),
    ),
  );
}
