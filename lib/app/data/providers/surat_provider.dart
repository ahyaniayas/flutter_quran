import 'package:get/get.dart';

import '../models/surat_model.dart';
import '../models/detail_model.dart';
import '../../constant/env.dart';

class SuratProvider extends GetConnect {
  Future<List<Surat>> getAllSurat() async {
    final response = await get('$apiBaseUrl/surat');
    return Surat.fromJsonList(response.body);
  }

  Future<Detail> getSurat(int nomor) async {
    final response = await get('$apiBaseUrl/surat/$nomor');
    return Detail.fromJson(response.body);
  }
}
