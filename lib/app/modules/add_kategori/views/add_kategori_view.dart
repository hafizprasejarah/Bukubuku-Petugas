import 'package:bukubuku_petugas/app/modules/add_book/views/Imagepicker/inputDecoration.dart';
import 'package:bukubuku_petugas/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../routes/app_colors.dart';
import '../controllers/add_kategori_controller.dart';

class AddKategoriView extends GetView<AddKategoriController> {
  const AddKategoriView({Key? key}) : super(key: key);
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
            Get.offAllNamed(Routes.HOME);
          },
        ),
      ),
      body:Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Form(
              key: controller.formkey,
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: controller.namaController,
                    decoration: AppDecorations.textFormFieldDecoration.copyWith(
                      labelText: 'Kategori',
                      hintText: 'Masukkan Kategori',
                      prefixIcon: const Icon(Icons.category),
                    ),
                    validator: (value) {
                      if (value!.length < 2) {
                        return 'Masukan Kategori';
                      }
                      return null;
                    },
                  ),



                  SizedBox(height: 10,),
                  Obx(() => controller.loading.value
                      ? CircularProgressIndicator()
                      : ElevatedButton(
                    onPressed: () {
                      controller.addkategori();
                    },
                    style: ElevatedButton.styleFrom(
                      primary: BgColor, // warna latar belakang tombol
                      onPrimary: Colors.white, // warna teks tombol
                      elevation: 5, // efek bayangan
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10), // padding tombol
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), // bentuk tombol
                    ),
                    child: Text(
                      'Tambah',
                    ),
                  )),
                  SizedBox(height: 10,),
                  TextButton(onPressed: () {
                    Get.toNamed(Routes.KATEGORI);
                  }, child: Text("List Kategori"))
                ],
              )),
        ),
      ),
    );
  }
}
