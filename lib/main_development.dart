import 'package:bex_it/app/app.dart';
import 'package:bex_it/bootstrap.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_storage/get_storage.dart';

import 'core/di/di.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  bootstrap(() => ProviderScope(child: const App()));
  await injector();
  await GetStorage.init();
}
