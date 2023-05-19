class HomeModel{
late bool status;
late HomeDataModel data;
//name deconstruct

HomeModel.fromJson(Map<String,dynamic> json){

  status=json['status'];
  data= HomeDataModel.fromJson(json['data'])  ;//هيك عشان ابرس يلي حوا
}
}
class HomeDataModel{
  List<BannerModel> banners=[];
  List<ProductModel> products=[];

  HomeDataModel.fromJson(Map<String,dynamic> json){
    json['banners'].forEach((element){//بما انا ليست بدي املاها
      banners.add(BannerModel.fromJson(element));

    });
    json['products'].forEach((element){//بما انا ليست بدي املاها
      products.add(ProductModel.fromJson(element));

    });
    
  }
}
//بما انة كلاس اوف 2 اوبجيكت
class BannerModel{
  late int id;
  String? image;
  BannerModel.fromJson(Map<String,dynamic> json){
    id=json['id'];
    image=json['image'];
  }
}
class ProductModel{
  late int id;
  dynamic price;
  dynamic oldPrice;
  dynamic discount ;
  String ? image;
  String ? name;
  late bool inFavorites;
  late bool inCart;




  ProductModel.fromJson(Map<String,dynamic> json){
    id=json['id'];
    price=json['price'];
    oldPrice=json['old_price'];
    discount=json['discount'];
    image=json['image'];
    name=json['name'];
    inFavorites=json['in_favorites'];
    inCart=json['in_cart'];


  }
}