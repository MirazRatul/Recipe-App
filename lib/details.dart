import 'package:flutter/material.dart';

class Detail_Page extends StatefulWidget {
  const Detail_Page({Key? key}) : super(key: key);

  @override
  State<Detail_Page> createState() => _Detail_PageState();
}

class _Detail_PageState extends State<Detail_Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFF4500),
        title: Text("Food Detail",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
      ),
      body: Center(
        child: Container(
          height: 200,
          width: 200,
          child: Text("Welcome to detail page", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
        ),
      ),
    );
  }
}
