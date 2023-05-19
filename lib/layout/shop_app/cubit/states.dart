

import 'package:ecommerce/layout/shop_app/cubit/states.dart';
import 'package:ecommerce/models/shop_app/change_favorites_model.dart';
import 'package:ecommerce/models/shop_app/login_model.dart';

abstract class
ShopStates{}
class ShopInitialState extends ShopStates{}
class ShopChangeBottomNavState extends ShopStates{}

class ShopLoadingHomeDataState extends ShopStates{}
class ShopSuccessHomeDataState extends ShopStates{}
class ShopErrorHomeDataState extends ShopStates{}

class ShopSuccessCategoriesDataState extends ShopStates{}
class ShopErrorCategoriesDataState extends ShopStates{}

// favorites states
class ShopSuccessChangeFavoritesDataState extends ShopStates{
 final ChangeFavoritesModel? model;//مشان ناخد المسج
 ShopSuccessChangeFavoritesDataState(this.model);
}

class ShopSuccessChDaFAVState extends ShopStates {


}
class ShopFASucc extends ShopStates {
    late final ChangeFavoritesModel? model;//مشان ناخد المسج
    ShopFASucc(this.model);
}



class ShopSuccessChangeDataState extends ShopStates{}//call it in change favorites
class ShopErrorChangeFavoritesDataState extends ShopStates{}

//get favorites
class ShopSuccessGetFavoritesDataState extends ShopStates{}

class ShopSuccessLoadingFavoritesState extends ShopStates{}

class ShopErrorGetFavoritesDataState extends ShopStates{}
//get user
class ShopSuccessUserDataState extends ShopStates{

  final ShopLoadingModel loginModel;

  ShopSuccessUserDataState(this.loginModel);
}

class ShopSuccessLoadingUserState extends ShopStates{}

class ShopErrorUserDataState extends ShopStates{}
class ShopsuccessDioTestState extends ShopStates{}
//update
class ShopSuccessUpdateUserState extends ShopStates{

  final ShopLoadingModel loginModel;

  ShopSuccessUpdateUserState(this.loginModel);
}

class ShopLoadingUpdateUserState extends ShopStates{}

class ShopErrorUpdateUserState extends ShopStates{}

class ShopSingleCategoryLoginDataState extends ShopStates{}
class ShopSingleCategorySuccessDataState extends ShopStates{}
class ShopSingleCategoryErrorDataState extends ShopStates{}
//single pro

class ShopSingleProductLoginDataState extends ShopStates{}
class ShopSingleProductSuccessDataState extends ShopStates{}
class ShopSingleProductErrorDataState extends ShopStates{}



