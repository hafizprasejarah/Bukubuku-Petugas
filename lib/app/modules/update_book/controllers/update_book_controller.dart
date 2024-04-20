
import 'package:bukubuku_petugas/app/data/model/response_singleBook.dart';
import 'package:bukubuku_petugas/app/routes/app_pages.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:dio/dio.dart' as dio;
import '../../../data/constant/endpoint.dart';
import '../../../data/model/response_kategori.dart';
import '../../../data/provider/api_provider.dart';
import '../../../data/provider/storage_provider.dart';

class UpdateBookController extends GetxController {
  // update book form
  final GlobalKey<FormState> formkey3 = GlobalKey<FormState>();
  final TextEditingController judulController = TextEditingController();
  final TextEditingController penulisController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController penerbitController = TextEditingController();
  final TextEditingController tahun_terbitController = TextEditingController();
  final loading = false.obs;
  final count = 0.obs;
  //Get book
  Rx<DataSingleBook?> books = Rx<DataSingleBook?>(null);

  //Get kategori
  final Rx<Status> status = Rx<Status>(Status.loading);
  final RxList<DataKategori> dataKategori = <DataKategori>[].obs;
  final RxString errorMessage = ''.obs;
  RxInt selectedCategoryId = 1.obs;
  // final count = 0.obs;


  final Rx<XFile?> selectedImage = Rx<XFile?>(null);
  @override
  void onInit() {
    super.onInit();
    getKategori();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
  // Future<void> getData(int? idbook) async {
  //   try {
  //     // Ambil token JWT dari penyimpanan lokal
  //     String? token = await StorageProvider.read(StorageKey.token);
  //
  //     // Lakukan permintaan GET dengan header yang disertakan
  //     final response = await ApiProvider.instance().get(
  //       '${Endpoint.book}/$idbook',
  //     );
  //
  //     // Periksa apakah respons sukses (status code 200)
  //     if (response.statusCode == 200) {
  //       final ResponseSingleBook responseBook = ResponseSingleBook.fromJson(response.data);
  //       if (responseBook.data != null) {
  //         books!.value = responseBook.data!;
  //       } else {
  //         Get.snackbar('Error', 'Response data is null',
  //             backgroundColor: Colors.red);
  //       }
  //     } else {
  //       // Tangani jika permintaan tidak berhasil
  //       // Misalnya, tampilkan pesan kesalahan kepada pengguna
  //       Get.snackbar('Error', 'Failed to fetch user data',
  //           backgroundColor: Colors.red);
  //     }
  //   } catch (e) {
  //     // Tangani kesalahan jika terjadi
  //     // Misalnya, tampilkan pesan kesalahan kepada pengguna
  //     Get.snackbar('Error', 'An error occurred: $e',
  //         backgroundColor: Colors.red);
  //   }
  // }


  Future<void> updateData(XFile? imageFile,String? selected,int? idbook) async {
    try {
      String? token = await StorageProvider.read(StorageKey.token);


      Map<String, dynamic> userData = {
        'kategori_id':  selected,
        'judul': judulController.text,
        'penulis': penulisController.text,
        'description': descriptionController.text,
        'penerbit': penerbitController.text,
        'tahun_terbit' : tahun_terbitController.text,
        if(imageFile != null)'image': await dio.MultipartFile.fromFile(imageFile.path, filename: 'image.png'),
      };

      final response = await ApiProvider.instance().post(
        '${Endpoint.book}/$idbook',
        data: dio.FormData.fromMap(userData),
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        Get.snackbar('Success', 'User data updated successfully',
            backgroundColor: Colors.green);
        Get.offAllNamed(Routes.BOOK_LIST);
      } else {
        Get.snackbar('Error', 'Failed to update user data',
            backgroundColor: Colors.red);
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e',
          backgroundColor: Colors.red);
    }
  }

  Future<void> getKategori() async {
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
