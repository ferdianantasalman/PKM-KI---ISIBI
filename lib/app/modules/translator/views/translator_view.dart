import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:isibi/app/shared/theme.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../../shared/page_index_controller.dart';
import '../controllers/translator_controller.dart';

class TranslatorView extends GetView<TranslatorController> {
  final translatorC = Get.find<TranslatorController>();
  final pageC = Get.find<PageIndexController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Icon(
                Icons.arrow_back,
                color: Colors.black,
              )),
          title: Text(
            'Translator',
            style: bold.copyWith(fontSize: 20, color: Colors.black),
          ),
          centerTitle: true,
        ),
        body: WebViewWidget(controller: translatorC.webViewController),
        //     Column(
        //   children: [
        //     WebViewWidget(controller: translatorC.webViewController),
        //     SizedBox(height: 5,),
        //     Text("data")
        //   ],
        // )
        bottomNavigationBar: CurvedNavigationBar(
          height: 60,
          index: 1,
          color: Color(0xff034A9E),
          animationCurve: Curves.bounceInOut,
          animationDuration: Duration(milliseconds: 300),
          backgroundColor: Colors.white,
          // style: TabStyle.fixedCircle,
          items: [
            Icon(
              Icons.home,
              size: 40,
              color: Colors.white,
            ),
            Icon(
              Icons.camera_alt_outlined,
              size: 40,
              color: Colors.white,
            ),
            Icon(
              Icons.newspaper,
              size: 40,
              color: Colors.white,
            )
          ],
          onTap: (index) {
            pageC.changePage(index);
          },
        ));
  }
}
