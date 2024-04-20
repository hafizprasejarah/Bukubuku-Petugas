import 'dart:io';

import 'package:bukubuku_petugas/app/modules/add_book/views/add_book_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:image_picker/image_picker.dart';



class BookImage extends StatefulWidget {
  final void Function(XFile?) onImageSelected;

  const BookImage({super.key, required this.onImageSelected,});

  @override
  State<BookImage> createState() => _BookImageState();
}

class _BookImageState extends State<BookImage> {

  XFile? _imageFile;
  final _picker = ImagePicker();

  Future<XFile?> getImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = XFile(pickedFile.path);
      });
      widget.onImageSelected(_imageFile);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 210,
            width: 150,
            decoration: BoxDecoration(
                // IMPPORTANTT!!!!
                image: _imageFile != null
                    ? DecorationImage(
                  image: FileImage(File(_imageFile!.path)),
                  fit: BoxFit.cover,
                )
                    : null,
                color: Colors.grey, border: Border.all(color: Colors.black45)),

          ),
        ],
      ),
      onTap: () {
        getImage();
      },
    );
  }
}


