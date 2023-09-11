import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:recipe_app/dashboard_screen.dart';
import 'package:recipe_app/profile.dart';
import 'package:recipe_app/search.dart';
import 'add_image.dart';
import 'image_description.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';


class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFF4500),
        title: Center(child: Text('Recipetic')),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Navigate to the profile page
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Search_Screen()),
              );
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              child: Text(
                'Account Information',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              decoration: BoxDecoration(
                color: Color(0xFFFF4500),
              ),
            ),
            Card(
              elevation: 7,
              shadowColor: Colors.grey[900],
              child: ListTile(
                leading: Icon(Icons.person),
                title: Text('Profile'),
                onTap: () {
                  //Handle drawer item tap
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Profile_Screen()),
                  );
                },
              ),
            ),
            Card(
              elevation: 7,
              shadowColor: Colors.grey[900],
              child: ListTile(
                leading: Icon(Icons.call),
                title: Text('Help Center'),
                onTap: () {
                  FlutterPhoneDirectCaller.callNumber("01937153621");
                  // Handle drawer item tap
                },
              ),
            ),
            Card(
              elevation: 7,
              shadowColor: Colors.grey[900],
              child: ListTile(
                leading: Icon(Icons.dashboard),
                title: Text('Dashboard'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Dashboard_Screen()),
                  );
                  // Handle drawer item tap
                },
              ),
            )
            // Add more ListTiles for additional icons and titles
          ],
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('imageURLs').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            final documents = snapshot.data!.docs;
            return GridView.builder(
              itemCount: documents.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemBuilder: (context, index) {
                final imageURL = documents[index].get('url');
                final description = documents[index].get('description');

                return GestureDetector(
                  onTap: () {
                    // Navigate to the image description page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ImageDescriptionPage(
                          imageURL: imageURL,
                          description: description,
                        ),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(7.0),
                    child: Card(
                      elevation: 7, // Adjust the elevation value as needed
                      shadowColor: Colors.grey[900], // Adjust the shadow color as needed
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Container(
                        margin: EdgeInsets.all(3),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            placeholder: (context, url) =>
                                CircularProgressIndicator(),
                            imageUrl: imageURL,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(bottom: 2.0, left: 80, right: 80),
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => AddImage()),
            );
          },
          style: ElevatedButton.styleFrom(
            primary: Color(0xFFFF4500),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.image, color: Colors.black,),
              SizedBox(width: 9.0),
              Text('UPLOAD', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900,color: Colors.black),),
            ],
          ),
        ),
      ),
    );
  }
}
