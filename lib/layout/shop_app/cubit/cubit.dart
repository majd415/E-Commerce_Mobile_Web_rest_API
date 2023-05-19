

import 'package:ecommerce/models/shop_app/categories_model.dart';
import 'package:ecommerce/models/shop_app/favorites_model.dart';
import 'package:ecommerce/models/shop_app/home_model.dart';
import 'package:ecommerce/models/shop_app/login_model.dart';
import 'package:ecommerce/modules/shop_app/categories/categories_screen.dart';
import 'package:ecommerce/modules/shop_app/products/products_screen.dart';
import 'package:ecommerce/modules/shop_app/settings/settings_screen.dart';
import 'package:ecommerce/shared/components/components.dart';
import 'package:ecommerce/shared/components/constants.dart';
import 'package:ecommerce/shared/network/remote/dio_helper.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:ecommerce/models/shop_app/change_favorites_model.dart';
import '../../../models/shop_app/single_liast_category.dart';
import '../../../modules/products_single_categoty/products_single_category_screen.dart';
import '../../../modules/shop_app/favorites/favorites_screen.dart';

import '../../../modules/single_product/single_product_screen.dart';
import '../../../shared/network/end_points.dart';
import '../../../shared/network/local/cashe_helper.dart';
import 'package:ecommerce/layout/shop_app/cubit/states.dart';
class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() :super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<Widget> bottomScreen = [

    ProductsScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingScreen()
  ];

  void changeBottom(int index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  //get home data from api
  HomeModel? homeModel; //فاضي املاة حوا
  Map<int, bool> favorites = {}; //list favorites id and true or false
  void getHomeData() {
    emit(ShopLoadingHomeDataState());
    DioHelper.getData(
      url: HOME, //END POINT
      token: token,
    ).then((value) {
      //ببروفايدا بالمين لل getHomeData ب shopcubit
      homeModel = HomeModel.fromJson(value.data);
      //  printFullText(homeModel!.data.banners[0].image);

      // print("this test model${homeModel!.data.products.}");
      homeModel!.data.products.forEach((element) {
        if( element.id==52){
          print("this is the single pro {${element.name.toString()}");
        }


      });

      homeModel!.data.products.forEach((element) {
        favorites.addAll({ //list favorites
          element.id: element.inFavorites,

        }

        );
        //    print(favorites.toString());

      });
      emit(ShopSuccessHomeDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorHomeDataState());
    });
  }


  //get kist single category
  SingleListCategoryModel? singleListCategoryModel;
  List<ProductCat> cat_Product=[];
 Future<void>  getSingleListCategory( int id, context) async {
    emit(ShopSingleCategoryLoginDataState());
   await DioHelper.getData(
      url: "products?category_id=$id", //END POINT
      token: token,
    ).then((value) {
      //ببروفايدا بالمين لل getHomeData ب shopcubit
      singleListCategoryModel =   SingleListCategoryModel.fromJson(value.data);
       //printFullText(value.data);//homeModel!.data.banners[0].image
      //    print(homeModel!.status);
      print(value.data.toString());
     // print(singleListCategoryModel!.data!.data!);
      singleListCategoryModel!.data!.data!.forEach((element) {
        // cat_Product.addAll(
        //
        // );
         // print(element.toString());

      });
      // navigateTo(context, ProductSingleCategoryScreen());
      emit(ShopSingleCategorySuccessDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopSingleCategoryErrorDataState());
    });
  }

  //git single pro
  void getSingleProduct(int id,context) {
    emit(ShopSingleProductLoginDataState());
    DioHelper.getData(
      url: HOME, //END POINT
      token: token,
    ).then((value) {
      //ببروفايدا بالمين لل getHomeData ب shopcubit
      homeModel = HomeModel.fromJson(value.data);
      //  printFullText(homeModel!.data.banners[0].image);

      // print("this test model${homeModel!.data.products.}");
    var prosingle;
     homeModel!.data.products.forEach((element) {
        if( element.id==id){
          print("this is the single pro {${element.name.toString()}");
      prosingle=element;
        }


      });

    //navigateTo(context, SingleProductScreen(prosingle: prosingle,));
      emit(ShopSingleProductSuccessDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopSingleProductErrorDataState());
    });
  }

  //get home data from api
  CategoriesModel? categoriesModel; //فاضي املاة حوا
  void getCategoriesData() {
    DioHelper.getData(
      url: GET_CATEGORIES, //END POINT
      token: token,
    ).then((value) {
      //ببروفايدا بالمين لل getHomeData ب shopcubit
      categoriesModel = CategoriesModel.fromJson(value.data);
      emit(ShopSuccessCategoriesDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorCategoriesDataState());
    });
  }

//post and change products favorites
 ChangeFavoritesModel? changeFavoritesModel;

  void changeFavorites(int? productId) {
    //اقوم بعطس قيمتي i will change my value
    favorites[productId!] = !favorites[productId]!; // للتغير اللحظي
    emit(ShopSuccessChangeDataState());

    DioHelper.postData(
        url: FAVORITES,
        data: {
          'product_id': productId,
        },
        token: token
    ).then((value) {
      changeFavoritesModel = ChangeFavoritesModel.fromJson(value.data);
      if (!changeFavoritesModel!.status!) {
        //if error in status
        favorites[productId] = !favorites[productId]!; // للتغير اللحظي

      } else {
        getFavoritesData(); //هون
      }
      //changeFavoritesModel!
      emit(ShopSuccessChangeFavoritesDataState(changeFavoritesModel));
    }).catchError((error) {
      //if full error in status
      favorites[productId] = !favorites[productId]!; // للتغير اللحظي

      emit(ShopErrorChangeFavoritesDataState());
    });
  }

  //get Favorites data from api
  FavoritesModel? favoritesModel; //فاضي املاة حوا
  void getFavoritesData() {
    emit(ShopSuccessLoadingFavoritesState()); //حركة تحديث قائكة القاقوريت
    //منحيب ال get favorite مرة اخرى بالشبنج فافوريت مشان كل تغيير
    DioHelper.getData(
      url: FAVORITES, //END POINT
      token: token,
    ).then((value) {
      //ببروفايدا بالمين لل getHomeData ب shopcubit
      favoritesModel = FavoritesModel.fromJson(value.data);
      // printFullText(value.data.toString());

      emit(ShopSuccessGetFavoritesDataState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorGetFavoritesDataState());
    });
  }

  //////get sitings
  ShopLoadingModel? userModel; //فاضي املاة حوا
  void getUserData() {
    emit(ShopSuccessLoadingUserState()); //حركة تحديث قائكة القاقوريت
    //منحيب ال get favorite مرة اخرى بالشبنج فافوريت مشان كل تغيير
    DioHelper.getData(
      url: PROFILE, //END POINT
      token: CasheHelper.getToken(),


    ).then((value) {
      //ببروفايدا بالمين لل getHomeData ب shopcubit
      userModel = ShopLoadingModel.fromJson(value.data);
      printFullText(userModel!.data.toString());

      emit(ShopSuccessUserDataState(userModel!));
    }).catchError((error) {
      print(error.toString());


      emit(ShopErrorUserDataState());
    });


      }
      //update user
  void updateUserData({
    required String name,
    required String email,
    required String phone,

  }) {
    emit(ShopLoadingUpdateUserState()); //حركة تحديث قائكة القاقوريت
    //منحيب ال get favorite مرة اخرى بالشبنج فافوريت مشان كل تغيير
    DioHelper.putData(
      url: UPDATE_PROFILE, //END POINT
      token: CasheHelper.getToken(),
      data: {
        'name': name,
        'email': email,

        'phone': phone,

      },


    ).then((value) {
      //ببروفايدا بالمين لل getHomeData ب shopcubit
      userModel = ShopLoadingModel.fromJson(value.data);
      printFullText(userModel!.data.toString());

      emit(ShopSuccessUpdateUserState(userModel!));
    }).catchError((error) {
      print(error.toString());


      emit(ShopErrorUpdateUserState());
    });}




}
//ملاحطة نستدعي الدوال في ال main

