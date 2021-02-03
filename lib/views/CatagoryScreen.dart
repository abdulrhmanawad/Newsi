import 'package:flutter/material.dart';
import 'package:newsi/Controler/CatagryNetworking.dart';
import 'package:newsi/model/Articalmodel.dart';
import 'package:newsi/views/webviewScreen.dart';

class CatagoryScreen extends StatefulWidget {
  String catagory;
  CatagoryScreen({@required this.catagory});
  @override
  _CatagoryScreenState createState() => _CatagoryScreenState();
}

class _CatagoryScreenState extends State<CatagoryScreen> {
  List<ArticalModel> articales = List<ArticalModel>();
  bool _loading = true;
  @override
  void initState() {
 getArticals();
    super.initState();
  }
  getArticals() async{
    NetworkCatagory network = NetworkCatagory();
    await network.getNews(widget.catagory);
    articales = network.articals;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [Icon(Icons.satellite,color: Colors.white,),SizedBox(width: 40,)],
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'News',
              style: TextStyle(fontSize: 24.0),
            ),
            Text(
              'i',
              style: TextStyle(
                  color: Colors.blue,
                  fontSize: 32,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
      body: _loading?  Center(child: CircularProgressIndicator()):Container(
        width: MediaQuery.of(context).size.width,
        height:MediaQuery.of(context).size.height,
        child: ListView.builder(
            physics: ClampingScrollPhysics(),
            itemCount: articales.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return ArticalTial(
                imgurl: articales[index].urlToImage,
                title: articales[index].title,
                desc: articales[index].description,
                url: articales[index].url,
              );
            }),
      ),
    );
  }
}
class ArticalTial extends StatelessWidget {
  final String imgurl;
  final String title;
  final String desc;
  final String url;
  ArticalTial(
      {@required this.imgurl, @required this.title, @required this.desc,this.url});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context,MaterialPageRoute(builder: (context){
          return ArticalScreen(Url: url,);
        })
        );
      },
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network("$imgurl")),
            Text("$title",style: TextStyle(color: Colors.black87,fontSize: 24),),
            Text("$desc",style: TextStyle(color: Colors.grey[700],fontSize: 14)),
            SizedBox(height: 8,),
            Divider(
              thickness: 1.5,
              color: Colors.grey,
            )
          ],
        ),
      ),
    );
  }
}
