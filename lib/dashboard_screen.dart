import 'package:flutter/material.dart';

class Dashboard_Screen extends StatefulWidget {
  const Dashboard_Screen({Key? key}) : super(key: key);

  @override
  State<Dashboard_Screen> createState() => _Dashboard_ScreenState();
}

class _Dashboard_ScreenState extends State<Dashboard_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16),
        children: [
          // My Recipes Overview
          ListTile(
            title: Text('My Recipes Overview', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            subtitle: Text('Total: 10 recipes'),
            onTap: () {
              // Navigate to the user's recipes screen
            },
          ),
          Divider(),

          // Favorite Recipes
          ListTile(
            title: Text('Favorite Recipes', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            onTap: () {
              // Navigate to the favorite recipes screen
            },
          ),
          Divider(),

          // Trending Recipes
          ListTile(
            title: Text('Trending Recipes', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            onTap: () {
              // Navigate to the trending recipes screen
            },
          ),
        ],
      ),
    );
  }
}
