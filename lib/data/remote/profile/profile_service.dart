import 'dart:io';

import 'package:bex_it/data/remote/profile/profile_repository.dart';

import '../../../features/profile/data/models/profile_model.dart';
import '../../../features/profile/data/models/user_by_id_model.dart';
import '../../local/cache/cache.dart';

abstract class ProfileService {
  Future<UserById> getUserById(String userId);
  Future<UserProfileResponse> getUserProfile(String userId);
  Future editUserImage(String userId, File avatar);
}

class ProfileServiceImpl extends ProfileService {
  ProfileRepository profileRepository;
  Cache cache;
  ProfileServiceImpl({required this.profileRepository, required this.cache});

  @override
  Future editUserImage(String userId, File avatar) async {
    return profileRepository.editUserImage(await cache.getToken(),
        userId: userId, avatar: avatar);
  }

  @override
  Future<UserById> getUserById(String userId) async {
    return profileRepository.getUserById(await cache.getToken(),
        userId: userId);
  }

  @override
  Future<UserProfileResponse> getUserProfile(String userId) async {
    return profileRepository.getUserProfile(await cache.getToken(),
        userId: userId);
  }
}
