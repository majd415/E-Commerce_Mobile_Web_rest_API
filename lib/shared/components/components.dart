


import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:ecommerce/shared/styles/icon_broken.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../layout/shop_app/cubit/cubit.dart';

import '../../modules/products_single_categoty/products_single_category_screen.dart';
import '../../modules/single_product/single_product_screen.dart';
import '../styles/colors.dart';

//نحدد الشغلات التي يمكن ان تتغير
Widget defaultButton({
  double width=double.infinity,//default value
  Color background=Colors.blue,
  bool isUpperCase=true,// for case smale or apper
  required void Function() function ,//الدالة الذي يعمل بها متغير
  required String text ,
  double radius=0.0,

})=> Container(
  width: width,
  height: 40.0,
  child: MaterialButton(
    onPressed:function ,//func
    child: Text(isUpperCase ?  text.toUpperCase() : text,// هنا نستخدمعها
      style: TextStyle(
        color: Colors.white,
      ),   ),
  ),
  decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(radius),

    color: background,
  ),
);

////////////////////////////////////
Widget defaultFormfield({//حقول الادخال
  required TextEditingController controller,
  required TextInputType type,
required void Function(String) onChanged ,
  required void Function(String)  onSubmit,
  required String? Function(String?) validate,
  required String label ,
  required IconData prefix ,
   IconData?  suffix,
  bool isPassword=false,
  Function()? suffixPressed,//for press and show password
Function()? onTap,//مثلا لحتا نعمل شي معيت لما نضفط علية مثلا لما يلي بدنا نحط التاريخ مشان ما نحطو بايدنا منخلية يطلع                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            ونحنا منختار
bool isClickable=true,//مشان ما نخلي كل ما نضغط مثلا على التاريخ يطلع اول كيبوورد يلي ما منستخدما
})=>     TextFormField(//  مربع يوسر
  controller: controller,
  keyboardType:type ,//تستخدم لتعببن لوحة المفاتيح بجبث تتوافق مع نوع الادخال
  onChanged:onChanged,
  onFieldSubmitted: onSubmit,

  decoration: InputDecoration(
    // hintText: '',//يكتب بشكل نوضيحي على الادخال ويخنفي عمدما نكتب
    labelText: label,//نفس الشي بس لا بخنفي يطلع فوق
    prefixIcon: Icon(//تعطي ايقونة اول ال انبوت
        prefix
    ),
    suffixIcon:suffix!= null ? IconButton(icon: Icon(suffix),onPressed:suffixPressed ,): null,// تعطي ايقونة اخر ال انبوت
    border: OutlineInputBorder(),//لاظهار الحواف البوردر
  ),
  validator:validate  ,
  obscureText: isPassword,//تعطي النجم لل باسسورد اثناء الكتابة
  onTap: onTap,
  enabled:isClickable,
);
// ( value){//التحقق من الداتا
// if(value == null || value.isEmpty){
// return 'email adress must not be empty ';
// }
// return null;
// }
///////////////////////////////////
 Widget  defaultAppBar({
 required BuildContext context,
  String? title,
  dynamic actions,
})=>AppBar(
  leading: IconButton(
    icon: Icon(IconBroken.Arrow___Left_2),
    onPressed: (){
      Navigator.pop(context);
    },
  ),
  title: Text(
       '${title}',
    style: TextStyle(color: Colors.black),
  ),
  titleSpacing: 5.0,
  actions: actions ,
);
Widget buildTaskItem(Map model,context  )=> Dismissible(//تعمل سواب يمين و يسار
  key:Key(model['id'].toString()) ,//مفتاح غريب للودحت فهو رح يتغير بنائا علئ كل ايتم
  child:   Padding( //بما انة كانت بالاصل ليست اوف ماب نوعا اي البيانات يلي بدا تعرضا

    padding: const EdgeInsets.all(20.0),

    child: Row(

      children: [

        CircleAvatar(

          radius: 40,

          child: Text("${model['time']}"),

        ),

        SizedBox(

          width: 20.0,

        ),

        Expanded(

          child: Column(

            mainAxisSize: MainAxisSize.min,

            crossAxisAlignment: CrossAxisAlignment.start,//لتكون البداية نقسا

            children: [

              Text("${model['title']}",

                style: TextStyle(

                  fontWeight: FontWeight.bold,

                  fontSize: 18.0,

                ),),

              Text("${model['date']}",

                style: TextStyle(

                  color: Colors.grey,

                ),),



            ],

          ),

        ),

        SizedBox(

          width: 20.0,

        ),

        IconButton(

            onPressed: (){

         //   AppCubit.get(context).updateData(status: 'done', id: model['id']);//هوة محتاج conte xt مع الايتم منبعنو للكونتيكست كبارا متر مع العنصر

            },

            icon:Icon(

              Icons.check_box,

              color: Colors.green,

            )),

        IconButton(

            onPressed: (){

             // AppCubit.get(context).updateData(status: 'archive', id: model['id']);//هوة محتاج conte xt مع الايتم منبعنو للكونتيكست كبارا متر مع العنصر



            },

            icon:Icon(

              Icons.archive,

              color: Colors.black54,

            )),



      ],

    ),

  ),
  onDismissed: (direction){
//  AppCubit.get(context).deleteData(id: model['id']);//نحزف بالسواب يكيم او يسار
  },//بيديني الدايركشن يلي هوة عمل ديسمسبل فية يعني يمين او شمال
);


//الفاصل
Widget myDivider()=>Padding(
  padding: const EdgeInsetsDirectional.only(
    start: 20.0,
  ),
  child: Container(
    width: double.infinity,
    height: 1.0,
    color: Colors.grey[300],
  ),
);

/////news item
Widget buildArticalItem( {
  artical, context,index
})=> Container(
  //NewsCubit.get(context).businessSelectedItem[index] //&&NewsCubit.get(context).isDesktop==true
  color:Colors.black,//NewsCubit.get(context).selectedBusinessItem==index ? Colors.greenAccent[100]:Colors.white,
  child:   InkWell(//بتعما الايتم بينداس غلية

    onTap:(){//open url on webview on press

    //  navigateTo(context, WebViewScreen(artical['url']));
    //NewsCubit.get(context).selectedBussnissItemIndex(index);
    },

    child:   Padding(



      padding: const EdgeInsets.all(20.0),



      child: Row(



        children: [



          Container(



            width: 120,



            height: 120,



            decoration: BoxDecoration(



              borderRadius: BorderRadius.circular(10.0),



              image: DecorationImage(



                image: NetworkImage('${artical['urlToImage']??
                    'https://th.bing.com/th/id/R.9446bad0ca0f133ee435665005cfdadf?rik=5Q5L12hQ6B9nkg&riu=http%3a%2f%2fwww.zastavki.com%2fpictures%2f2560x1600%2f2012%2fFood_Bread_rolls_croissants_Fast_Food_Hamburger_034633_.jpg&ehk=zz0cTx%2b7sZpIlyIhTw%2bHLtmzYcnqzBoiCV94nxb0g2c%3d&risl=&pid=ImgRaw&r=0'}'),



                fit: BoxFit.cover,











              ),



            ),



          ),



          SizedBox(



            width: 20.0,



          ),



          Expanded(



            child: Container(



              height: 120.0,



              child: Column(



                crossAxisAlignment: CrossAxisAlignment.start,



                children: [



                  Expanded(



                    child: Text('${artical['title']}',



                      style: Theme.of(context).textTheme.bodyText1,



                     //بجيب الbodytext1 يلي عملناة بالثيم و بيستخدمو هوه محتاج context ابعتلو مع الداتا ك ارغيومنت







                      maxLines: 3,



                      overflow: TextOverflow.ellipsis,),



                  ),



                  Text('${artical['publishedAt']}',



                    style: TextStyle(



                      fontSize: 18.0,



                      fontWeight: FontWeight.w600,



                      color: Colors.grey,



                    ),),







                ],



              ),



            ),



          ),



        ],



      ),



    ),

  ),
);


///////item bulder for news app
//isSearch=false عشان عرفو انو انا جايي نت السيرش مشان نستعني غن الشريط يلي بلف منبعتو اثناء السيرش فقط
Widget articleBulder(list,  context,{isSearch=false})=>ConditionalBuilder(
    condition: list.length>0,
    builder: (context)=>ListView.separated(
      physics: BouncingScrollPhysics(),//بتخلية ينزل بدون ما يعمل الللون يلي بيطهر فوق
      itemBuilder: (context,index)=>buildArticalItem(artical:list[index],context: context,index: index),
      separatorBuilder: (context,index)=>myDivider(),//الفاصل يلي حطيناة لحالو بودجت
      itemCount: 10,
    ),
    //هون
    fallback: (context)=>isSearch ?Container():Center(child: CircularProgressIndicator()));


//navegator method
//تاخد context و widget  رخ تروح الها
void navigateTo(context,widget)=>Navigator.push(//تنتقل وترجع بالترتيب
    context,
    MaterialPageRoute(
        builder: (context)=>widget));
void navigateAndFinish(context,widget)=>Navigator.pushAndRemoveUntil(//تنتقل وترجع بالترتيب
    context,
    MaterialPageRoute(
        builder: (context)=>widget),
    (Route<dynamic>route)=>false);
//routs يلي فاتت عاوذها نضل موجوده true او عايذ تلغي false
Widget defaultTextButton({
  required Function() function
,
required String text})=>    TextButton(
    onPressed: function,
    child: Text(text.toUpperCase()));


/////alert for login
void showToast({
  required String text,
  required ToastStates state,

})=>  Fluttertoast.showToast(//التنبية و عرض رسالة معيتة
    msg: text,//message
    toastLength: Toast.LENGTH_SHORT,//time
    gravity: ToastGravity.BOTTOM,//زر
    timeInSecForIosWeb: 5,//بالثواتي لل ios and web
    backgroundColor: chooseToastColor(state),//استدعاء الدالة
    textColor: Colors.white,
    fontSize: 16.0
);

//اذا كان عنا شغلة فيا اكتر من حالة مثلا هنا لون الخلفية حسب ال error
enum ToastStates{ SUCCESS,ERROR,WARNING}
Color? chooseToastColor(ToastStates state){
  Color color;
  switch(state){
    case ToastStates.SUCCESS:
      color= Colors.green;
      break;
    case ToastStates.ERROR:
      color= Colors.redAccent;
      break;
    case ToastStates.WARNING:
      color= Colors.amber;
      break;



  }
  return color;

}
//fav and search item
Widget buildListPruduct(  model,context,{bool isOldPrice=true})=> InkWell(
    onTap: (){
      //ShopCubit.get(context).getSingleProduct(model.id,context);
      navigateTo(context, SingleProductScreen(prosingle: model,));
    },
  child:   Padding(

    padding: const EdgeInsets.all(10.0),

    child: Container(

      height: 120.0,

      child: Row(

        children: [

          Stack(//اذا في خصم اطهر على الصوورة

            alignment: AlignmentDirectional.bottomStart,

            children: [

              Image(image: NetworkImage(

                //model!.data!.data![index].product!.image

                '${ model!.image}',





              ),

                width: 120.0,

                height: 120.0,



              ),

              if(model.discount !=0 && isOldPrice)////ِشرط

                Container(

                  color: Colors.red,

                  padding: const EdgeInsets.symmetric(

                      horizontal: 5.0

                  ),

                  child:  const Text(

                    'DISCOUNT',

                    style: TextStyle(

                        fontSize: 8.0,

                        color: Colors.white

                    ),

                  ),

                ),

            ],

          ),

          const SizedBox(

            width: 20.0,

          ),

          Expanded(

            child: Padding(

              padding: const EdgeInsets.all(12.0),

              child: Column(

                crossAxisAlignment: CrossAxisAlignment.start,



                children: [

                  Text('${model.name}',

                    maxLines: 2,

                    overflow: TextOverflow.ellipsis,

                    style: const TextStyle(

                      fontSize: 14.0,

                      height: 1.3,

                    ),),

                  const Spacer(),

                  Row(

                    children: [

                      Text('${model.price}',

                        style: const TextStyle(

                          fontSize: 12.0,

                          color: defaultColor,



                        ),),

                      const SizedBox(width: 5.0,),

                      if(model.discount != 0 && isOldPrice)

                        Text('${model.oldPrice}',

                          style: const TextStyle(

                              fontSize: 10.0,

                              color: Colors.grey,

                              decoration: TextDecoration.lineThrough



                          ),),

                      const Spacer(),

                      IconButton(

                        // padding: EdgeInsets.zero,

                          onPressed: (){// استدعاء الفافوريت



                            ShopCubit.get(context).changeFavorites(model.id);



                          },

                          icon: CircleAvatar(

                            backgroundColor: ShopCubit.get(context).favorites[model.id]==true//ShopCubit.get(context).favorites[model.id]==true

                                ? defaultColor :Colors.grey ,

                            radius: 15.0,

                            child: const Icon(

                              Icons.favorite_border,

                              color: Colors.white,),

                          )),
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

          ),

        ],



      ),

    ),

  ),
);
// Widget? defaultAppBar({
//   required BuildContext? context,
//   String? title,
//    List<Widget>?  actions,
// })=>AppBar(
//   leading: IconButton(
//     onPressed: (){
//       Navigator.pop(context!);
//     },
//     icon: Icon(
//       IconBroken.Arrow___Left_2,
//     ),
//   ),
//   title: Text('$title'??''),
//   actions: actions ?? [],
// );