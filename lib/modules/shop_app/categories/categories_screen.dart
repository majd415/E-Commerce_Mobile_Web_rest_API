
import 'package:ecommerce/layout/shop_app/cubit/cubit.dart';
import 'package:ecommerce/layout/shop_app/cubit/states.dart';
import 'package:ecommerce/models/shop_app/categories_model.dart';
import 'package:ecommerce/shared/components/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ecommerce/models/shop_app/categories_model.dart' as ecomm;
class CategoriesScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        return  ListView.separated(
            itemBuilder: (context , index)=>buildCatItem(ShopCubit.get(context).categoriesModel!.data.data[index],context) ,
            separatorBuilder: (context,index)=> myDivider(),
            itemCount: ShopCubit.get(context).categoriesModel!.data.data.length);
      },
    );
  }
  Widget buildCatItem(DataModel model,context)=>  InkWell(
    onTap: (){
      ShopCubit.get(context).getSingleListCategory(  model.id,context);

    },
    child: Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Image(
            image: NetworkImage('${model.image}'),
            width: 80.0,
            height: 80.0,
            fit: BoxFit.cover,
          ),
          SizedBox(
            width: 20.0,
          ),
          Text('${model.name} ',
            style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold
            ),),
          Spacer(),
          Icon(
              Icons.arrow_forward_ios
          ),
        ],
      ),
    ),
  );
}
