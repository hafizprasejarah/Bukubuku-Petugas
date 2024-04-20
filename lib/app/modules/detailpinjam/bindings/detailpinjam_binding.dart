import 'package:get/get.dart';

import '../controllers/detailpinjam_controller.dart';

class DetailpinjamBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailpinjamController>(
      () => DetailpinjamController(),
    );
  }
}
