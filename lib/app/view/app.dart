import 'package:bex_it/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:overlay_support/overlay_support.dart';

import '../../core/utils/navigation_service.dart';
import '../../features/authentication/presentation/views/logger/logger.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return OverlaySupport.global(
        child: MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      navigatorKey: NavigationService().navigationKey,
      debugShowCheckedModeBanner: false,
      home: LoggerScreen(),
    ));
  }
}
