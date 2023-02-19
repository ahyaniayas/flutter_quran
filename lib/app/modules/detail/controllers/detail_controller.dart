import 'package:arabic_numbers/arabic_numbers.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:get/get.dart';
import '../../../data/models/detail_model.dart';
import '../../../data/providers/surat_provider.dart';

class DetailController extends GetxController {
  AudioPlayer audioPlayer = AudioPlayer();
  final suratProv = SuratProvider();

  RxInt nomor = 0.obs;
  RxString nomorArab = "".obs;
  RxString nama = "".obs;
  RxString arti = "".obs;
  RxString jumlahAyat = "".obs;
  RxString jumlahAyatArab = "".obs;

  bool isPlaying = false;
  RxString audio = "".obs;

  List popupButtonItem = ["Lihat Terjemah"];

  Future<Detail?> getSurat(int nomor) async {
    nomorArab.value = "";
    nama.value = "";
    arti.value = "";
    jumlahAyat.value = "";
    jumlahAyatArab.value = "";

    Detail? surat = await suratProv.getSurat(nomor);

    nomorArab.value = ArabicNumbers().convert(nomor);
    nama.value = surat.nama!;
    arti.value = surat.arti!;
    jumlahAyat.value = surat.jumlahAyat!.toString();
    jumlahAyatArab.value = ArabicNumbers().convert(jumlahAyat.value);
    if (audio.value != surat.audio) {
      await audioPlayer.stop();
      isPlaying = false;
    }
    audio.value = surat.audio!;
    update();

    return surat;
  }

  play(String newAudio) async {
    if (audio.value == newAudio && audioPlayer.state == PlayerState.playing) {
      await audioPlayer.stop();
      isPlaying = false;
    } else {
      if (audioPlayer.state == PlayerState.playing) await audioPlayer.stop();
      audio.value = newAudio;
      audioPlayer.play(UrlSource(audio.value));
      isPlaying = true;
    }
    update();
  }
}
