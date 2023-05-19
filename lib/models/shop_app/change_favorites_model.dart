class ChangeFavoritesModel{
  bool?  status;
  String? message;
//مناخد يلي محتاجينو
  ChangeFavoritesModel.fromJson(Map<String,dynamic>json){
    status=json['status'];
    message=json['message'];

  }
}