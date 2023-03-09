import '../model/usermodel.dart';

class FirebaseService {
  static Future<UserModel?> getUserModelById(String uid) async {
    UserModel? userModel;



    // if(docSnap.data() != null) {
    //   userModel = UserModel.fromMap(docSnap.data() as Map<String, dynamic>);
    // }

    return userModel;
  }
}