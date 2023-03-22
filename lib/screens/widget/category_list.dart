import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/screens/widget/product_item.dart';

import '../../providers/categoryProvider.dart';

class CategoryList extends StatefulWidget {
  const CategoryList({Key? key}) : super(key: key);

  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {

  var category_id = '100';
  late String  somecategory ;

  var loaded = false;


  @override
  void initState() {
    // TODO: implement initState
    if(category_id != '100'){
      loaded = true;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.only(left: 18),
          child: Consumer<CategoryProvider>(
            builder: (ctx, data, _) {
              return Row(
                children: List.generate(
                  data.items.length,
                      (index) => GestureDetector(
                    onTap: () {
                      setState(() {
                        category_id = data.items[index].id!;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15.0, vertical: 10.0),
                      decoration:  BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: category_id == data.items[index].id
                                ? Colors.red
                                : Colors.transparent,
                            width: 2.0,
                          ),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 4.0),
                        child: Text(
                          data.items[index].title.toString(),
                          style: const TextStyle(
                            fontSize: 18.0,
                            color: Colors.grey
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 50,),
        ProductItem(productId: category_id),
      ],
    );
  }
}
