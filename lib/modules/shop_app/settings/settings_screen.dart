import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:ecommerce/layout/shop_app/cubit/cubit.dart';
import 'package:ecommerce/layout/shop_app/cubit/states.dart';
import 'package:ecommerce/shared/components/components.dart';
import 'package:ecommerce/shared/components/constants.dart';


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class SettingScreen extends StatelessWidget {
var nameController=TextEditingController();
var emailController=TextEditingController();

var phoneController=TextEditingController();
var formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
listener:(context,state){


} ,
    builder: (context,state){

 late var model=ShopCubit.get(context);//ShopLoginCubit.get(context).loginModel;
 // for show previse data in field
 if(model.userModel != null){
   nameController.text=model.userModel!.data?.name??'';
   emailController.text=model.userModel!.data?.email??'';
   phoneController.text=model.userModel!.data?.phone??'';
   print('mode; is not empty :::not null');
 }else{
   print('model is empty :::null');
 }
  return ConditionalBuilder(
    //
    condition:ShopCubit.get(context).userModel !=null  ,
    builder: (context)=> Padding(
      padding: const EdgeInsets.all(20.0),
      child: Form(
        key: formKey,
        child: Column(
          children: [
            if(state is ShopLoadingUpdateUserState)
               LinearProgressIndicator(),
            SizedBox(
              height: 20.0,
            ),
            defaultFormfield(
                controller: nameController,
                type: TextInputType.name,
                onChanged:(value){},

                onSubmit: (value){},
                validate: (value){
                  if(value!.isEmpty){
                    return 'name must not be empty';
                  }
                  return null;
                },
                label: 'Name',
                prefix: Icons.person),
            SizedBox(
              height: 20.0,
            ),
            defaultFormfield(
                controller: emailController,
                type: TextInputType.emailAddress,
                onChanged:(value){},

                onSubmit: (value){},
                validate: (value){
                  if(value!.isEmpty){
                    return 'email must not be empty';
                  }
                  return null;
                },
                label: 'Email',
                prefix: Icons.email_outlined),
            SizedBox(
              height: 20.0,
            ),
            defaultFormfield(
                controller: phoneController,
                type: TextInputType.phone,
                onChanged:(value){},

                onSubmit: (value){},
                validate: (value){
                  if(value!.isEmpty){
                    return 'phone must not be empty';
                  }
                  return null;
                },
                label: 'Phone',
                prefix: Icons.phone),
            SizedBox(
              height: 20.0,
            ),
            defaultButton(
                function: (){//logout
                  signOut(context:context);
                },
                text: 'Logout'),
            SizedBox(
              height: 20.0,
            ),
            defaultButton(
                function: (){//update
                  if(formKey.currentState!.validate()){
                    ShopCubit.get(context).updateUserData(
                        name: nameController.text,
                        email: emailController.text,
                        phone: phoneController.text);
                  }

                },
                text: 'Update'),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Image( image: AssetImage('assets/images/logo.png'), ),
              ),
            )

          ],
        ),
      ),
    ),
    fallback:(context)=>const Center(child: CircularProgressIndicator(),) ,
  );
    },
    );
  }
}
