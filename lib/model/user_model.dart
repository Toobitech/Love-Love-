import 'package:get/get_rx/src/rx_types/rx_types.dart';

class UserModel {
  int? id;
  String? firstName;
  String? lastName;
  String? age;
  String? gender;
  String? education;
  String? email;
  String? profileImage;
  int? professionalId;
  RxInt? isLogin;
  String? profession;
  String? description;
  String? createdAt;
  String? updatedAt;
  String? walletBalance;

  UserModel({
    this.id,
    this.firstName,
    this.lastName,
    this.age,
    this.gender,
    this.education,
    this.email,
    this.isLogin,
    this.profession,
    this.profileImage,
    this.professionalId,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.walletBalance,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      age: json['age'].toString(),
      gender: json['gender'],
      education: json['education'],
      email: json['email'],
      isLogin: RxInt(json['is_login'] ?? 0),
      profileImage: json['profile'],
      createdAt: json['created_at'],
      profession: json['profession']['name'],
      professionalId: json['professional_id'],
      walletBalance: json['wallet_balance'],
      description: json['about'],
      updatedAt: json['updated_at'],
    );
  }
  void updateIsLogin(int value) {
    isLogin!.value = value;
  }
}
