import 'package:bukubuku_petugas/app/routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../data/constant/endpoint.dart';
import '../../../routes/app_colors.dart';
import '../controllers/book_detail_controller.dart';

class BookDetailView extends GetView<BookDetailController> {
  const BookDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: BgColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: () => Get.back(),
        ),
        actions: <Widget>[
          IconButton(
              onPressed: () {
                controller.deleteData(Get.arguments.id);
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.white,
              )),
          const SizedBox(
            width: DefaultPadding / 2,
          )
        ],
      ),
      body: Body(),
    );
  }
}

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: size.height,
            child: Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(top: size.height * 0.3),
                  padding: EdgeInsets.only(
                      top: size.height * 0.12,
                      left: DefaultPadding,
                      right: DefaultPadding),
                  height: 500,
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24),
                      )),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Text('Color'),
                                  Row(
                                    children: [
                                      ColorDot(
                                        color: Color(0xFF356C95),
                                        isSelected: true,
                                      ),
                                      ColorDot(color: Color(0xFFF8C078)),
                                      ColorDot(color: Color(0xFF356C95)),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Expanded(
                              child: RichText(
                                  text: TextSpan(
                                      style: TextStyle(color: TextColor),
                                      children: [
                                    TextSpan(text: 'Kategori\n'),
                                    TextSpan(
                                        text: '${Get.arguments.kategori.nama}',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6
                                            ?.copyWith(
                                                fontWeight: FontWeight.bold))
                                  ])),
                            )
                          ],
                        ),
                        SizedBox(height: DefaultPadding / 2),
                        Expanded(
                            child: SingleChildScrollView(child: Description())),
                        SizedBox(height: DefaultPadding / 2),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            AddFavorit(),
                          ],
                        ),
                        SizedBox(height: DefaultPadding / 2),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: DefaultPadding),
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: DefaultPadding),
                                height: 50,
                                width: 58,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(18),
                                  // border: Border.all(color: Get.arguments.color)
                                ),
                                child: IconButton(
                                  icon: Icon(Icons.comment_rounded),
                                  // color: Get.arguments.color,
                                  onPressed: () {},
                                ),
                              ),
                              Expanded(
                                child: SizedBox(
                                  height: 50,
                                  child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          primary: Colors.blue),
                                      onPressed: () {
                                        Get.toNamed(Routes.UPDATE_BOOK, arguments: Get.arguments);
                                      },
                                      child: Text(
                                        'Edit'.toUpperCase(),
                                        style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      )),
                                ),
                              )
                            ],
                          ),
                        )
                      ]),
                ),
                ProductTitleWithImage()
              ],
            ),
          )
        ],
      ),
    );
  }
}

// price and image product
class ProductTitleWithImage extends StatelessWidget {
  const ProductTitleWithImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: DefaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Karya dari ${Get.arguments.penulis}',
            style: TextStyle(color: Colors.white),
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            '${Get.arguments.judul}',
            style: Theme.of(context)
                .textTheme
                .headline4
                ?.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(DefaultPadding / 9),
                decoration: BoxDecoration(
                  color: Colors.black45,
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Image.network(
                  '${Endpoint.Url}${Get.arguments.image}',
                  height: 200,
                  width: 135,
                  fit: BoxFit.fill,
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    RichText(
                        overflow: TextOverflow.ellipsis,
                      text: TextSpan(children: [
                        TextSpan(text: 'Penulis :\n'),
                        TextSpan(
                          text: '${Get.arguments.penulis}',
                          style: Theme.of(context).textTheme.headline6?.copyWith(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        )
                      ])),
                    SizedBox(
                      height: 20,
                    ),
                    RichText(
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(children: [
                          TextSpan(text: 'Penerbit :\n'),
                          TextSpan(
                              text: '${Get.arguments.penerbit}',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  ?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold))
                        ])),
                    SizedBox(
                      height: 20,
                    ),
                    RichText(
                        overflow: TextOverflow.ellipsis,
                        text: TextSpan(children: [
                          TextSpan(
                              text: 'Tahun Terbit :\n',
                              style: TextStyle(color: TextColor)),
                          TextSpan(
                              text: '${Get.arguments.tahunTerbit}',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6
                                  ?.copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold))
                        ])),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class ColorDot extends StatelessWidget {
  final Color color;
  final bool isSelected;

  const ColorDot({super.key, required this.color, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          EdgeInsets.only(top: DefaultPadding / 4, right: DefaultPadding / 2),
      padding: EdgeInsets.all(2.5),
      height: 24,
      width: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: isSelected ? color : Colors.transparent,
        ),
      ),
      child: DecoratedBox(
          decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
    );
  }
}

class Description extends StatelessWidget {
  const Description({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: DefaultPadding),
      child: Text(
        "${Get.arguments.description}",
        style: TextStyle(height: 1.5),
      ),
    );
  }
}

// class CartCounter extends StatefulWidget {
//   const CartCounter({super.key});
//
//   @override
//   State<CartCounter> createState() => _CartCounterState();
// }
//
// class _CartCounterState extends State<CartCounter> {
//   int numoftimes = 1;
//
//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         BuildOutlineButton(
//             press: () {
//               setState(() {
//                 if (numoftimes > 1) {
//                   numoftimes--;
//                 }
//               });
//             },
//             icon: Icons.remove),
//         Padding(
//           padding: const EdgeInsets.symmetric(horizontal: DefaultPadding / 2),
//           child: Text(
//             numoftimes.toString().padLeft(2, '0'),
//             style: Theme.of(context).textTheme.headline6,
//           ),
//         ),
//         BuildOutlineButton(
//             icon: Icons.add,
//             press: () {
//               setState(() {
//                 numoftimes++;
//               });
//             })
//       ],
//     );
//   }

//   SizedBox BuildOutlineButton(
//       {required IconData icon, required VoidCallback press}) {
//     return SizedBox(
//       width: 40,
//       height: 32,
//       child: OutlinedButton(
//           onPressed: press,
//           child: Icon(icon),
//           style:
//               ButtonStyle(padding: MaterialStateProperty.all(EdgeInsets.zero))),
//     );
//   }
// }

class AddFavorit extends StatelessWidget {
  const AddFavorit({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      width: 32,
      decoration:
          BoxDecoration(color: Color(0xFFFF6464), shape: BoxShape.circle),
      child: Icon(color: Colors.white, Icons.favorite),
    );
  }
}
