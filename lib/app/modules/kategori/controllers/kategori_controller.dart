import 'package:bukubuku_petugas/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';

import '../../../data/constant/endpoint.dart';
import '../../../data/model/response_kategori.dart';
import '../../../data/provider/api_provider.dart';
import '../../../data/provider/storage_provider.dart';

class KategoriController extends GetxController with StateMixin<List<DataKategori>> {
  final count = 0.obs;

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

  Future<void> getData() async {
    try {
      change(null, status: RxStatus.loading());

      // Ambil token JWT dari penyimpanan lokal
      String? token = await StorageProvider.read(StorageKey.token);

      // Lakukan permintaan GET dengan header yang disertakan
      final response = await ApiProvider.instance().get(
        Endpoint.kategori,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      // Periksa apakah respons sukses (status code 200)
      if (response.statusCode == 200) {
        final ResponseKategori responseKategori = ResponseKategori.fromJson(response.data);

        // Set data kategori ke dalam state
        change(responseKategori.data, status: RxStatus.success());
      } else {
        // Tangani jika respons gagal
        // Misalnya, tampilkan pesan kesalahan kepada pengguna
        change(null, status: RxStatus.error('Failed to fetch data'));
      }
    } catch (e) {
      // Tangani kesalahan jika terjadi
      // Misalnya, tampilkan pesan kesalahan kepada pengguna
      change(null, status: RxStatus.error('An error occurred: $e'));
    }
  }

  Future<void> deleteData(int? id) async {
    try {
      final token = await StorageProvider.read(StorageKey.token);
      final response = await ApiProvider.instance().delete(
        '${Endpoint.kategori}/$id', // Endpoint untuk menghapus data dengan ID tertentu
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        // Jika penghapusan berhasil, perbarui status dan lakukan tindakan yang sesuai
        change(null, status: RxStatus.success());
        Get.back();
        // Contoh: Tampilkan pesan sukses atau lakukan tindakan lain seperti memuat ulang data
        print('Data dengan ID $id berhasil dihapus');
      } else {
        // Jika penghapusan gagal, tampilkan pesan kesalahan
        change(null, status: RxStatus.error('Failed to delete data'));
      }
    } catch (e) {
      // Jika terjadi kesalahan selama proses penghapusan, tampilkan pesan kesalahan
      change(null, status: RxStatus.error('An error occurred: $e'));
    }
  }


}
