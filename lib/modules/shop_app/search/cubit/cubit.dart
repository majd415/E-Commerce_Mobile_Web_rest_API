
import 'package:ecommerce/models/shop_app/search_model.dart';
import 'package:ecommerce/modules/shop_app/search/cubit/states.dart';
import 'package:ecommerce/shared/network/local/cashe_helper.dart';
import 'package:ecommerce/shared/network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../shared/network/end_points.dart';

class SearchCubit extends Cubit<SearchState>{
  SearchCubit():super(SearchInitialState());

  static SearchCubit get(context)=> BlocProvider.of(context);
  SearchModel? model;
  void search(String text){
    emit(SearchLoadingState());

    DioHelper.postData(url: SEARCH, data: {
      'text':text,

    },
    token:CasheHelper.getToken(),
    ).then((value) {
      model=SearchModel.fromJson(value.data);
      emit(SearchSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(SearchErrorState());


    });
  }
}