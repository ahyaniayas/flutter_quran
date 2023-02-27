import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'app/routes/app_pages.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  runApp(
    GetMaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        scaffoldBackgroundColor: Color(0xFFFFF1ED),
      ),
      debugShowCheckedModeBanner: false,
      title: "Quran",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
    ),
  );
  FlutterNativeSplash.remove();
}
