//API

//post
//update
//delete

//get


//base url:
//method (url):
//queries :
//https://newsapi.org/v2/top-headlines?country=eg&category=business&apikey=ac87160118c7475da3eae48e82947852



import '../../modules/shop_app/login/shop_login_screen.dart';
import '../network/local/cashe_helper.dart';
import 'components.dart';

///search api
///https://newsapi.org/v2/everything?q=tesla&apiKey=ac87160118c7475da3eae48e82947852
void signOut({context}){
  //بيعمل clear token
  CasheHelper.removeData(key:'token')?.then((value){
    if(value==true){//اذا قيمتا ب ترو اي تم مسح الداتا روح وانهي عال llogin
      navigateAndFinish(context,ShopLoginScreen());
    }
  });
}
void printFullText( text){//تطبع مامل النص اذا كان طويل في console
  final pattern=RegExp('.{1,800}');
  pattern.allMatches(text).forEach((match) =>print(match.group(0)));

}
String token=CasheHelper.getData(key:'token');
String? uId=CasheHelper.getData(key:'uId');
// ;//مشان لما احيب التوكين بالابلطيشن في المين اسبفو فية