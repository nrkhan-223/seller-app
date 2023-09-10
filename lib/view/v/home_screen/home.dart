import 'package:get/get.dart';
import 'package:seller_app/const/const.dart';
import 'package:seller_app/controller/home_controller.dart';
import 'package:seller_app/view/v/home_screen/home_screen.dart';
import 'package:seller_app/view/v/product_sceen/product_screen.dart';
import 'package:seller_app/view/v/profile_screen/profie_Screens.dart';

import '../orders_screen/orders_screen.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());
    var navScreens = [
      const HomeScreen(),
      const ProductScreen(),
      const OrdersScreen(),
      const ProfileScreen()
    ];
    var bottomNavbar = [
      const BottomNavigationBarItem(icon: Icon(Icons.home), label: "Dashboard"),
      BottomNavigationBarItem(
          icon: Image.asset(
            icProducts,
            width: 24,
            color: darkGrey,
          ),
          label: "Products"),
      BottomNavigationBarItem(
          icon: Image.asset(
            icOrders,
            width: 24,
            color: darkGrey,
          ),
          label: "Orders"),
      BottomNavigationBarItem(
          icon: Image.asset(
            icGeneralSetting,
            width: 24,
            color: darkGrey,
          ),
          label: "Settings")
    ];

    return Scaffold(
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          onTap: (index) {
            controller.navIndex.value = index;
          },
          currentIndex: controller.navIndex.value,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: purpleColor,
          unselectedItemColor: darkGrey,
          items: bottomNavbar,
        ),
      ),
      body: Column(
        children: [
          Obx(() =>
              Expanded(child: navScreens.elementAt(controller.navIndex.value)))
        ],
      ),
    );
  }
}
