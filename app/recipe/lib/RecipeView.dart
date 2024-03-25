
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';


class RecipeView extends StatefulWidget {


String url;
RecipeView(this.url);

  @override
  State<RecipeView> createState() => _RecipeViewState();
}

class _RecipeViewState extends State<RecipeView> {
  late String finalUrl; //to convert http to https

  final Completer<WebViewController> controller = Completer<WebViewController>();

  @override
  void initState() {
    if(widget.url.toString().contains("http://"))
      {
        finalUrl = widget.url.toString().replaceAll("http://", "https://");
      }
    else{
      finalUrl = widget.url;
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Flutter Food Recipe App"),
      ),
      body: Container(
        child: WebView(
          initialUrl: finalUrl,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController){
            setState(() {
              controller.complete(webViewController);
            });
          },
        ),
      ),



    );
  }
}
