class ShopLoadingModel{//call in cubit for get data and fill it
  late bool status ;
  late String? message;
   UserData? data;
  ShopLoadingModel.fromJson(Map<String,dynamic> json){

    status=json['status'];
    message=json['message'];
    //اذا رجع null  اي الحاللة false رج يرجع null والا رح بوصل للملاس الناتي ويطبع المعلومات يعني نحنا منستخدم هيالمهلةمات بتاطريقة بلي بدما ياها
    data=json['data'] !=null ? UserData.fromJson(json['data']) : null; //لو هو مش ب null استخدم هاد


  }
}

class UserData{

  late int id;
 late  String name;
  late String email;
  late  String phone;
  late String image;
  late int? points;
  late int? credit;
  late String token;
//   UserData({
//     this.id,
//     this.name,
//     this.email,
//     this.phone,
//     this.image,
//     this.points,
//     this.credit,
//     this.token,
//
// });
  //named constructor //بعمل 2 باني كل واحد بيشتغل شغلة
UserData.fromJson(Map<String,dynamic> json){

id=json['id'];
name=json['name'];
email=json['email'];
phone=json['phone'];
image=json['image'];
points=json['points'];
credit=json['credit'];
token=json['token'];

}
}


