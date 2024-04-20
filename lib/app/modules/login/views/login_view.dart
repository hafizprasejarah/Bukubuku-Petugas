import 'package:bukubuku_petugas/app/modules/add_book/views/Imagepicker/inputDecoration.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../routes/app_pages.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SafeArea(
          child: Center(
              child: Form(
                  key: controller.formkey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        controller: controller.usernameController,
                        decoration: AppDecorations.textFormFieldDecoration.copyWith(
                          hintText: 'Masukan username',
                        ),
                        validator: (value) {
                          if (value!.length < 2) {
                            return 'Masukan Username';
                          }
                          return null;
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TogglePassword(controller: controller.passwordController),
                      SizedBox(height: 10,),
                      Obx(() => controller.loading.value
                          ? CircularProgressIndicator()
                          : ElevatedButton(
                          onPressed: () {
                            controller.login();
                          },
                          child: Text('Login'))),
                      SizedBox(height: 10,),
                    ],
                  ))),
        ),
      ),
    );
  }
}


class TogglePassword extends StatefulWidget {
  final TextEditingController controller;
  const TogglePassword({super.key, required this.controller});

  @override
  State<TogglePassword> createState() => _TogglePasswordState();
}

class _TogglePasswordState extends State<TogglePassword> {

  bool isSecurePassword = true;
  @override

  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isSecurePassword,
      controller: widget.controller,
      decoration: AppDecorations.textFormFieldDecoration.copyWith(
        suffixIcon:togglePassword(),
        hintText: 'Masukan Password',
      ),
      validator: (value) {
        if (value!.length < 2) {
          return 'Masukan password';
        }
        return null;
      },
    );
  }
  Widget togglePassword() {
    return IconButton(
      onPressed: () {
        setState(() {
          isSecurePassword = !isSecurePassword;
        });
      },
      icon: isSecurePassword
          ? const Icon(Icons.visibility)
          : const Icon(Icons.visibility_off),
      color: Colors.grey,
    );
  }
}
