import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:ecommerce/layout/shop_app/cubit/cubit.dart';
import 'package:ecommerce/layout/shop_app/cubit/states.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../../shared/components/components.dart';
import '../../../shared/styles/colors.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        return  ConditionalBuilder(
          condition:state is! ShopSuccessLoadingFavoritesState ,
          builder: (context)=> ListView.separated(
              itemBuilder: (context , index)=> buildListPruduct(ShopCubit.get(context).favoritesModel!.data!.data![index].product,context),
              separatorBuilder: (context,index)=> myDivider(),
              itemCount: ShopCubit.get(context).favoritesModel!.data!.data!.length),
          fallback:(context)=>const Center(child: CircularProgressIndicator()) ,
        );
      },
    );
  }

}
