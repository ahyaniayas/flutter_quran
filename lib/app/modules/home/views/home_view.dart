import 'package:arabic_numbers/arabic_numbers.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/home_controller.dart';
import '../../detail/controllers/detail_controller.dart';
import '../../../routes/app_pages.dart';

class HomeView extends GetView<HomeController> {
  @override
  Widget build(BuildContext context) {
    DetailController detailCont = Get.find();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "الْقُرْآن الْكَرِيْم",
          style: TextStyle(
            fontFamily: "Hafs",
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: controller.getAllSurat(),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snap.data == null || snap.data!.length == 0) {
            return Center(
              child: Text("Terjadi Kesalahan"),
            );
          } else {
            return ListView.builder(
              itemCount: snap.data!.length,
              itemBuilder: (BuildContext context, int index) {
                var nomor = snap.data![index].nomor;
                var nomorArab = ArabicNumbers().convert(nomor);
                var nama = snap.data![index].nama;
                var audio = snap.data![index].audio;

                return ListTile(
                  leading: Text("$nomor"),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: () async {
                          detailCont.play(audio!);
                        },
                        icon: GetBuilder<DetailController>(
                          builder: (detailCont) => Icon((detailCont.isPlaying &&
                                  detailCont.audio.value == audio)
                              ? Icons.pause
                              : Icons.play_arrow),
                        ),
                      ),
                      Text(
                        "$nama",
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontFamily: "Hafs",
                          fontSize: 24,
                        ),
                      ),
                    ],
                  ),
                  trailing: Text(
                    nomorArab,
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                  tileColor:
                      index % 2 == 0 ? Color(0xFFFFE6DF) : Color(0xFFFFEBE5),
                  onTap: () {
                    detailCont.nomor.value = nomor!;
                    Get.toNamed(Routes.DETAIL);
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
