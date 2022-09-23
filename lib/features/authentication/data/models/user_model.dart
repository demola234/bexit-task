import 'dart:convert';

class UserRequest {
  UserRequest({
    required this.user,
    required this.token,
    required this.status,
    required this.message,
  });

  final User user;
  final String token;
  final String status;
  final String message;


  factory UserRequest.fromMap(Map<String, dynamic> json) => UserRequest(
        user: User.fromMap(json["user"]),
        token: json["token"],
        status: json["status"],
        message: json["message"],
      );

  Map<String, dynamic> toMap() => {
        "user": user.toMap(),
        "token": token,
        "status": status,
        "message": message,
      };
}

class User {
  User({
    required this.email,
    required this.id,
  });

  final String email;
  final String id;

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
        email: json["email"],
        id: json["id"],
      );

  Map<String, dynamic> toMap() => {
        "email": email,
        "id": id,
      };
}
