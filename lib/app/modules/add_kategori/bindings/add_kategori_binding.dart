import 'package:get/get.dart';

import '../controllers/add_kategori_controller.dart';

class AddKategoriBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddKategoriController>(
      () => AddKategoriController(),
    );
  }
}
