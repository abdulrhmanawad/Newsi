import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:newsi/Controler/CatagoryNews.dart';
import 'package:newsi/Controler/Networking.dart';
import 'package:newsi/model/Articalmodel.dart';
import 'package:newsi/model/CatagoryName.dart';
import 'package:newsi/views/CatagoryScreen.dart';
import 'package:newsi/views/webviewScreen.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Catagory> Cata = List<Catagory>();
  List<ArticalModel> articales = List<ArticalModel>();
  bool _loading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Cata = getCatagory();
    getArticals();
  }

  getArticals() async {
      Network network = Network();
      await network.getNews();
      articales = network.articals;
      setState(() {
        _loading = false;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
            child: Container(
                child: Column(
                  children: [
                    Container(
                      height: 70,
                      child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: Cata.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return CardTile(
                              CatogryName: Cata[index].name,
                              imgurl: Cata[index].imgUrl,
                            );
                          }),
                    ),
                    Container(
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
                    )
                  ],
                ),
              ),
          ),
    );
  }
}

class CardTile extends StatelessWidget {
  final String imgurl, CatogryName;
  CardTile({this.CatogryName, this.imgurl});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return CatagoryScreen(catagory: CatogryName.toLowerCase(),);
        }));
      },
      child: Container(
        margin: EdgeInsets.all(5),
        height: 80,
        width: 120,
        child: Stack(
          fit: StackFit.expand,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  imgurl,
                  fit: BoxFit.cover,
                )),
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(color: Colors.black45),
                  child: Text(
                    CatogryName,
                    style: TextStyle(color: Colors.white),
                  )),
            )
          ],
        ),
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
