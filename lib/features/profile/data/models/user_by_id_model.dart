import 'dart:convert';

class UserById {
  UserById({
    required this.status,
    required this.message,
    required this.user,
  });

  String status;
  String message;
  User user;

  factory UserById.fromRawJson(String str) =>
      UserById.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserById.fromJson(Map<String, dynamic> json) => UserById(
        status: json["status"],
        message: json["message"],
        user: User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "user": user.toJson(),
      };
}

class User {
  User({
    required this.status,
    required this.emailNotif,
    required this.verified,
    required this.email,
    required this.createdAt,
    required this.updatedAt,
    required this.wallet,
    required this.avatar,
    required this.id,
  });

  bool status;
  bool emailNotif;
  bool verified;
  String email;
  DateTime createdAt;
  DateTime updatedAt;
  String wallet;
  String avatar;
  String id;

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
        status: json["status"],
        emailNotif: json["emailNotif"],
        verified: json["verified"],
        email: json["email"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        wallet: json["wallet"],
        avatar: json["avatar"],
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "emailNotif": emailNotif,
        "verified": verified,
        "email": email,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "wallet": wallet,
        "avatar": avatar,
        "id": id,
      };
}
