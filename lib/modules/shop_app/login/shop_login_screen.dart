import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:ecommerce/layout/shop_app/shop_layout.dart';
import 'package:ecommerce/modules/shop_app/login/cubit/cubit.dart';
import 'package:ecommerce/modules/shop_app/login/cubit/states.dart';
import 'package:ecommerce/shared/components/components.dart';
import 'package:ecommerce/shared/network/local/cashe_helper.dart';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../shared/components/constants.dart';
import '../register/shop_register_screen.dart';

class ShopLoginScreen extends StatelessWidget {
var formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var emailController=TextEditingController();
    var passwordController=TextEditingController();
    return BlocProvider(
      create: (BuildContext context)=>ShopLoginCubit(),
      child: BlocConsumer<ShopLoginCubit,ShopLoginStates>(
      listener: (context,state){
        if(state is ShopLoginSuccessState){
          //روح على سرينة الهوم
          if(state.loginModel.status==true){
            print(state.loginModel.message);
            print(state.loginModel.data!.token);

            CasheHelper.saveData(
                key: 'token',
                value: state.loginModel.data!.token).then((value){
                  token=state.loginModel.data!.token;//هي الحركة مهمة لان التوكين بستدعى فقط بالمين ف لما نعمل تسجيل خروج ونرجع نفوت مرح بجب مهلومات التوطين من اول مره ورح بعطي خطاء

                  navigateAndFinish(context, ShopLayout());
            });
          }else{ //رح يروح عسكرسينة تانية
            //اثبت مكانك
            print(state.loginModel.message);
          ///
            ///
            showToast(//المسج
              text: state.loginModel.message!,
              state: ToastStates.ERROR,
            );
          }
        }
      },
        builder: (context,state){
        return Scaffold(
          // appBar: AppBar(),
          body: Center(
            child: SingleChildScrollView(//مشان ايرور الكيب وورد
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Form(
                  key: formKey,
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [
                            Text('LOGIN',
                              style: Theme.of(context).textTheme.headline4?.copyWith(
                                color: Colors.black,
                              ),),
                            Text('login now to browse our hot offers ',
                              style: Theme.of(context).textTheme.bodyText1?.copyWith(
                                color: Colors.grey,
                              ),),
                            SizedBox(
                              height: 30.0,
                            ),
                            defaultFormfield(
                              controller: emailController,
                              type: TextInputType.emailAddress,
                              onChanged: (value){},
                              onSubmit: (value){},
                              validate: (value){
                                if(value!.isEmpty){
                                  return ' most not be empty';
                                }
                                return null;
                              },
                              label: 'Email Address',
                              prefix: Icons.email_outlined,),
                            SizedBox(
                              height: 15.0,
                            ),
                            defaultFormfield(
                              controller:passwordController,
                              type: TextInputType.visiblePassword,
                              onChanged: (value){},
                              onSubmit: (value){
                               if(formKey.currentState!.validate()){
                              ShopLoginCubit.get(context).userLogin(
                            email: emailController.text,
                                password: passwordController.text);
                              }},
                              validate: (value){
                                if(value!.isEmpty){
                                  return ' Password is too short';
                                }
                                return null;
                              },
                              label: 'Password ',
                              prefix: Icons.lock_clock_outlined,
                              suffix:ShopLoginCubit.get(context).suffix ,
                              isPassword: ShopLoginCubit.get(context).isPassword,
                              suffixPressed: (){
                                ShopLoginCubit.get(context).changePasswordVisibility();
                              },
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            ConditionalBuilder(
                            condition:state is! ShopLoginLoadingState ,
                              builder:(context)=>  defaultButton(
                                //لاستخدام الكونترولر بدنا فورم ستيت
                                  function: (){
                                   if(formKey.currentState!.validate()){
                                     ShopLoginCubit.get(context).userLogin(
                                         email: emailController.text,
                                         password: passwordController.text);
                                   }
                                  },
                                  text: 'LogIn',
                                  isUpperCase: true) ,
                              fallback:(context)=>Center(child: CircularProgressIndicator()) ,
                            ),
                            SizedBox(
                              height: 15.0,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("don\'t have an account "),
                                defaultTextButton(
                                    function:(){
                                      navigateTo(context, ShopRegisterScreen());

                                    } ,
                                    text: 'Register now'),

                              ],
                            ),
                          ],
                        ),
                      ),
                      if(MediaQuery.of(context).size.width.toInt() >= 560)

                          Expanded(
                          child: Center(child: Image( image: AssetImage('assets/images/login_image.jpg'), ))),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
        },

      ),
    );
  }
}
