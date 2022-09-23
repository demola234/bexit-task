import 'package:get_storage/get_storage.dart';

import '../../../core/network/base_api.dart';
import '../../../features/authentication/data/models/response.dart';
import '../../../features/authentication/data/models/user_model.dart';

abstract class AuthenticationRepository {
  Future<UserRequest> login(String email, String password);
  Future signup(String email, String password);
}

class AuthenticationRepositoryImpl extends BaseApi
    implements AuthenticationRepository {
  @override
  Future<UserRequest> login(
    String email,
    String password,
  ) async {
    var data = await post(
      "user/login-user",
      data: {
        "email": email,
        "password": password,
      },
    );
    final user = UserRequest.fromMap(data);
    return user;
  }

  @override
  Future signup(String email, String password) async {
    var data = await post("user/create-user", data: {
      "email": email,
      "password": password,
    });

    final user = Response.fromJson(data);
    return user;
  }
}
