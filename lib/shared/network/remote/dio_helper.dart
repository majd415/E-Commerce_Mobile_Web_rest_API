import 'package:dio/dio.dart';
//news app
class DioHelper1{

  static Dio dio1= Dio() ;
  static init(){
    dio1=Dio(//for create dio
      BaseOptions(
        baseUrl:  'https://newsapi.org/'    ,//' https://newsapi.org///'C:/Users/majd hamoud/AndroidStudioProjects/first_app/assets/text',//'https://newsapi.org/',
        receiveDataWhenStatusError: true,
      ),
    );
  }
static Future<Response> getData({
  required String url,
  required Map<String,dynamic>? query,
})async{

   return await dio1.get(url,queryParameters: query,);
}


}
//shop app
class DioHelper{
//https://student.valuxapps.com/api/
  static late Dio dio ;
  static init(){
    dio=Dio(//for create dio
      BaseOptions(

        //https://student.valuxapps.com/api/algazzar24@gmail.comal
        baseUrl: 'https://student.valuxapps.com/api/',

        receiveDataWhenStatusError: true,
        // headers: {//الثوابت من ال api غي البوسمان
        //   'Content-Type':'application/json',
        //
        // }

      ),
    );
  }
  static Future<Response> getData({
    required String url,
     Map<String,dynamic>? query,
    String lang ='en',
    String? token ,
  })async{
    dio.options.headers={
      'Content-Type':'application/json',
      'lang':lang,
      'Authorization':token??'',
    };
    return await dio.get(url,queryParameters: query,);
  }

static Future<Response> postData({
  required String url,
   Map<String,dynamic>? query,
  required Map<String,dynamic>? data,
  String lang ='en',
  String? token ,//مو الكل محتاج توكين مثلا ال لوغ و التسحيل مش محتاجين

})async{
    dio.options.headers={//لان ال baseOptions  بياخدا مرة وحدة هون منزود علية override
     //المتغيرات في ال api
      'Content-Type':'application/json',
            'lang':lang,
            'Authorization':token??'',


    };
    return  dio.post(url,
    queryParameters: query,//الكويري مو شرط تنبعت
    data: data,//بس data لازم تنبعت رح ودي وجيب
    );
}
 // static Future<void> gettestdio()async{
 //   var dio = Dio();
 //   var response = await dio.get('profile');
 //   print(response.data.toString());
 // }

//put data for update
  static Future<Response> putData({
    required String url,
    Map<String,dynamic>? query,
    required Map<String,dynamic>? data,
    String lang ='en',
    String? token ,//مو الكل محتاج توكين مثلا ال لوغ و التسحيل مش محتاجين

  })async{
    dio.options.headers={//لان ال baseOptions  بياخدا مرة وحدة هون منزود علية override
      //المتغيرات في ال api
      'Content-Type':'application/json',
      'lang':lang,
      'Authorization':token??'',


    };
    return  dio.put(url,
      queryParameters: query,//الكويري مو شرط تنبعت
      data: data,//بس data لازم تنبعت رح ودي وجيب
    );
  }
}
//put data for update
