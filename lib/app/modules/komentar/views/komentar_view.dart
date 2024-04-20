import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/komentar_controller.dart';

class KomentarView extends GetView<KomentarController> {
  const KomentarView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('KomentarView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'KomentarView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
