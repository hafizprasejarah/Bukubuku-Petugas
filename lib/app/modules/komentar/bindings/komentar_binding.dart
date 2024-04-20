import 'package:get/get.dart';

import '../controllers/komentar_controller.dart';

class KomentarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<KomentarController>(
      () => KomentarController(),
    );
  }
}
