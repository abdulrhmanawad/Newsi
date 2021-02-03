import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:newsi/model/Articalmodel.dart';
class Network{
  List<ArticalModel> articals=[];
  Future<void> getNews() async{
    String BaseUrl="http://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=49892551c0044891972b7acc76cab1e1";
    http.Response response= await http.get(BaseUrl);
    print(response.body);
    var jsondata=jsonDecode(response.body);
if(jsondata["status"]=="ok"){
  jsondata["articles"].forEach((element){
if(element["urlToImage"]!=null && element["description"]!=null){
  ArticalModel articalModel=ArticalModel(
    author: element["author"],
    title: element["title"],
    urlToImage: element["urlToImage"],
    url: element["url"]
      ,description: element['description']

  );
  print(articalModel.title);
  articals.add(articalModel) ;
}

  });
}

  }
}