import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:seller_app/const/const.dart';
import 'package:seller_app/view/v/messages_screen/sender_buble.dart';
import '../widgets/text_style.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: purpleColor,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Get.back();
          },
        ),
        title: boldText(text: "Message Screen", size: 18.0),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
                child: ListView.builder(itemCount:20,itemBuilder:(context,index){
                  return senderBubble();
                }),
            ),
            10.heightBox,
            SizedBox(
                height: 63,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        child: TextFormField(
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        isDense: true,
                        hintStyle: const TextStyle(color: Colors.white),
                        hintText: "Type  massage ...",
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(11),
                            borderSide: const BorderSide(color: Colors.white)),
                        border: const OutlineInputBorder(
                            borderSide: BorderSide(
                          color: Colors.white,
                        )),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white)),
                      ),
                    )),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.send,
                          color: Colors.white,
                        ))
                  ],
                )
                    .box
                    .height(60)
                    .padding(const EdgeInsets.only(left: 10, bottom: 10))
                    .margin(const EdgeInsets.only(bottom: 8))
                    .make())
          ],
        ),
      ),
    );
  }
}
