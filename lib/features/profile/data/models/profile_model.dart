import 'dart:convert';

class UserProfileResponse {
  UserProfileResponse({
    required this.status,
    required this.message,
    required this.numberOfBusiness,
    required this.numberOfProducts,
    required this.numberOfServices,
  });

  String status;
  String message;
  int numberOfBusiness;
  int numberOfProducts;
  int numberOfServices;

  factory UserProfileResponse.fromRawJson(String str) =>
      UserProfileResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserProfileResponse.fromJson(Map<String, dynamic> json) => UserProfileResponse(
        status: json["status"],
        message: json["message"],
        numberOfBusiness: json["numberOfBusiness"],
        numberOfProducts: json["numberOfProducts"],
        numberOfServices: json["numberOfServices"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "numberOfBusiness": numberOfBusiness,
        "numberOfProducts": numberOfProducts,
        "numberOfServices": numberOfServices,
      };
}
