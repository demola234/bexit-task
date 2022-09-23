import 'package:get_storage/get_storage.dart';

import '../../../core/di/di.dart';
import '../../../core/error/exceptions.dart';
import '../../../features/authentication/data/models/user_model.dart';

abstract class Cache {
  Future<UserRequest> getUser();
  Future<String> getToken();
  Future<String> getUserId();
  Future clear();
  Future saveUser(UserRequest user);
  Future saveUserId(String user);
  Future saveToken(String token);

  static Cache get() => getIt<Cache>();
}

class CacheImpl implements Cache {
  final box = GetStorage();

  @override
  Future clear() async {
    box.remove('user');
    box.remove('token');
  }

  @override
  Future<String> getToken() async {
    if (box.hasData("token")) {
      return box.read("token");
    }
    return "";
  }

  @override
  Future<String> getUserId() async {
    if (box.hasData("userId")) {
      return box.read("userId");
    }
    return "";
  }

  @override
  Future<UserRequest> getUser() async {
    var token = await getToken();
    if (token.isEmpty) {
      throw CustomException("Something went wrong");
    }
    return UserRequest.fromMap(box.read("user"));
  }

  @override
  Future saveToken(String token) {
    return box.write('token', token);
  }

  @override
  Future saveUser(UserRequest user) {
    return box.write('user', user.toMap());
  }

  @override
  Future saveUserId(String userId) {
    return box.write('userId', userId);
  }
}
