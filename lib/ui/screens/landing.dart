import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive/hive.dart';
import 'package:mars_photos/utils/router_constants.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../data/models/rover.dart';
import '../../utils/constants.dart';
import '../widgets/home_drawer.dart';

class Landing extends StatelessWidget {
  const Landing({super.key});

  @override
  Widget build(BuildContext context) {
    final Rover rover = Hive.box<Rover>(roverDetailsKey).get(roverDetails)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.appTitle),
      ),
      drawer: const HomeDrawer(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox(width: double.infinity),
          FilledButton(
            onPressed: () => context.push(home),
            child: Text("Latest Photos"),
          ),
          FilledButton(
            onPressed: () async {
              await showDatePicker(
                context: context,
                initialDate: rover.maxDate,
                firstDate: rover.landingDate,
                lastDate: rover.maxDate,
              ).then((date) {
                if(date != null){
                  context.push(home,extra: date);
                }
              });
            },
            child: Text("Date Photos"),
          ),
        ],
      ),
    );
  }
}
