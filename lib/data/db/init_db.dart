import 'package:hive_flutter/adapters.dart';
import 'package:mars_photos/data/models/mars_photo.dart';

import '../../utils/constants.dart';

Future<void> initDB() async {
  await Hive.initFlutter();

  Hive.registerAdapter(CameraAdapter());
  Hive.registerAdapter(MarsPhotoAdapter());

  await Hive.openBox(settingsKey);
  await Hive.openBox<MarsPhoto>(marsPhotosKey);
}