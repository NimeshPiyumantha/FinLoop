import 'package:finloop/globals.dart';
import 'package:finloop/l10n/gen/app_localizations.dart';
import 'package:finloop/routes.dart';
import 'package:finloop/services/theme/theme_manager.dart';
import 'package:finloop/theme/theme_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class FinLoopView extends StatefulWidget {
  final ThemeManager themeManager;

  const FinLoopView({super.key, required this.themeManager});

  @override
  State<FinLoopView> createState() => _FinLoopViewState();
}

class _FinLoopViewState extends State<FinLoopView> {
  final LogicContextThemeManager _themeLogic = LogicContextThemeManager();

  @override
  void initState() {
    super.initState();
    widget.themeManager.addListener(_themeListener);
  }

  @override
  void dispose() {
    widget.themeManager.removeListener(_themeListener);
    super.dispose();
  }

  void _themeListener() {
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FinLoop',
      navigatorKey: globalNavigatorKey,
      initialRoute: '/splash',
      debugShowCheckedModeBanner: false,
      onGenerateRoute: RouteGenerator.generateRoute,

      theme: _themeLogic.lightTheme,
      darkTheme: _themeLogic.darkTheme,
      themeMode: widget.themeManager.themeMode,

      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    );
  }
}
