import 'dart:io';

import 'package:bex_it/data/local/cache/cache.dart';
import 'package:bex_it/features/profile/data/models/profile_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/di/di.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/toasts.dart';
import '../../../../core/state/view_state.dart';
import '../../../../data/remote/profile/profile_service.dart';
import '../../data/models/user_by_id_model.dart';

var profileService = getIt<ProfileService>();
var cache = getIt<Cache>();

class ProfileNotifier extends StateNotifier<ProfileState> {
  ProfileNotifier(this._read) : super(ProfileState.initial());

  final Reader _read;

  Future editProfileImage(File avatar) async {
    state = state.copyWith(viewState: ViewState.idle);
    try {
      state.copyWith(viewState: ViewState.loading);
      await profileService.editUserImage(await cache.getUserId(), avatar);
      Toasts.showSuccessToast("Profile Image has been uploaded successfully");
    } catch (e) {
      Toasts.showErrorToast(ErrorHelper.getLocalizedMessage(e));
    } finally {
      state = state.copyWith(viewState: ViewState.idle);
    }
  }
}

final getUserIdProvider = FutureProvider<UserById>((ref) async {
  final profile = await profileService.getUserById(await cache.getUserId());
  return profile;
});

final getProfileUser = FutureProvider<UserProfileResponse>((ref) async {
  final profile = await profileService.getUserProfile(await cache.getUserId());
  return profile;
});

class ProfileState {
  final ViewState viewState;

  const ProfileState._({required this.viewState});

  factory ProfileState.initial() => const ProfileState._(
        viewState: ViewState.idle,
      );

  ProfileState copyWith({ViewState? viewState}) => ProfileState._(
        viewState: viewState ?? this.viewState,
      );
}
