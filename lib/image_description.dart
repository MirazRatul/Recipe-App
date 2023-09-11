import 'package:flutter/material.dart';

class ImageDescriptionPage extends StatelessWidget {
  final String imageURL;
  final String description;

  ImageDescriptionPage({required this.imageURL, required this.description});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFF4500),
        title: Text('Image Description'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          //crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.all(16),
              child: Card(
                elevation: 10,
                shadowColor: Colors.grey[900],
                child: Image.network(
                  imageURL,
                  width: 300,
                  height: 300,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(16),
              child: Text(
                description,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
