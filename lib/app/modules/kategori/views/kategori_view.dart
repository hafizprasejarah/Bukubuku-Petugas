import 'package:bukubuku_petugas/app/data/model/response_kategori.dart';
import 'package:bukubuku_petugas/app/routes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/kategori_controller.dart';

class KategoriView extends GetView<KategoriController> {
  const KategoriView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: BgColor,
        title: const Text('Tambah Kategori',style: TextStyle(
            color: Colors.white,
            fontSize: 24
        ),),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: controller.obx(
            (state) {
          if (state == null) {
            // Jika state null, tampilkan widget loading atau pesan kosong
            return const Center(child: CircularProgressIndicator());
          } else {
            // Jika state tidak null, tampilkan data
            return ListView.separated(
              padding: const EdgeInsets.all(16), // Tambahkan padding pada ListView
              itemCount: state.length,
              itemBuilder: (context, index) {
                DataKategori dataKategori = state[index];
                return Card(
                  color: Colors.white,
                  elevation: 3, // Tambahkan efek bayangan untuk card
                  child: ListTile(
                    leading: const Icon(Icons.category, color: BgColor),
                    title: Text(
                      "Kategori: ${dataKategori.nama}",
                      style: TextStyle(fontWeight: FontWeight.bold),
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(
                      "Dibuat pada: ${dataKategori.createdAt}",
                      style: TextStyle(color: Colors.grey),
                    ),
                    trailing: (index == state.length - 1) // Memeriksa jika indeks adalah item terakhir
                        ? null // Tidak menampilkan tombol hapus untuk item terakhir
                        : IconButton(
                      onPressed: () {
                        if (dataKategori.id != null) {
                          controller.deleteData(dataKategori.id!.toInt());
                        }
                      },
                      icon: const Icon(Icons.delete),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => const SizedBox(height: 8), // Tambahkan spasi antara item
            );
          }
        },
        onLoading: const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

