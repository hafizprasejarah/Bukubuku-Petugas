import 'package:bukubuku_petugas/app/data/model/response_user.dart';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../../data/constant/endpoint.dart';
import '../../../data/provider/api_provider.dart';
import '../../../data/provider/storage_provider.dart';

class UserController extends GetxController {
  Rx<DataUser?> user = Rx<DataUser?>(null);
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final TextEditingController namaController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController telpController = TextEditingController();
  final TextEditingController alamatController = TextEditingController();
  final Rx<XFile?> selectedImage = Rx<XFile?>(null);
  final count = 0.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    getData();
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future<void> getData() async {
    try {
      // Ambil token JWT dari penyimpanan lokal
      String? token = await StorageProvider.read(StorageKey.token);

      // Lakukan permintaan GET dengan header yang disertakan
      final response = await ApiProvider.instance().get(
        Endpoint.user,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      // Periksa apakah respons sukses (status code 200)
      if (response.statusCode == 200) {
        final ResponseUser responseUser = ResponseUser.fromJson(response.data);
        if (responseUser.data != null) {
          user.value = responseUser.data!;
        } else {
          Get.snackbar('Error', 'Response data is null',
              backgroundColor: Colors.red);
        }
      } else {
        // Tangani jika permintaan tidak berhasil
        // Misalnya, tampilkan pesan kesalahan kepada pengguna
        Get.snackbar('Error', 'Failed to fetch user data',
            backgroundColor: Colors.red);
      }
    } catch (e) {
      // Tangani kesalahan jika terjadi
      // Misalnya, tampilkan pesan kesalahan kepada pengguna
      Get.snackbar('Error', 'An error occurred: $e',
          backgroundColor: Colors.red);
    }
  }


  Future<void> updateData(XFile? imageFile) async {
    try {
      String? token = await StorageProvider.read(StorageKey.token);
      String? idUser = await StorageProvider.read(StorageKey.idUser);

      Map<String, dynamic> userData = {
        'nama': namaController.text,
        'telp': telpController.text,
        'alamat': alamatController.text,
        if(imageFile != null)'image': await dio.MultipartFile.fromFile(imageFile.path, filename: 'image.png'),
      };

      final response = await ApiProvider.instance().post(
        '${Endpoint.user}/$idUser',
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
      } else {
        Get.snackbar('Error', 'Failed to update user data',
            backgroundColor: Colors.red);
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e',
          backgroundColor: Colors.red);
    }
  }




}
