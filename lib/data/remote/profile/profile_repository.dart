import 'dart:io';

import 'package:bex_it/features/profile/data/models/user_by_id_model.dart';
import 'package:dio/dio.dart';

import '../../../core/error/exceptions.dart';
import '../../../core/network/base_api.dart';
import '../../../features/profile/data/models/profile_model.dart';

abstract class ProfileRepository {
  Future<UserById> getUserById(String token, {String userId});
  Future<UserProfileResponse> getUserProfile(String token, {String userId});
  Future editUserImage(String token, {String userId, File avatar});
}

class ProfileRepositoryImpl extends BaseApi implements ProfileRepository {
  @override
  Future editUserImage(String token, {String? userId, File? avatar}) async {
    var data = <String, dynamic>{
      "userId": userId,
    };
    try {
      data["avatar"] = await MultipartFile.fromFile(avatar!.path,
          filename:
              "profile${avatar.path.split(".").last}.${avatar.path.split(".").last}");

      final v = await post("user/edit-profile-avatar",
          headers: getHeader(token), formData: FormData.fromMap(data));
      print(v);
    } catch (err) {
      if (err is RequestException) {
        throw CustomException(err.message);
      }
      print(err);
      throw CustomException("Something went wrong");
    }
  }

  @override
  Future<UserById> getUserById(String token, {String? userId}) async {
    var data = await post("user/user-profile-by-id",
        data: {
          "userId": userId,
        },
        headers: getHeader(token));
    try {
      final userResponse = UserById.fromJson(data);
      return userResponse;
    } catch (err) {
      if (err is RequestException) {
        throw CustomException(err.message);
      }

      throw CustomException("Something went wrong");
    }
  }

  @override
  Future<UserProfileResponse> getUserProfile(String token,
      {String? userId}) async {
    var data = await get("user/user-profie-data?userId=$userId",
        headers: getHeader(token));
    try {
      final userResponse = UserProfileResponse.fromJson(data);
      return userResponse;
    } catch (err) {
      if (err is RequestException) {
        throw CustomException(err.message);
      }

      throw CustomException("Something went wrong");
    }
  }
}
