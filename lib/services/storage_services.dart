// ignore_for_file: depend_on_referenced_packages

import 'dart:io';
import 'package:path/path.dart';

import 'package:path_provider/path_provider.dart';

import 'package:permission_handler/permission_handler.dart';

Future<bool> requestPermission() async {
  final status = await Permission.storage.status;
  if (status != PermissionStatus.granted) {
    final result = await Permission.storage.request();
    return result == PermissionStatus.granted;
  }
  return true;
}

String parentFolderPath = "";
String videoFolderPath = "";
String audioFolderPath = "";

Future<void> createFolders() async {
  if (await requestPermission()) {
    if (Platform.isAndroid &&
        Platform.operatingSystemVersion.split(".")[0] == "10") {
      final Directory appDocDir = await getApplicationDocumentsDirectory();
      parentFolderPath = join(appDocDir.path, 'Video_Downloader_For_Tiktok');
      videoFolderPath = join(parentFolderPath, 'video');
      audioFolderPath = join(parentFolderPath, 'audio');

      Directory parentFolder = Directory(parentFolderPath);
      Directory videoFolder = Directory(videoFolderPath);
      Directory audioFolder = Directory(audioFolderPath);

      if (!await parentFolder.exists()) {
        await parentFolder.create();
      }
      if (!await videoFolder.exists()) {
        await videoFolder.create();
      }
      if (!await audioFolder.exists()) {
        await audioFolder.create();
      }
    } else {
      final Directory? appDocDir = await getExternalStorageDirectory();
      parentFolderPath = join(appDocDir!.path, 'Video_Downloader_For_Tiktok');
      videoFolderPath = join(parentFolderPath, 'video');
      audioFolderPath = join(parentFolderPath, 'audio');

      Directory parentFolder = Directory(parentFolderPath);
      Directory videoFolder = Directory(videoFolderPath);
      Directory audioFolder = Directory(audioFolderPath);

      if (!await parentFolder.exists()) {
        await parentFolder.create();
      }
      if (!await videoFolder.exists()) {
        await videoFolder.create();
      }
      if (!await audioFolder.exists()) {
        await audioFolder.create();
      }
    }
  }
}

Future<void> writeToVideoFolder(String fileName, List<int> fileBytes) async {
  File videoFile = File(join(videoFolderPath, fileName));
  await videoFile.writeAsBytes(fileBytes);
}

Future<void> writeToAudioFolder(String fileName, List<int> fileBytes) async {
  File audioFile = File(join(audioFolderPath, fileName));
  await audioFile.writeAsBytes(fileBytes);
}

Future<String> readFromVideoFolder(String fileName) async {
  File videoFile = File(join(videoFolderPath, fileName));
  String fileContent = await videoFile.readAsString();
  return fileContent;
}

Future<String> readFromAudioFolder(String fileName) async {
  File audioFile = File(join(audioFolderPath, fileName));
  String fileContent = await audioFile.readAsString();
  return fileContent;
}

Future<void> deleteFromVideoFolder(String fileName) async {
  File videoFile = File(join(videoFolderPath, fileName));
  await videoFile.delete();
}

Future<void> deleteFromAudioFolder(String fileName) async {
  File audioFile = File(join(audioFolderPath, fileName));
  await audioFile.delete();
}
