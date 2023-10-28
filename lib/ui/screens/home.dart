import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../utils/router_constants.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    final settingsBox = Hive.box("settings");
    return Scaffold(
      appBar: AppBar(
        title: Text(
          strings.appTitle,
          style: Theme.of(context).textTheme.displayLarge,
        ),
      ),
      drawer: Drawer(
        child: ListView(
          shrinkWrap: true,
          children: [
            ListTile(
              title: Text(strings.theme),
              trailing: Switch(
                value: settingsBox.get("isDark", defaultValue: false),
                onChanged: (v) => settingsBox.put("isDark", v),
              ),
            ),
            ListTile(
              title: Text(strings.language),
              trailing: DropdownButton(
                items: <String>["en", "ar"]
                    .map(
                      (e) => DropdownMenuItem(
                        value: e,
                        child: Text(e == "ar" ? "Arabic" : "English"),
                      ),
                    )
                    .toList(),
                onChanged: (v) => settingsBox.put("lang", v!),
              ),
            ),
          ],
        ),
      ),
      body: Center(
        child: FilledButton(
          onPressed: () => context.push(settingsPath),
          child: Text("Settings"),
        ),
      ),
    );
  }
}
