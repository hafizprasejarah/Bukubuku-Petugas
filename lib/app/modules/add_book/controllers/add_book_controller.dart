import 'package:bukubuku_petugas/app/routes/app_pages.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../data/constant/endpoint.dart';
import '../../../data/model/response_kategori.dart';
import '../../../data/provider/api_provider.dart';
import '../../../data/provider/storage_provider.dart';

class AddBookController extends GetxController {
  final GlobalKey<FormState> formkey1 = GlobalKey<FormState>();
  final TextEditingController judulController = TextEditingController();
  final TextEditingController penulisController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController penerbitController = TextEditingController();
  final TextEditingController tahun_terbitController = TextEditingController();
  final loading = false.obs;
  final count = 0.obs;

  final Rx<Status> status = Rx<Status>(Status.loading);
  final RxList<DataKategori> dataKategori = <DataKategori>[].obs;
  final RxString errorMessage = ''.obs;
  RxInt selectedCategoryId = 1.obs;


  final Rx<XFile?> selectedImage = Rx<XFile?>(null);


  @override
  void onInit() {
    super.onInit();
    getData();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }


  addbook(XFile? imageFile, String? selected) async {
    loading(true);
    try {

      Map<String, dynamic> userData = {
        'kategori_id':  selected,
        'judul': judulController.text,
        'penulis': penulisController.text,
        'description': descriptionController.text,
        'penerbit': penerbitController.text,
        'tahun_terbit' : int.parse(tahun_terbitController.text),
        if(imageFile != null)'image': await dio.MultipartFile.fromFile(imageFile.path, filename: 'image.png'),
      };



      FocusScope.of(Get.context!).unfocus();
      formkey1.currentState?.save();
      if (formkey1.currentState!.validate()) {
        final response = await ApiProvider.instance().post(Endpoint.addbook,
            data: dio.FormData.fromMap(userData));

        if (response.statusCode == 201) {
          Get.offAllNamed(Routes.HOME);
          Get.snackbar("Berhasil", "Sukses menambahkan buku", backgroundColor: Colors.orange);
        } else {
          Get.snackbar("Sorry", "Gagal", backgroundColor: Colors.orange);
        }
      }
      loading(false);
    } on dio.DioException catch (e) {
      loading(false);
      if (e.response != null) {
        if (e.response?.data != null)
          Get.snackbar("sorry", "${e.response?.data['message']}",
              backgroundColor: Colors.orange);
      } else {
        Get.snackbar("sorry", e.message ?? "", backgroundColor: Colors.red);
      }
    } catch (e) {
      loading(false);
      Get.snackbar("error", e.toString(), backgroundColor: Colors.red);
    }
  }

  Future<void> getData() async {
    try {
      final token = await StorageProvider.read(StorageKey.token);
      final response = await ApiProvider.instance().get(
        Endpoint.kategori,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        final ResponseKategori responseKategori = ResponseKategori.fromJson(response.data);
        dataKategori.assignAll(responseKategori.data??[]);
        status.value = Status.success;
      } else {
        errorMessage.value = 'Failed to fetch data';
        status.value = Status.error;
      }
    } catch (e) {
      errorMessage.value = 'An error occurred: $e';
      status.value = Status.error;
    }
  }


}

enum Status {
  loading,
  success,
  error,
}