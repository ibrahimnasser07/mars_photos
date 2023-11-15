import 'package:hive/hive.dart';
import 'package:mars_photos/utils/constants.dart';

import '../models/mars_photo.dart';

Box<MarsPhoto> marsPhotosBox = Hive.box<MarsPhoto>(marsPhotosKey);

void savePhotosList(List<MarsPhoto> photos) {
  for (MarsPhoto photo in photos) {
    final MarsPhoto? localPhoto = marsPhotosBox.get(photo.id);
    if (localPhoto != photo) {
      marsPhotosBox.put(photo.id, photo);
    }
  }
}

List<MarsPhoto> fetchDatePhotosFromDB(DateTime date) {
  return marsPhotosBox.values
      .where((MarsPhoto photo) => photo.earthDate == date)
      .toList();
}
