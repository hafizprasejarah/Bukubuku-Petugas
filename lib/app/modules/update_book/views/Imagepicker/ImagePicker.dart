import 'dart:io';


import 'package:bukubuku_petugas/app/modules/update_book/views/update_book_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:image_picker/image_picker.dart';

import '../../../../data/constant/endpoint.dart';


class BookImage extends StatefulWidget {
  final bookData;
  final void Function(XFile?) onImageSelected;
  const BookImage({super.key, this.bookData, required this.onImageSelected,});

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

      widget.onImageSelected(_imageFile,);
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

              image: _imageFile == null
                  ? DecorationImage(
                image: NetworkImage('${Endpoint.Url}${widget.bookData.image}'),

                fit: BoxFit.fill,
              )
                  : DecorationImage(
                image: FileImage(File(_imageFile!.path)),
                fit: BoxFit.fill,
              ),
              color: Colors.grey,
              border: Border.all(color: Colors.black45),
            ),

          ),
        ],
      ),
      onTap: () {
        getImage();
      },
    );
  }
}
