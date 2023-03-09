import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:notify/helperclass/HelperClass.dart';
import 'package:notify/model/usermodel.dart';

class FormProvider with ChangeNotifier{
  File? imageFile;
  TextEditingController fullNameController = TextEditingController();

  void selectImage(ImageSource source) async {
    XFile? pickedFile = await ImagePicker().pickImage(source: source);

    if(pickedFile != null) {
      imageFile = File(pickedFile.path);
    }
  }

  void showPhotoOptions(BuildContext context) {
    showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text("Upload Profile Picture"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [

            ListTile(
              onTap: () {
                Navigator.pop(context);
                selectImage(ImageSource.gallery);
              },
              leading: Icon(Icons.photo_album),
              title: Text("Select from Gallery"),
            ),

            ListTile(
              onTap: () {
                Navigator.pop(context);
                selectImage(ImageSource.camera);
              },
              leading: Icon(Icons.camera_alt),
              title: Text("Take a photo"),
            ),

          ],
        ),
      );
    });
  }

  void uploadData(BuildContext context) async {

    FirebaseAuth auth = FirebaseAuth.instance;

    UploadTask uploadTask = FirebaseStorage.instance.ref("profilepictures").child(auth.currentUser!.uid).putFile(imageFile!);

    TaskSnapshot snapshot = await uploadTask;

    String? imageUrl = await snapshot.ref.getDownloadURL();
    String? fullname = fullNameController.text.trim();


    UserModel userModel = UserModel(fullname: fullname,profilepic: imageUrl,uid: auth.currentUser!.uid);

    await FirebaseFirestore.instance.collection("users").doc(auth.currentUser!.uid).set(userModel.toMap()).then((value) {
      // log("Data uploaded!");
      Navigator.popUntil(context, (route) => route.isFirst);
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(builder: (context) {
      //     return HomePage(userModel: widget.userModel, firebaseUser: widget.firebaseUser);
      //   }),
      // );
    });
  }


}