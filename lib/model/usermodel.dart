class UserModel {
  String? uid;
  String? fullname;
  String? profilepic;

  UserModel({this.uid, this.fullname, this.profilepic});

  UserModel.fromMap(Map<String, dynamic> map) {
    uid = map["uid"];
    fullname = map["fullname"];
    profilepic = map["profilepic"];
  }

  Map<String, dynamic> toMap() {
    return {
      "uid": uid,
      "fullname": fullname,
      "profilepic": profilepic,
    };
  }
}