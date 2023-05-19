import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:ecommerce/modules/shop_app/register/cubit/cubit.dart';
import 'package:ecommerce/modules/shop_app/register/cubit/states.dart';


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../layout/shop_app/shop_layout.dart';
import '../../../shared/components/components.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/network/local/cashe_helper.dart';
import '../login/cubit/cubit.dart';

class ShopRegisterScreen extends StatelessWidget {
  var formKey=GlobalKey<FormState>();
  var emailController=TextEditingController();
  var passwordController=TextEditingController();
  var nameController=TextEditingController();
  var phoneController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ShopRegisterCubit(),
      child: BlocConsumer<ShopRegisterCubit,ShopRegisterStates>(
        listener: (context,state){
          if(state is ShopRegisterSuccessState){
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
        builder:(context,state){
          return Scaffold(
            //appBar: AppBar(),
            body:  Center(
              child: SingleChildScrollView(//مشان ايرور الكيب وورد
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              Text('REGISTER',
                                style: Theme.of(context).textTheme.headline4?.copyWith(
                                  color: Colors.black,
                                ),),
                              Text('Register now to browse our hot offers ',
                                style: Theme.of(context).textTheme.bodyText1?.copyWith(
                                  color: Colors.grey,
                                ),),
                              SizedBox(
                                height: 30.0,
                              ),
                              defaultFormfield(
                                controller: nameController,
                                type: TextInputType.name,
                                onChanged: (value){},
                                onSubmit: (value){},
                                validate: (value){
                                  if(value!.isEmpty){
                                    return ' most not be empty';
                                  }
                                  return null;
                                },
                                label: 'Your Name',
                                prefix: Icons.person,),
                              SizedBox(
                                height: 15.0,
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
                             },
                                validate: (value){
                                  if(value!.isEmpty){
                                    return ' Password is too short';
                                  }
                                  return null;
                                },
                                label: 'Password ',
                                prefix: Icons.lock_clock_outlined,
                                suffix:ShopRegisterCubit.get(context).suffix ,
                                isPassword: ShopRegisterCubit.get(context).isPassword,
                                suffixPressed: (){
                                  ShopRegisterCubit.get(context).changePasswordVisibility();
                                },
                              ),
                              defaultFormfield(
                                controller: phoneController,
                                type: TextInputType.phone,
                                onChanged: (value){},
                                onSubmit: (value){},
                                validate: (value){
                                  if(value!.isEmpty){
                                    return ' most not be empty';
                                  }
                                  return null;
                                },
                                label: 'Phone Number',
                                prefix: Icons.phone,),

                              SizedBox(
                                height: 15.0,
                              ),
                              ConditionalBuilder(
                                condition:state is! ShopRegisterLoadingState ,
                                builder:(context)=>  defaultButton(
                                  //لاستخدام الكونترولر بدنا فورم ستيت
                                    function: (){
                                      if(formKey.currentState!.validate()){
                                        ShopRegisterCubit.get(context).userRegister(
                                           name: nameController.text,
                                            email: emailController.text,
                                            password: passwordController.text,
                                        phone: phoneController.text);
                                      }
                                    },
                                    text: 'Register',
                                    isUpperCase: true) ,
                                fallback:(context)=>Center(child: CircularProgressIndicator()) ,
                              ),
                              SizedBox(
                                height: 15.0,
                              ),

                            ],
                          ),
                        ),
                        if(MediaQuery.of(context).size.width.toInt() >= 560)

                           Expanded(
                              child: Center(child: Image( image: AssetImage('assets/images/signin.jpg'), ))),
                      ],
                    ),
                  ),
                ),
              ),
            ) ,
          );
        } ,
      ),
    );
  }
}
