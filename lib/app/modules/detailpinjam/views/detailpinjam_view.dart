import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:get/get.dart';

import '../../../data/constant/endpoint.dart';
import '../../../routes/app_colors.dart';
import '../controllers/detailpinjam_controller.dart';

class DetailpinjamView extends GetView<DetailpinjamController> {
  const DetailpinjamView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: BgColor,
        title: const Text(
          'Generate Laporan',
          style: TextStyle(color: Colors.white, fontSize: 24),
        ),
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [


              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "ID Peminjaman : " + Get.arguments.id.toString(),
                    style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.w500,
                        fontSize: 16),
                  ), Text(
                    "judul : " + Get.arguments.book.judul,
                    style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.w500,
                        fontSize: 16),
                  ),
                  Text(
                    "Penulis : " + Get.arguments.book.penulis,
                    style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.w500,
                        fontSize: 16),
                  ),
                  Text(
                    "Penerbit : " + Get.arguments.book.penerbit,
                    style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.w500,
                        fontSize: 16),
                  ),Text(
                    "Tahun Terbit : " + Get.arguments.book.tahunTerbit.toString(),
                    style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.w500,
                        fontSize: 16),
                  ),Text(
                    "Dipinjam : " + Get.arguments.tanggalPinjam,
                    style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.w500,
                        fontSize: 16),
                  ),Text(
                    "Dikembalikan : " + Get.arguments.tanggalKembali,
                    style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.w500,
                        fontSize: 16),
                  ),
        
                  Text(
                    'Sampul Buku :',
                    style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.w500,
                        fontSize: 16),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    height: 110,
                    width: 110,
                    child: Image.network(
                        '${Endpoint.Url}${Get.arguments.book.image}'),
                  ),
        
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Peminjam : ' + Get.arguments.user.nama,
                    style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.w500,
                        fontSize: 16),
                  ),
                  Text(
                    'Email : ' + Get.arguments.user.email,
                    style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.w500,
                        fontSize: 16),
                  ),
                  Text(
                    'Telp : ' + Get.arguments.user.telp,
                    style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.w500,
                        fontSize: 16),
                  ),
                  Text(
                    'Alamat :' + Get.arguments.user.alamat,
                    style: TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontWeight: FontWeight.w500,
                        fontSize: 16),
                  ),
                ],
              ),
              Row(
                children: [
                  Text('status :', style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      fontWeight: FontWeight.w500,
                      fontSize: 16),),
                  SizedBox(width: 20,),
                  DropDown(),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [

                  InkWell(
                    onTap: () => controller.updateData(Get.arguments.id),
                    child: Container(
                      height: 35,
                      decoration: BoxDecoration(
                          color: BgColor,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                            )
                          ]),
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Update Status",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(width: 10,),
      InkWell(
        onTap: () async {
          try {
            // Call the main function and handle errors
            await controller.generatePdf(Get.arguments.user.nama);
            // Show success message
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('PDF generated successfully!')),
            );
          } catch (e) {
            // Handle exceptions and show error message
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Failed to generate PDF: $e')),
            );
          }
        },
        child: Container(
          height: 35,
          decoration: BoxDecoration(
            color: Colors.blue, // BgColor to Colors.blue for consistency
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Generate",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DropDown extends StatefulWidget {
  const DropDown({Key? key}) : super(key: key);

  @override
  State<DropDown> createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  List<String> categories = ['Diproses', 'Dipinjam', 'kembali'];
  int selectedindex = 0;

  final DetailpinjamController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: DropdownButton(
        value: categories[selectedindex],
        items: categories.map((e) {
          return DropdownMenuItem(
            value: e,
            child: Text(e),
          );
        }).toList(),
        onChanged: (value) {
          setState(() {
            controller.Statusvalue = value!;
            print(controller.Statusvalue);
            selectedindex = categories.indexOf(value);
          });
        },
      ),
    );
  }
}
