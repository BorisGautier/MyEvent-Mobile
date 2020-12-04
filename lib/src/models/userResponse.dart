class UserResponse {
  bool success;
  Data data;
  String message;

  UserResponse({this.success, this.data, this.message});

  UserResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  String token;
  User user;

  Data({this.token, this.user});

  Data.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    if (this.user != null) {
      data['user'] = this.user.toJson();
    }
    return data;
  }
}

class User {
  int id;
  String name;
  String email;
  String emailVerifiedAt;
  int nbreEvent;
  int telephone;
  String fcmToken;
  String token;
  String tokenSecret;
  String nomForfait;
  int passRestant;
  String platform;
  String currentTeamId;
  String profilePhotoPath;
  String createdAt;
  String updatedAt;
  String profilePhotoUrl;

  User(
      {this.id,
      this.name,
      this.email,
      this.emailVerifiedAt,
      this.nbreEvent,
      this.telephone,
      this.fcmToken,
      this.token,
      this.tokenSecret,
      this.nomForfait,
      this.passRestant,
      this.platform,
      this.currentTeamId,
      this.profilePhotoPath,
      this.createdAt,
      this.updatedAt,
      this.profilePhotoUrl});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    nbreEvent = json['nbreEvent'];
    telephone = json['telephone'];
    fcmToken = json['fcmToken'];
    token = json['token'];
    tokenSecret = json['tokenSecret'];
    nomForfait = json['nomForfait'];
    passRestant = json['passRestant'];
    platform = json['platform'];
    currentTeamId = json['current_team_id'];
    profilePhotoPath = json['profile_photo_path'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    profilePhotoUrl = json['profile_photo_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['nbreEvent'] = this.nbreEvent;
    data['telephone'] = this.telephone;
    data['fcmToken'] = this.fcmToken;
    data['token'] = this.token;
    data['tokenSecret'] = this.tokenSecret;
    data['nomForfait'] = this.nomForfait;
    data['passRestant'] = this.passRestant;
    data['platform'] = this.platform;
    data['current_team_id'] = this.currentTeamId;
    data['profile_photo_path'] = this.profilePhotoPath;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['profile_photo_url'] = this.profilePhotoUrl;
    return data;
  }
}
