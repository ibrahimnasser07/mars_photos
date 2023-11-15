import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:hive/hive.dart';
import 'package:mars_photos/data/models/rover.dart';
import 'package:mars_photos/data/repo/repo.dart';
import 'package:mars_photos/ui/widgets/mars_photo_card.dart';

import '../../data/models/mars_photo.dart';
import '../../utils/constants.dart';
import '../widgets/home_drawer.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool dataReady = false;
  List<MarsPhoto> marsPhotos = [];

  @override
  void initState() {
    Repo().fetchCuriosityData().then((bool value) {
      dataReady = value;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final strings = AppLocalizations.of(context)!;
    final Rover rover = Hive.box<Rover>(roverDetailsKey).get(roverDetails)!;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          strings.appTitle,
          style: Theme.of(context).textTheme.displayLarge,
        ),
      ),
      drawer: const HomeDrawer(),
      body: !dataReady
          ? const Text("Loading")
          : Column(
              children: [
                ListTile(
                  title: Text(strings.date),
                  trailing: const Icon(Icons.calendar_month),
                  onTap: () async {
                    DateTime? date = await showDatePicker(
                      context: context,
                      initialDate: rover.maxDate,
                      firstDate: rover.landingDate,
                      lastDate: rover.maxDate,
                    );
                    marsPhotos =
                        await Repo().fetchDatePhotos(date ?? rover.maxDate);
                    setState(() {});
                  },
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: marsPhotos.length,
                    itemBuilder: (_, i) =>
                        MarsPhotoCard(marsPhoto: marsPhotos[i]),
                  ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Repo().fetchCuriosityData(),
        child: const Icon(Icons.webhook),
      ),
    );
  }
}
