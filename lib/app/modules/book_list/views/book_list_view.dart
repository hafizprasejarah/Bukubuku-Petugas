import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../data/constant/endpoint.dart';
import '../../../data/model/Product_model.dart';
import '../../../data/model/response_book.dart';
import '../../../routes/app_colors.dart';
import '../../../routes/app_pages.dart';
import '../controllers/book_list_controller.dart';

class BookListView extends GetView<BookListController> {
  const BookListView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Get.offAllNamed(Routes.HOME);
          },
        ),
        actions: <Widget>[
          IconButton(
              color: TextColor,
              onPressed: () {},
              icon: const Icon(Icons.search)),
          const SizedBox(
            width: DefaultPadding / 2,
          )
        ],
      ),
      body: Obx(() {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //Header
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: DefaultPadding),
              child: Text(
                "BookList",
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),

            //Slider Categories

            // const Categories(),

            //Card Product barang
            Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: DefaultPadding),
                  child: GridView.builder(
                    itemCount: controller.books!.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.75,
                        mainAxisExtent: MediaQuery.of(context).size.height * 0.49,
                        crossAxisSpacing: 15,mainAxisSpacing: 0),
                    itemBuilder: (context, index) => ItemCard(
                      book: controller.books![index],
                      press: () {
                        Get.toNamed(Routes.BOOK_DETAIL, arguments: controller.books![index]);
                      },
                    ),
                  ),
                ))
          ],
        );
      },)
    );
  }
}


//statefull widget untuk categories
class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  List<String> categories = ['Hand Bag', 'Jewellry', 'Footwear', 'Dresses'];
  int selectedindex = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: DefaultPadding),
      child: SizedBox(
        height: 25,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (context, index) => Buildcategory(index),
        ),
      ),
    );
  }

  Widget Buildcategory(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedindex = index;
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: DefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              categories[index],
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: selectedindex == index ? TextColor : TextLightColor,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 3),
              height: 2,
              width: 30,
              color: selectedindex == index ? Colors.black : Colors.transparent,
            )
          ],
        ),
      ),
    );
  }
}

// stateless untuk product list
class ItemCard extends StatelessWidget {
  const ItemCard({Key? key, this.product, this.press, this.book}) : super(key: key);
  final DataBook? book;
  final Product? product;
  final Function? press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (press != null) {
          press!(); // Panggil press jika press tidak null
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.all(DefaultPadding/6),
              decoration: BoxDecoration(
                color: Colors.black45,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Image.network(
                '${Endpoint.Url}${book!.image}',
                fit: BoxFit.fill,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: DefaultPadding / 100),
            child: Text(
              '${book!.penulis}',
              style: TextStyle(color: TextColor),
                overflow: TextOverflow.ellipsis
            ),
          ),
          Padding(
            padding: const EdgeInsets.only( bottom: 20),
            child: Text(
              "${book!.judul}",
              style:  TextStyle(fontWeight: FontWeight.bold),
                overflow: TextOverflow.ellipsis
            ),
          ),

        ],
      ),
    );
  }
}
