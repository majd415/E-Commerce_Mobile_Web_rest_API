


import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:ecommerce/layout/shop_app/cubit/cubit.dart';
import 'package:ecommerce/layout/shop_app/cubit/states.dart';
import 'package:ecommerce/models/shop_app/categories_model.dart';
import 'package:ecommerce/models/shop_app/home_model.dart';
import 'package:ecommerce/shared/components/components.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../shared/styles/colors.dart';


import '../../models/shop_app/single_liast_category.dart';



class ProductSingleCategoryScreen extends StatelessWidget {
  int? id;
   ProductSingleCategoryScreen( this.id, {Key? key}) : super(key: key);


 // int? id;
   //ProductSingleCategoryScreen({ this.id});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)  =>ShopCubit()..getSingleListCategory(id!, context)..getCategoriesData() ,
      child: BlocConsumer<ShopCubit,ShopStates>(
          listener:(context,state){
            if(state is ShopFASucc){
              if(!state.model!.status!){
                //ToastStates message error or success
                showToast(text: state.model!.message!, state: ToastStates.ERROR);
              }

            }
          },
          builder:(context,state){
            // print("id test:$id");
            return Scaffold(
              appBar: AppBar(
                title: const Text("CATEGORY"),
              ),
              body: ConditionalBuilder(
                  condition: state !=ShopSingleCategoryLoginDataState && ShopCubit.get(context).singleListCategoryModel != null &&ShopCubit.get(context).categoriesModel !=null,//منلعب عال homeModel==null خلي ال انديكيتور يلف بلا ما تلعب عالستيت دايما حاول تلعب علر حالة ثابتة
                  builder: (context)=>productsBuilder(ShopCubit.get(context).singleListCategoryModel,ShopCubit.get(context).categoriesModel,context),
                  fallback: (context)=>Center(
                      child: CircularProgressIndicator())),
            );

          } ,
           ),
    );
  }

  Widget productsBuilder(SingleListCategoryModel? model,CategoriesModel? categoriesModel,context)=>SingleChildScrollView(
   physics: BouncingScrollPhysics(),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [


        SizedBox(
          height: 10.0,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Categories',
              style: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.w800,
              ),),
              SizedBox(
                height: 10.0,
              ),
      Container(
              height: 100.0,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (context,index)=>buildCategoryItem(categoriesModel!.data.data[index],context),
                  separatorBuilder: (context,index)=>SizedBox(
                    width: 10.0,
                  ),
                  itemCount: categoriesModel!.data.data.length),
      ),
              SizedBox(
                height: 20.0,
              ),

            ],
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
        Container(
          color: Colors.grey[300],
          child: GridView.count(
            shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
              mainAxisSpacing: 1.0,//يبعدم عن بعض
              crossAxisSpacing: 1.0,
              childAspectRatio: 1/1.7,//  اذا عطانا overflow نتجطم من هوم نتجطك بالعرض و الطول
              children: List.generate(model!.data!.data!.length, (index)
              => buildGridProduct(model.data!.data![index],context),//نيني الاينم برا
              ),
            ),
        ),

      ],
    ),
  );



  Widget buildCategoryItem(DataModel? model,context)=>  InkWell(
    onTap:(){
      //ShopCubit.get(context).getSingleListCategory( model!.id,context);
      navigateTo(context, ProductSingleCategoryScreen(model!.id));
    }
    ,
    child: Stack(
      alignment: AlignmentDirectional.bottomCenter,
      children: [
        Image(
          image: NetworkImage('${model?.image}'),
          width: 100.0,
          height: 100.0,
          fit: BoxFit.cover,),
        Container(
          color: Colors.black.withOpacity(0.8,),
          width: 100.0,

          child: Text('${model?.name}',
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.white,


            ),),
        ),
      ],
    ),
  );


  Widget buildGridProduct(ProductCat model, context)=>Container(
   color: Colors.white,

    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(//اذا في خصم اطهر على الصوورة
        alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(image: NetworkImage(
              '${model.image}',



            ),
            width: double.infinity,
            height: 200.0,
            ),
           if(model.discount !=0)////ِشرط
               Container(
               color: Colors.red,
               padding: EdgeInsets.symmetric(
                   horizontal: 5.0
               ),
               child:  Text(
                 'DISCOUNT',
                 style: TextStyle(
                     fontSize: 8.0,
                     color: Colors.white
                 ),
               ),
             ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Text('${model.name}',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14.0,
                height: 1.3,
              ),),
              Row(
                children: [
                  Text('${model.price.round()}',
                    style: TextStyle(
                      fontSize: 12.0,
                      color: defaultColor,

                    ),),
                  SizedBox(width: 5.0,),
                if(model.discount != 0)
                  Text('${model.oldPrice.round()}',
                    style: TextStyle(
                        fontSize: 10.0,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough

                    ),),
                Spacer(),
                  IconButton(
                    // padding: EdgeInsets.zero,
                      onPressed: (){// استدعاء الفافوريت

                        ShopCubit.get(context).changeFavorites(model.id);

                      },
                      icon: CircleAvatar(
                        backgroundColor: ShopCubit.get(context).favorites[model.id]==true ? defaultColor :Colors.grey ,
                        radius: 15.0,
                          child: Icon(
                              Icons.favorite_border,
                          color: Colors.white,),
                      )),
                  ////new edit ******
                  IconButton(
                    // padding: EdgeInsets.zero,
                      onPressed: (){// استدعاء الفافوريت

                        sendWhatsAppMessage(context: context,phone: "+971566492874",message:"hi i want  ${model.name}" );
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
            ],
          ),
        ),
      ],

    ),
  );
}
 sendWhatsAppMessage({required context,required String phone,required String message})async{

  String url(){
    // if(Platform.isIOS)
    //   return "";
    // else{
    // }
    return "https://api.whatsapp.com/send/?phone=$phone&text=$message";
    //flutter run -d chrome --web-renderer html

    //"whatsapp://send?phone=$phone&text=$message";
  }
  await launch(url());//canLaunch(url()) ? launch(url()) :ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("there is noo whatsapp in your device ")));

}
