import '../../../features/authentication/data/models/response.dart';
import '../../../features/authentication/data/models/user_model.dart';

import '../../local/cache/cache.dart';
import 'authentication_repositoty.dart';

abstract class AuthenticationService {
  Future<UserRequest> login(String email, String password);
  Future signup(String email, String password);
}

class AuthenticationServiceImpl extends AuthenticationService {
  AuthenticationRepository authRepository;
  Cache cache;

  AuthenticationServiceImpl(
      {required this.authRepository, required this.cache});

  @override
  Future<UserRequest> login(String email, String password) async {
    var response = await authRepository.login(email, password);
    print("Response=>>> ${response.token.toString()}");
    cache.saveUser(response);
    cache.saveToken(response.token);
    cache.saveUserId(response.user.id);
    return response;
  }

  @override
  Future signup(String email, String password) async {
    var response = await authRepository.signup(email, password);
    return response;
  }
}
