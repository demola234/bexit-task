import 'package:bex_it/data/remote/profile/profile_repository.dart';
import 'package:bex_it/data/remote/profile/profile_service.dart';
import 'package:get_it/get_it.dart';

import '../../data/local/cache/cache.dart';
import '../../data/remote/authentication/authentication_repositoty.dart';
import '../../data/remote/authentication/authentication_service.dart';

final GetIt getIt = GetIt.I;

Future<void> injector() async {
  ///Authentication
  getIt.registerLazySingleton<AuthenticationRepository>(
      () => AuthenticationRepositoryImpl());
  getIt.registerLazySingleton<AuthenticationService>(
      () => AuthenticationServiceImpl(authRepository: getIt(), cache: getIt()));

  ///Profile
  getIt.registerLazySingleton<ProfileRepository>(() => ProfileRepositoryImpl());
  getIt.registerLazySingleton<ProfileService>(
      () => ProfileServiceImpl(profileRepository: getIt(), cache: getIt()));

  ///cache
  getIt.registerLazySingleton<Cache>(() => CacheImpl());
}
