import 'package:bukubuku_petugas/app/routes/app_pages.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/constant/endpoint.dart';
import '../../../data/provider/api_provider.dart';
import '../../../data/provider/storage_provider.dart';

class BookDetailController extends GetxController {
  //TODO: Implement BookDetailController

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> deleteData(int? id) async {
    try {
      final token = await StorageProvider.read(StorageKey.token);
      final response = await ApiProvider.instance().delete(
        '${Endpoint.book}/$id', // Endpoint untuk menghapus data dengan ID tertentu
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        // Jika penghapusan berhasil, tampilkan snackbar sukses
        Get.snackbar(
          'Success',
          'Buku berhasil dihapus',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
        Get.offAllNamed(Routes.BOOK_LIST);
      } else {
        // Jika penghapusan gagal, tampilkan snackbar error
        Get.snackbar(
          'Error',
          'Failed to delete data',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      // Jika terjadi kesalahan selama proses penghapusan, tampilkan snackbar error dengan pesan kesalahan
      Get.snackbar(
        'Error',
        'An error occurred: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}
