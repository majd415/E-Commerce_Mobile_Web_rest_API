

import 'package:ecommerce/models/shop_app/login_model.dart';

abstract class ShopLoginStates{}
class ShopLoginInitialState extends ShopLoginStates{}
class ShopLoginLoadingState extends ShopLoginStates{}
class ShopLoginSuccessState extends ShopLoginStates{
late ShopLoadingModel  loginModel;
ShopLoginSuccessState(this.loginModel);

}
class ShopLoginErrorState extends ShopLoginStates{
  late final String error;
  ShopLoginErrorState(error);

}
class ShopChangePasswordVisibilityState extends ShopLoginStates{}