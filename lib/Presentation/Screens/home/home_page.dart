// ignore_for_file: sized_box_for_whitespace, avoid_unnecessary_containers

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_link_previewer/flutter_link_previewer.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lecle_flutter_link_preview/lecle_flutter_link_preview.dart';
import 'package:line_icons/line_icons.dart';
import 'package:tiktok_downloader/Presentation/widgets/drawer_widget.dart';
import 'package:tiktok_downloader/services/storage_services.dart';
import 'package:tiktok_downloader/services/tiktok_data.api.dart';
import 'package:tiktok_downloader/services/titokdata.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoading = false;

  final _searchController = TextEditingController();
  final _containerHeight = 47.0;

  String url = '';

  _textStyle({required Color? color}) {
    return GoogleFonts.cormorant(
      fontSize: 17,
      fontWeight: FontWeight.w600,
      color: color,
    );
  }

  _appBarAction({required Widget child, required void Function()? ontap}) {
    return Ink(
      child: InkWell(
        onTap: ontap,
        child: Container(
          height: 56,
          width: MediaQuery.of(context).size.width / 9,
          child: Center(child: child),
        ),
      ),
    );
  }

  @override
  void initState() {
    requestPermission();
    createFolders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const MyDrawer(),
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "Video downloader for",
          style: GoogleFonts.cormorant(
            fontSize: 17,
            fontWeight: FontWeight.w600,
          ),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        actions: [
          _appBarAction(
            child: const Icon(
              LineIcons.questionCircle,
              size: 30,
            ),
            ontap: () {},
          ),
          _appBarAction(
            child: const Icon(
              LineIcons.download,
              size: 30,
            ),
            ontap: () {},
          ),
          _appBarAction(
            child: const Icon(
              LineIcons.crown,
              color: Colors.black,
            ),
            ontap: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 8, right: 15, left: 15),
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 50,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: Colors.black.withOpacity(0.9),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 10,
                    right: 10,
                  ),
                  child: TextFormField(
                    controller: _searchController,
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      enabled: true,
                    ),
                    cursorColor: Colors.black.withOpacity(0.89),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Ink(
                height: 47,
                padding: EdgeInsets.zero,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(15)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () async {
                        final _previewData =
                            requestData(_searchController.text.trim());
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width / 2.5,
                        height: _containerHeight,
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Center(
                          child: Text(
                            "Paste link",
                            style: _textStyle(color: null),
                          ),
                        ),
                      ),
                    ),
                    Ink(
                      child: InkWell(
                        onTap: () async {
                          try {
                            await createFolders();
                            setState(() {
                              _isLoading = true;
                            });
                            if (_isLoading) {
                              url = _searchController.text.trim();
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return StreamBuilder<Data>(
                                    stream: requestData(url),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasError) {
                                        return AlertDialog(
                                          content:
                                              Text(snapshot.error.toString()),
                                        );
                                      } else if (!snapshot.hasData) {
                                        return const Center(
                                            child: CircularProgressIndicator
                                                .adaptive(
                                          backgroundColor: Color(0xffFE2C55),
                                        ));
                                      }
                                      final data = snapshot.data!;
                                      return AlertDialog(
                                          content: Container(
                                        height: 400,
                                        child: Column(
                                          children: [
                                            Column(
                                              crossAxisAlignment: CrossAxisAlignment.stretch,
                                              children: [
                                                Container(
                                                  height: 300,
                                                  width: 300,

                                                    child: Image.network(
                                                      fit:BoxFit.contain,
                                                        data.originCover),
                                                  ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ));
                                    },
                                  );
                                },
                              );

                              requestData(url);
                            }
                          } on Exception catch (error) {
                            log(error.toString());
                          }
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2.5,
                          height: _containerHeight,
                          decoration: BoxDecoration(
                            color: const Color(0xffFE2C55),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Center(
                            child: Text(
                              "Download",
                              style: _textStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
