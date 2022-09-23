import 'package:bex_it/features/profile/presentation/controller/profile_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/di/di.dart';
import '../../../../data/remote/profile/profile_service.dart';

var profileService = getIt<ProfileService>();
late bool loading;

final profileNotifierProvider =
    StateNotifierProvider<ProfileNotifier, ProfileState>(
        (ref) => ProfileNotifier(ref.read));
