import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../layout/shop_app/cubit/cubit.dart';
import '../../layout/shop_app/cubit/states.dart';
import '../../models/shop_app/home_model.dart';
import '../../shared/styles/colors.dart';
import '../products_single_categoty/products_single_category_screen.dart';
class SingleProductScreen extends StatelessWidget {
  //ProductModel?
  var prosingle;

  SingleProductScreen({required  this.prosingle});


  @override
  Widget build(BuildContext context) {


    return BlocProvider(
      create: (BuildContext context) => ShopCubit()..getSingleProduct(prosingle!.id, context)..getFavoritesData(),
      child: BlocConsumer<ShopCubit,ShopStates>(
        listener: (context,state){},
        builder: (context,state){
          print("this single model${prosingle}");
          return ConditionalBuilder(
            condition:state !=ShopSingleProductLoginDataState ,
            builder:(context)=> Scaffold(
              appBar: AppBar(
                leading: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Image( image: AssetImage('assets/images/logo.png'), ),
                ),

              ),
              body: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Container(
                      width: 200,
                      height: 200,
                      child: Image(image: NetworkImage("${prosingle!.image}",),
                      ),
                    ),//AssetImage('assets/images/logo.png')),//,
                    Expanded(
                      child: Center(
                        child: Container(
                          width: 300,
                          height: 300,
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text('${prosingle!.price.round()}',
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      color: defaultColor,

                                    ),),

                                  SizedBox(width: 5.0,),
                                  if(prosingle!.discount != 0)
                                    Text('${prosingle!.oldPrice.round()}',
                                      style: TextStyle(
                                          fontSize: 10.0,
                                          color: Colors.grey,
                                          decoration: TextDecoration.lineThrough

                                      ),),
                                  Spacer(),

                                  IconButton(
                                    // padding: EdgeInsets.zero,
                                      onPressed: (){// استدعاء الفافوريت

                                        ShopCubit.get(context).changeFavorites(prosingle!.id);

                                      },
                                      icon: CircleAvatar(
                                        backgroundColor: ShopCubit.get(context).favorites[prosingle!.id]==true ? defaultColor :Colors.grey ,
                                        radius: 15.0,
                                        child: Icon(
                                          Icons.favorite_border,
                                          color: Colors.white,),
                                      )),
                                  ////new edit ******
                                  IconButton(
                                    // padding: EdgeInsets.zero,
                                      onPressed: (){// استدعاء الفافوريت

                                        sendWhatsAppMessage(context: context,phone: "+971566492874",message:"hi i want  ${prosingle!.name}" );
                                      },
                                      icon: CircleAvatar(
                                        backgroundColor: Colors.greenAccent,//ShopCubit.get(context).favorites[model.id]==true ? defaultColor :Colors.grey ,
                                        radius: 15.0,
                                        child: Icon(
                                          Icons.whatsapp,
                                          color: Colors.white,),
                                      ))

                                ],
                              ),
                              Text('${prosingle!.name}',),
                            ],
                          ),
                        ),
                      ),
                    )


                  ],
                ),
              ),
            ) ,
            fallback:(context)=>Center(child: CircularProgressIndicator()) ,


                      );
        },
      ),
    );
  }
}
