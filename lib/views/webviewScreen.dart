import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
class ArticalScreen extends StatefulWidget {
  final String Url;
  ArticalScreen({@required this.Url});
  @override
  _ArticalScreenState createState() => _ArticalScreenState();
}

class _ArticalScreenState extends State<ArticalScreen> {
  Completer<WebViewController> _completer=Completer<WebViewController>();
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
        body: Container(
      child: WebView(
        initialUrl: widget.Url,
        onWebViewCreated: (WebViewController webviewControler){
          _completer.complete(webviewControler);
        },
      ),
    ));
  }
}
