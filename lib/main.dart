import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:mars_photos/ui/screens/home.dart';
import 'package:mars_photos/utils/app_router.dart';
import 'package:mars_photos/utils/color_schemes.g.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mars_photos/utils/typography.dart';
import 'package:sizer/sizer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  await Hive.openBox("settings");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: Hive.box("settings").listenable(),
        builder: (_, box, __) {
          final bool isDark =
              Hive.box("settings").get("isDark", defaultValue: false);
          final String lang =
              Hive.box("settings").get("lang", defaultValue: "en");
          return Sizer(
            builder: (context, orientation, deviceType) {
              return MaterialApp.router(
                title: "app title",
                localizationsDelegates: AppLocalizations.localizationsDelegates,
                supportedLocales: AppLocalizations.supportedLocales,
                locale: Locale(lang),
                theme: ThemeData(
                  colorScheme: lightColorScheme,
                  useMaterial3: true,
                  textTheme: textTheme,
                ),
                darkTheme: ThemeData(
                  colorScheme: darkColorScheme,
                  useMaterial3: true,
                  textTheme: textTheme,
                ),
                themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
                routerConfig: router(),
              );
            }
          );
        });
  }
}
