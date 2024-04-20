import 'dart:io';

import 'package:bukubuku_petugas/app/data/model/response_pinjam.dart';
import 'package:flutter/services.dart';
import 'package:open_document/open_document.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:printing/printing.dart';

import '../../../data/constant/endpoint.dart';
import '../../../data/provider/api_provider.dart';
import '../../../data/provider/storage_provider.dart';

class DetailpinjamController extends GetxController {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  String Statusvalue = '';
  RxInt selectedCategoryId = 1.obs;
  final RxList<DataPinjam> dataPinjam = <DataPinjam>[].obs;
  final count = 0.obs;
  final Rx<Status> status = Rx<Status>(Status.loading);
  final RxString errorMessage = ''.obs;

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

  Future<void> updateData(int? id) async {
    try {
      Map<String, dynamic> userData = {
        'status': Statusvalue,
      };

      final response = await ApiProvider.instance().post(
        '${Endpoint.pinjam}/$id',
        data: dio.FormData.fromMap(userData),
      );

      if (response.statusCode == 201) {
        Get.snackbar('Success', 'User data updated successfully',
            backgroundColor: Colors.green);
      } else {
        Get.snackbar('Error', 'Failed to update user data',
            backgroundColor: Colors.red);
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e',
          backgroundColor: Colors.red);
    }
  }

  Future<void> getData() async {
    try {
      final response = await ApiProvider.instance().get(
        Endpoint.pinjam,
      );

      if (response.statusCode == 200) {
        final ResponsePinjam responseKategori =
            ResponsePinjam.fromJson(response.data);
        dataPinjam.assignAll(responseKategori.data ?? []);
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

  Future<void> generatePdf(String? filename) async {
    final pdf = pw.Document();
    final netImage = await networkImage('${Endpoint.Url}${Get.arguments.book.image}');
    final font = pw.Font.ttf(await rootBundle.load("assets/fonts/Roboto-Regular.ttf"));
    // Tambahkan halaman dengan teks "Hello World!"
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) => pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  "ID Peminjaman: ${Get.arguments.id}",
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 24,
                    lineSpacing: 2
                  ),
                ),
                pw.Text(
                  "Judul: ${Get.arguments.book.judul}ddddddddddddddddddddddddddddddddddddddddddddddddddddddddd",
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                      fontSize: 24,
                      lineSpacing: 2
                  ), // Batas jumlah baris
                ),
                pw.Text(
                  "Penulis: ${Get.arguments.book.penulis}",
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                      fontSize: 24,
                      lineSpacing: 2
                  ),
                  maxLines: 1,
                ),
                pw.Text(
                  "Penerbit: ${Get.arguments.book.penerbit}",
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                      fontSize: 24,
                      lineSpacing: 2
                  ),
                  maxLines: 1,
                ),
                pw.Text(
                  "Tahun Terbit: ${Get.arguments.book.tahunTerbit}",
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                      fontSize: 24,
                      lineSpacing: 2
                  ),
                  maxLines: 1,
                ),
                pw.Text(
                  "Dipinjam: ${Get.arguments.tanggalPinjam}",
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                      fontSize: 24,
                      lineSpacing: 2
                  ),
                  maxLines: 1,
                ),
                pw.Text(
                  "Dikembalikan: ${Get.arguments.tanggalKembali}",
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                      fontSize: 24,
                      lineSpacing: 2
                  ),
                  maxLines: 1,
                ),
                pw.SizedBox(height: 10),
                pw.Text(
                  "Sampul Buku:",
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                      fontSize: 24,
                      lineSpacing: 2
                  ),
                ),
                pw.SizedBox(height: 10),
                pw.Container(
                  alignment: pw.Alignment.centerLeft,
                  height: 220,
                  width: 220,
                  child: pw.Image(netImage)
                  ),
              ],
            ),
            pw.SizedBox(height: 20),
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text(
                  "Peminjam: ${Get.arguments.user.nama}",
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                      fontSize: 24,
                      lineSpacing: 2
                  ),
                  maxLines: 1,
                ),
                pw.Text(
                  "Email: ${Get.arguments.user.email}",
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                      fontSize: 24,
                      lineSpacing: 2
                  ),
                  maxLines: 1,
                ),
                pw.Text(
                  "Telp: ${Get.arguments.user.telp}",
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                      fontSize: 24,
                      lineSpacing: 2
                  ),
                  maxLines: 1,
                ),
                pw.Text(
                  "Alamat: ${Get.arguments.user.alamat}",
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                      fontSize: 24,
                      lineSpacing: 2
                  ),
                  maxLines: 1,
                ),
              ],
            ),
          ],
        ),
      ),
    );

    // Dapatkan direktori dokumen aplikasi
    final output = await getTemporaryDirectory();

    // Tentukan jalur file untuk file PDF
    final filePath = '${output.path}/$filename.pdf';

    // Buat file baru di jalur yang ditentukan
    final file = File(filePath);

    // Simpan dokumen PDF ke dalam file
    await file.writeAsBytes(await pdf.save());
    await OpenDocument.openDocument(filePath: filePath);

  }
}

enum Status {
  loading,
  success,
  error,
}
