import 'dart:convert';

class Response {
  Response({
    required this.status,
    required this.userId,
    required this.message,
  });

  String status;
  String userId;
  String message;

  factory Response.fromRawJson(String str) =>
      Response.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Response.fromJson(Map<String, dynamic> json) => Response(
        status: json["status"],
        userId: json["userId"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "userId": userId,
        "message": message,
      };
}
