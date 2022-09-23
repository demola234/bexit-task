import 'package:bex_it/features/authentication/data/models/user_model.dart';
import 'package:bex_it/features/authentication/presentation/views/login/login.dart';
import 'package:bex_it/features/profile/presentation/views/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../provider/authentication_provider.dart';

class LoggerScreen extends ConsumerWidget {
  LoggerScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, ref) {
    return Scaffold(
        body: FutureBuilder<UserRequest>(
      future:
          ref.watch(authenticationNotifierProvider.notifier).getUserFromCache(),
      builder: (context, snapshot) {
        if (snapshot.hasData ||
            snapshot.connectionState == ConnectionState.done) {
          if (snapshot.data == null) {
            return Login();
          } else {
            return Profile();
          }
        }
        return Center(
          child: CircularProgressIndicator(
            color: Colors.white,
          ),
        );
      },
    ));
  }
}
