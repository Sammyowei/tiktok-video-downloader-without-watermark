import 'package:flutter/material.dart';
import 'package:tiktok_downloader/Presentation/Screens/home/home_page.dart';
import 'package:tiktok_downloader/services/storage_services.dart';

class MainActivity extends StatelessWidget {
  const MainActivity({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsFlutterBinding.ensureInitialized();
    createFolders();
    return MaterialApp(
      title: 'Video Downloader For tiktok',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      home: const HomePage(),
    );
  }
}
