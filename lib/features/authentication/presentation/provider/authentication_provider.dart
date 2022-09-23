import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/di/di.dart';
import '../../../../data/remote/authentication/authentication_service.dart';
import '../controllers/authentication_controller.dart';

var authService = getIt<AuthenticationService>();
late bool loading;

final authenticationNotifierProvider =
    StateNotifierProvider<LoginNotifier, LoginState>(
        (ref) => LoginNotifier(ref.read));
