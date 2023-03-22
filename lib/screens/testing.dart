import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/providers/categoryProvider.dart';
import 'package:restaurant_app/utils.dart';
class ProviderScreen extends StatelessWidget {
  static const routeName = 'testing';
  const ProviderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final id = context.read<CategoryProvider>().categoryId;
    print('here it prints id $id');
    return Scaffold(
      body: Consumer<CategoryProvider>(
        builder: (ctx, data, child) {
          return ListView.builder(
            itemCount: data.items.length,
            itemBuilder: (ctx, index){
              return ListTile(
                leading: Text(data.items[index].id.toString(), style: Global.kPrimaryText,),
                trailing: Text(data.items[index].title.toString()),
              );
            },
          );
        },
      ),
    );
  }
}
