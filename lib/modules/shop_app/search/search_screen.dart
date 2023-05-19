
import 'package:ecommerce/modules/shop_app/search/cubit/states.dart';
import 'package:ecommerce/shared/components/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/cubit.dart';

class SearchScreen extends StatelessWidget {
  var formKey=GlobalKey<FormState>();
  var searchController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=> SearchCubit(),
      child: BlocConsumer<SearchCubit,SearchState>(
        listener:(context,state){} ,
        builder:(context,state){
          return Scaffold(
            appBar: AppBar(

            ),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    defaultFormfield(
                        controller: searchController,
                        type: TextInputType.text,
                        onChanged: (value){},
                        onSubmit: (text){
                          SearchCubit.get(context).search(text);

                        },
                        validate: (value){
                          if(value!.isEmpty){
                            return 'this field most not be empty';
                          }
                          return null ;
                        },
                        label: 'Search ',
                        prefix: Icons.search),
                    SizedBox(
                      height: 10.0,
                    ),

                    if(state is SearchLoadingState)
                       LinearProgressIndicator(),
                    SizedBox(
                      height: 10.0,
                    ),
                    if(state is SearchSuccessState)
                    Expanded(
                      child: ListView.separated(
                          itemBuilder: (context , index)=> buildListPruduct(SearchCubit.get(context).model!.data!.data![index],context,isOldPrice: false),
                          separatorBuilder: (context,index)=> myDivider(),
                          itemCount: SearchCubit.get(context).model!.data!.data!.length),
                    ),
                  ],
                ),
              ),
            ),
          );
        } ,
      ),
    );
  }
}
