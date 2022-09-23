import 'package:bex_it/features/authentication/presentation/views/login/login.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/di/di.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/toasts.dart';
import '../../../../core/state/view_state.dart';
import '../../../../core/utils/navigation_service.dart';
import '../../../../data/local/cache/cache.dart';
import '../../../../data/remote/authentication/authentication_service.dart';
import '../../../profile/presentation/views/profile.dart';
import '../../data/models/user_model.dart';

class LoginNotifier extends StateNotifier<LoginState> {
  var authService = getIt<AuthenticationService>();
  var cache = getIt<Cache>();
  LoginNotifier(this._read) : super(LoginState.initial());

  // ignore: unused_field
  final Reader _read;

  Future<void> login(String email, String password) async {
    state = state.copyWith(viewState: ViewState.loading);
    try {
      await authService.login(email, password);
      NavigationService().replaceScreen(Profile());
    } catch (e) {
      print(e);
      Toasts.showErrorToast(ErrorHelper.getLocalizedMessage(e));
    } finally {
      state = state.copyWith(viewState: ViewState.idle);
    }
  }

  Future<void> createAccount(String email, String password) async {
    state = state.copyWith(viewState: ViewState.loading);
    try {
      await authService.signup(email, password);
      NavigationService().replaceScreen(Login());
    } catch (e) {
      print(e);
      Toasts.showErrorToast(ErrorHelper.getLocalizedMessage(e));
    } finally {
      state = state.copyWith(viewState: ViewState.idle);
    }
  }

  Future<UserRequest> getUserFromCache() async {
    var usr = await cache.getUser();
    return usr;
  }
}

class LoginState {
  final ViewState viewState;
  final bool passwordVisible;

  const LoginState._({required this.viewState, required this.passwordVisible});

  factory LoginState.initial() => const LoginState._(
        viewState: ViewState.idle,
        passwordVisible: false,
      );

  LoginState copyWith({ViewState? viewState, bool? passwordVisible}) =>
      LoginState._(
        viewState: viewState ?? this.viewState,
        passwordVisible: passwordVisible ?? this.passwordVisible,
      );
}
