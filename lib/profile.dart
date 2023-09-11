import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'edit_profile.dart';
import 'login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Profile_Screen extends StatefulWidget {
  const Profile_Screen({Key? key}) : super(key: key);

  @override
  _Profile_ScreenState createState() => _Profile_ScreenState();
}

class _Profile_ScreenState extends State<Profile_Screen> {

  late String name ='';
  late String contact = '';
  late String address = '';
  late String photoUrl = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFFFF4500),
        title: Text(
          "Profile",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
               SizedBox(height: 20,),
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("users-detail")
                    .doc(FirebaseAuth.instance.currentUser!.email)
                    .collection("detail")
                    .snapshots(),
                builder:(BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if(snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  } else {
                    snapshot.data!.docs.forEach((result) {
                      if (result["photoUrl"] != null) {
                        photoUrl = result["photoUrl"];
                      }
                    });
                    return Center(
                      child: CircleAvatar(
                        radius: 80,
                        backgroundColor: Colors.grey,
                        backgroundImage: photoUrl.isNotEmpty
                            ? Image.network(
                          photoUrl,
                          fit: BoxFit.cover,
                        ).image
                            : AssetImage('assets/default_profile_image.png'),
                      ),
                    );
                  }
                },
              ),
              SizedBox(height: 30,),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Material(
                  borderRadius: BorderRadius.circular(10),
                  elevation: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10, top: 15),
                        child: Text(
                          'Name',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),

                      Padding(
                        padding: const EdgeInsets.only(left: 10, bottom: 15),
                        child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection("users-detail")
                              .doc(FirebaseAuth.instance.currentUser!.email)
                              .collection("detail")
                              .snapshots(),
                          builder:(BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if(snapshot.connectionState == ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            } else {
                              snapshot.data!.docs.forEach((result) {
                                name = result["name"];
                              });
                              return Text(name,
                                style: TextStyle(
                                  fontSize: 23,
                                  fontWeight: FontWeight.bold,
                                ),);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 10,),

              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Material(
                  borderRadius: BorderRadius.circular(10),
                  elevation: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10, top: 15),
                        child: Text(
                          'Contact',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),

                      Padding(
                        padding: const EdgeInsets.only(left: 10, bottom: 15),
                        child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection("users-detail")
                              .doc(FirebaseAuth.instance.currentUser!.email)
                              .collection("detail")
                              .snapshots(),
                          builder:(BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if(snapshot.connectionState == ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            } else {
                              snapshot.data!.docs.forEach((result) {
                                contact = result["contact"];
                              });
                              return Text(contact,
                                style: TextStyle(
                                  fontSize: 23,
                                  fontWeight: FontWeight.bold,
                                ),);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 10,),

              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Material(
                  borderRadius: BorderRadius.circular(10),
                  elevation: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10, top: 15),
                        child: Text(
                          'Address',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.grey
                          ),
                        ),
                      ),
                      SizedBox(height: 10,),

                      Padding(
                        padding: const EdgeInsets.only(left: 10, bottom: 15),
                        child: StreamBuilder(
                          stream: FirebaseFirestore.instance
                              .collection("users-detail")
                              .doc(FirebaseAuth.instance.currentUser!.email)
                              .collection("detail")
                              .snapshots(),
                          builder:(BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if(snapshot.connectionState == ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            } else {
                              snapshot.data!.docs.forEach((result) {
                                address = result["address"];
                              });
                              return Text(address,
                                style: TextStyle(
                                  fontSize: 23,
                                  fontWeight: FontWeight.bold,
                                ),);
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 20,),

              Column(
                children: [
                  FloatingActionButton.extended(
                    label: Text('Edit Profile'),
                    backgroundColor: Color(0xFFFF4500),
                    icon: Icon(
                      Icons.edit,
                      size: 24.0,
                    ),
                    onPressed: () async {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (BuildContext ctx) =>  EditProfile()));
                    },
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  FloatingActionButton.extended(
                    label: Text('Log out'),
                    backgroundColor: Colors.black,
                    icon: Icon(
                      Icons.logout,
                      size: 24.0,
                    ),
                    onPressed: () async {
                      SharedPreferences prefs = await SharedPreferences.getInstance();
                      prefs.remove('email');
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: (BuildContext ctx) => Login_page()));
                    },
                  ),
                ],
              ),


            ]
        ),
      ),
    );
  }
}








