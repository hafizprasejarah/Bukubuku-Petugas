import 'package:bukubuku_petugas/app/modules/add_book/controllers/add_book_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DropDown extends StatefulWidget {
  const DropDown({Key? key}) : super(key: key);

  @override
  State<DropDown> createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {

  final AddBookController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: DropdownButton(
          isExpanded: true,
          items: controller.dataKategori.map((e) {
            return DropdownMenuItem(
              child: Text("${e.nama}"),
              value: e.id,
            );
          }).toList(),
          value: controller.selectedCategoryId.value,
          onChanged: (value) {
            setState(() {
              controller.selectedCategoryId.value = value as int;
            });
          },
        ),
      );
    },);
  }
}
