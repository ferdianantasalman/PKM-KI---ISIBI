import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:isibi/app/modules/news/controllers/news_controller.dart';
import 'package:isibi/app/shared/page_index_controller.dart';
import 'package:get_storage/get_storage.dart';

import 'app/routes/app_pages.dart';

void main() async {
  await GetStorage.init();
  Get.put(PageIndexController(), permanent: true);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Application",
      debugShowCheckedModeBanner: false,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    );
  }
}
