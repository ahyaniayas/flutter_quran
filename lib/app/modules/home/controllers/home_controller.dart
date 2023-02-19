import 'package:get/get.dart';

import '../../../data/models/surat_model.dart';
import '../../../data/providers/surat_provider.dart';

class HomeController extends GetxController {
  final suratProv = SuratProvider();

  Future<List<Surat>> getAllSurat() async {
    return await suratProv.getAllSurat();
  }
}
