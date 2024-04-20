import 'package:bukubuku_petugas/app/modules/add_book/views/Imagepicker/inputDecoration.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../routes/app_colors.dart';
import '../../../routes/app_pages.dart';
import '../controllers/add_book_controller.dart';
import 'Imagepicker/ImagePicker.dart';
import 'Materials/Dropdown.dart';

class AddBookView extends GetView<AddBookController> {
  const AddBookView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: BgColor,
        title: const Text(
          'Tambah Buku',
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
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
      body: Obx(() {
        final int selected = controller.selectedCategoryId.value;

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 20),
            child: Form(
              key: controller.formkey1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: BookImage(
                            onImageSelected: (pickedFile) {
                              controller.selectedImage.value = pickedFile;
                            },
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: DropDown(),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    controller: controller.judulController,
                    decoration: AppDecorations.textFormFieldDecoration.copyWith(
                      labelText: 'Judul',
                      hintText: 'Masukkan Judul',
                      prefixIcon: const Icon(Icons.title),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Masukan Data';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  TextField(
                    controller: controller.descriptionController,
                    maxLines: null,
                    decoration: AppDecorations.textFormFieldDecoration.copyWith(
                      labelText: 'Deskripsi',
                      hintText: 'Deskripsi Buku...',
                      prefixIcon: const Icon(Icons.description),
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: controller.penulisController,
                    decoration: AppDecorations.textFormFieldDecoration.copyWith(
                      labelText: 'Penulis',
                      hintText: 'Masukkan Penulis',
                      prefixIcon: const Icon(Icons.person),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Masukan Data';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: controller.penerbitController,
                    decoration: AppDecorations.textFormFieldDecoration.copyWith(
                      labelText: 'Penerbit',
                      hintText: 'Masukkan Penerbit',
                      prefixIcon: const Icon(Icons.publish),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Masukan Data';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 10),

                  Datepicker(
                    controller: controller.tahun_terbitController,
                  ),

                  SizedBox(height: 10),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        XFile? selectedimage = controller.selectedImage.value;
                        controller.addbook(selectedimage, selected.toString());
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
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}


class Datepicker extends StatefulWidget {
  final TextEditingController controller;
  const Datepicker({super.key, required this.controller});

  @override
  State<Datepicker> createState() => _DatepickerState();
}

class _DatepickerState extends State<Datepicker> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      readOnly: true,
      decoration: AppDecorations.textFormFieldDecoration.copyWith(
        labelText: 'Tahun Terbit',
        hintText: 'Tahun Terbit',
        prefixIcon: const Icon(Icons.date_range_rounded),
      ),
      onTap: () async {
        final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(1000),
          lastDate: DateTime(2040),
        );
        if (picked != null) {
          setState(() {
            widget.controller.text = picked.year.toString();
          });
        }
      },
      validator: (value) {
        if (value!.isEmpty) {
          return 'Masukan Tahun Terbit';
        }
        return null;
      },
    );
  }
}
