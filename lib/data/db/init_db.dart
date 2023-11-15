import 'package:hive_flutter/adapters.dart';
import 'package:mars_photos/data/models/mars_photo.dart';
import 'package:mars_photos/data/models/rover.dart';

import '../../utils/constants.dart';

Future<void> initDB() async {
  await Hive.initFlutter();

  Hive.registerAdapter(CameraAdapter());
  Hive.registerAdapter(MarsPhotoAdapter());
  Hive.registerAdapter(RoverAdapter());
  Hive.registerAdapter(RoverCameraAdapter());

  await Hive.openBox(settingsKey);
  await Hive.openBox<MarsPhoto>(marsPhotosKey);
  await Hive.openBox<Rover>(roverDetailsKey);
}