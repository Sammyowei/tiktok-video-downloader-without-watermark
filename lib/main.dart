// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tiktok_downloader/Presentation/Screens/Main-Activity/main_activity.dart';
import 'package:tiktok_downloader/services/storage_services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await createFolders();

  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.white));
  runApp(MainActivity());
}
