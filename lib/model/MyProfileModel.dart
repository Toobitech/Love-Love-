class MyProfileModel {
  bool? success;
  UserModelData? data;

  MyProfileModel({this.success, this.data});

  MyProfileModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data =
        json['data'] != null ? new UserModelData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class UserModelData {
  int? id;
  String? firstName;
  String? midName;
  String? lastName;
  String? preferredName;
  String? phone;
  int? age;
  String? education;
  String? gender;
  String? accountForId;
  String? email;
  var address;
  String? type;
  String? profile;
  String? city;
  String? country;
  int? status;
  var referenceLink;
  int? referenceId;
  String? description;
  String? about;
  int? verifiedByNumber;
  int? otp;
  var emailVerifiedAt;
  int? isBlock;
  var forgetPasswordCode;
  String? roleId;
  String? createdAt;
  String? updatedAt;
  String? lon;
  String? lat;
  int? automation;
  int? isMedicalCondition;
  List<Images>? images;
  List<UserIntrest>? userIntrest;
  List<UserMedicalCondition>? userMedicalCondition;

  UserModelData(
      {this.id,
      this.firstName,
      this.midName,
      this.lastName,
      this.preferredName,
      this.phone,
      this.age,
      this.education,
      this.gender,
      this.accountForId,
      this.email,
      this.address,
      this.type,
      this.profile,
      this.city,
      this.country,
      this.status,
      this.referenceLink,
      this.referenceId,
      this.description,
      this.about,
      this.verifiedByNumber,
      this.otp,
      this.emailVerifiedAt,
      this.isBlock,
      this.forgetPasswordCode,
      this.roleId,
      this.createdAt,
      this.updatedAt,
      this.lon,
      this.lat,
      this.automation,
      this.isMedicalCondition,
      this.images,
      this.userIntrest,
      this.userMedicalCondition});

  UserModelData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    midName = json['mid_name'];
    lastName = json['last_name'];
    preferredName = json['preferred_name'];
    phone = json['phone'];
    age = json['age'];
    education = json['education'];
    gender = json['gender'];
    accountForId = json['account_for_id'];
    email = json['email'];
    address = json['address'];
    type = json['type'];
    profile = json['profile'];
    city = json['city'];
    country = json['country'];
    status = json['status'];
    referenceLink = json['reference_link'];
    referenceId = json['reference_id'];
    description = json['description'];
    about = json['about'];
    verifiedByNumber = json['verified_by_number'];
    otp = json['otp'];
    emailVerifiedAt = json['email_verified_at'];
    isBlock = json['is_block'];
    forgetPasswordCode = json['forget_password_code'];
    roleId = json['role_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    lon = json['lon'];
    lat = json['lat'];
    automation = json['automation'];
    isMedicalCondition = json['is_medical_condition'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(new Images.fromJson(v));
      });
    }
    if (json['user_intrest'] != null) {
      userIntrest = <UserIntrest>[];
      json['user_intrest'].forEach((v) {
        userIntrest!.add(new UserIntrest.fromJson(v));
      });
    }
    if (json['user_medical_condition'] != null) {
      userMedicalCondition = <UserMedicalCondition>[];
      json['user_medical_condition'].forEach((v) {
        userMedicalCondition!.add(new UserMedicalCondition.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['first_name'] = firstName;
    data['mid_name'] = midName;
    data['last_name'] = lastName;
    data['preferred_name'] = preferredName;
    data['phone'] = phone;
    data['age'] = age;
    data['education'] = education;
    data['gender'] = gender;
    data['account_for_id'] = accountForId;
    data['email'] = email;
    data['address'] = address;
    data['type'] = type;
    data['profile'] = profile;
    data['city'] = city;
    data['country'] = country;
    data['status'] = status;
    data['reference_link'] = referenceLink;
    data['reference_id'] = referenceId;
    data['description'] = description;
    data['about'] = about;
    data['verified_by_number'] = verifiedByNumber;
    data['otp'] = otp;
    data['email_verified_at'] = emailVerifiedAt;
    data['is_block'] = isBlock;
    data['forget_password_code'] = forgetPasswordCode;
    data['role_id'] = roleId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['lon'] = lon;
    data['lat'] = lat;
    data['automation'] = automation;
    data['is_medical_condition'] = isMedicalCondition;
    if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
    }
    if (userIntrest != null) {
      data['user_intrest'] = userIntrest!.map((v) => v.toJson()).toList();
    }
    if (userMedicalCondition != null) {
      data['user_medical_condition'] =
          userMedicalCondition!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Images {
  int? id;
  int? userId;
  String? image;
  var status;
  String? createdAt;
  String? updatedAt;

  Images(
      {this.id,
      this.userId,
      this.image,
      this.status,
      this.createdAt,
      this.updatedAt});

  Images.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    image = json['image'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['user_id'] = userId;
    data['image'] = image;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class UserIntrest {
  int? intrestId;
  int? userId;
  Intrest? intrest;

  UserIntrest({this.intrestId, this.userId, this.intrest});

  UserIntrest.fromJson(Map<String, dynamic> json) {
    intrestId = json['intrest_id'];
    userId = json['user_id'];
    intrest =
        json['intrest'] != null ? new Intrest.fromJson(json['intrest']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['intrest_id'] = intrestId;
    data['user_id'] = userId;
    if (intrest != null) {
      data['intrest'] = intrest!.toJson();
    }
    return data;
  }
}

class Intrest {
  int? id;
  String? name;

  Intrest({this.id, this.name});

  Intrest.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

class UserMedicalCondition {
  int? medicalConditionId;
  int? userId;
  Intrest? medicalCondition;

  UserMedicalCondition(
      {this.medicalConditionId, this.userId, this.medicalCondition});

  UserMedicalCondition.fromJson(Map<String, dynamic> json) {
    medicalConditionId = json['medical_condition_id'];
    userId = json['user_id'];
    medicalCondition = json['medical_condition'] != null
        ? new Intrest.fromJson(json['medical_condition'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['medical_condition_id'] = medicalConditionId;
    data['user_id'] = userId;
    if (medicalCondition != null) {
      data['medical_condition'] = medicalCondition!.toJson();
    }
    return data;
  }
}
