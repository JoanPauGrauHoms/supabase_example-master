// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_example/app/controllers/auth_controller.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  String supaUri = 'https://dqjtohijxxvurtoczvpm.supabase.co'; //get env key
  String supaAnon = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImRxanRvaGlqeHh2dXJ0b2N6dnBtIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDQ5MDU4MzksImV4cCI6MjAyMDQ4MTgzOX0.zTUE7S0lY1Z3LDp2pqoUjICruwwyHnf78BhnvzsMp-w';

  Supabase supaProvider = await Supabase.initialize(
    url: supaUri,
    anonKey: supaAnon,
  );

  final authC = Get.put(AuthController(), permanent: true);
  runApp(
    GetMaterialApp(
      title: "Application",
      initialRoute: supaProvider.client.auth.currentUser == null
          ? Routes.LOGIN
          : Routes.HOME, //cek login current user
      getPages: AppPages.routes,
      debugShowCheckedModeBanner: false,
    ),
  );
}
