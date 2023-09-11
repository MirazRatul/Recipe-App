import 'dart:io';
import 'package:path/path.dart' as Path;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class AddImage extends StatefulWidget {
  const AddImage({Key? key}) : super(key: key);

  @override
  State<AddImage> createState() => _AddImageState();
}

class _AddImageState extends State<AddImage> {
  bool uploading = false;
  double val = 0;
  late CollectionReference imgRef;
  late firebase_storage.Reference ref;
  List<File> _image = [];
  final TextEditingController _descriptionController = TextEditingController();

  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFFF4500),
        title: Padding(
          padding: const EdgeInsets.only(left: 80.0),
          child: Text(
            "Add Image",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Stack(
        children: [
          GridView.builder(
            itemCount: _image.length + 1,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
            itemBuilder: (context, index) {
              if (index == 0) {
                return Center(
                  child: IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () => !uploading ? chooseImage() : null,
                  ),
                );
              } else {
                final selectedImage = _image[index - 1];
                return Stack(
                  children: [
                    Container(
                      margin: EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: FileImage(selectedImage),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: IconButton(
                        icon: Icon(Icons.remove_circle),
                        onPressed: () {
                          removeImage(index - 1);
                        },
                      ),
                    ),
                  ],
                );
              }
            },
          ),
          uploading
              ? Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  child: Text(
                    'Uploading...',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                SizedBox(height: 10),
                CircularProgressIndicator(
                  value: val,
                  valueColor:
                  AlwaysStoppedAnimation<Color>(Colors.green),
                ),
              ],
            ),
          )
              : Container(),
        ],
      ),
    );
  }

  chooseImage() async {
    final pickedFile =
    await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image.add(File(pickedFile.path));
      });

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Image Description'),
            content: TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                hintText: 'Enter description',
              ),
            ),
            actions: [
              TextButton(
                child: Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              ElevatedButton(
                child: Text('Upload'),
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    uploading = true;
                  });
                  uploadFile().whenComplete(() {
                    setState(() {
                      uploading = false;
                    });
                  });
                },
              ),
            ],
          );
        },
      );
    }
  }

  void removeImage(int index) {
    setState(() {
      _image.removeAt(index);
    });
  }

  Future<void> uploadFile() async {
    for (var img in _image) {
      setState(() {
        val = 0;
      });

      String imageName = Path.basename(img.path);
      ref = firebase_storage.FirebaseStorage.instance
          .ref()
          .child('images/$imageName');

      firebase_storage.UploadTask uploadTask = ref.putFile(img);
      uploadTask.snapshotEvents
          .listen((firebase_storage.TaskSnapshot snapshot) {
        setState(() {
          val = snapshot.bytesTransferred / snapshot.totalBytes;
        });
      });

      await uploadTask.whenComplete(() async {
        String downloadURL = await ref.getDownloadURL();
        String description = _descriptionController.text;

        await FirebaseFirestore.instance.collection('imageURLs').add({
          'url': downloadURL,
          'description': description,
        });
      });
    }
  }
}
