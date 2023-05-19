

import 'package:ecommerce/models/shop_app/login_model.dart';

abstract class ShopRegisterStates{}
class ShopRegisterInitialState extends ShopRegisterStates{}
class ShopRegisterLoadingState extends ShopRegisterStates{}
class ShopRegisterSuccessState extends ShopRegisterStates{
late ShopLoadingModel  loginModel;
ShopRegisterSuccessState(this.loginModel);

}
class ShopRegisterErrorState extends ShopRegisterStates{
  late final String error;
  ShopRegisterErrorState(error);

}
class ShopRegisterChangePasswordVisibilityState extends ShopRegisterStates{}

