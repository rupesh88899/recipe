import 'dart:ffi';

class RecipeModel
{
  late String applable;
  late String appimgUrl;
  late double appcalories;
  late String appurl;

  //constructor
  RecipeModel({this.applable = "LABEL",this.appimgUrl = "IMAGE",this.appcalories = 0.000,this.appurl = "URL"});
  factory RecipeModel.fromMap(Map recipe)
  {
    return RecipeModel(
      applable: recipe["label"],
      appcalories: recipe["calories"],
      appimgUrl: recipe["image"],
      appurl: recipe["url"]
    );
  }
}