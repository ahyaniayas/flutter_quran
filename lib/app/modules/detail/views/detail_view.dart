import 'package:arabic_numbers/arabic_numbers.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/detail_controller.dart';

class DetailView extends GetView<DetailController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('${controller.jumlahAyatArab}'),
              Column(
                children: [
                  Text(
                    '${controller.nama}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${controller.arti}',
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
              Text('${controller.nomorArab}'),
              IconButton(
                onPressed: () async {
                  controller.play(controller.audio.value);
                },
                icon: GetBuilder<DetailController>(
                  builder: (controller) => Icon(
                      (controller.isPlaying) ? Icons.pause : Icons.play_arrow),
                ),
              ),
            ],
          ),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: controller.getSurat(controller.nomor.value),
        builder: (context, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snap.data == null) {
            return Center(
              child: Text("Terjadi Kesalahan"),
            );
          } else {
            return ListView.builder(
              itemCount: snap.data!.ayat!.length,
              itemBuilder: (BuildContext context, int index) {
                var ayat = snap.data!.ayat![index].nomor;
                var ayatArab = ArabicNumbers().convert(ayat);
                var ar = snap.data!.ayat![index].ar;
                // var id = snap.data!.ayat![index].id;
                // var tId = snap.data!.ayat![index].idn;

                return ListTile(
                  leading: Text("$ayat"),
                  title: Text(
                    "$ar",
                    textDirection: TextDirection.rtl,
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                      fontFamily: "Hafs",
                      fontSize: 24,
                    ),
                  ),
                  trailing: Text(
                    ayatArab,
                    style: TextStyle(
                      fontSize: 24,
                    ),
                  ),
                  tileColor:
                      index % 2 == 0 ? Color(0xFFFFE6DF) : Color(0xFFFFEBE5),
                );
              },
            );
          }
        },
      ),
    );
  }
}
