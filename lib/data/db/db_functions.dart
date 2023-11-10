import 'package:hive/hive.dart';
import 'package:mars_photos/utils/constants.dart';

import '../models/mars_photo.dart';

void savePhotosList(List<MarsPhoto> photos) {
  for (MarsPhoto photo in photos) {
    final MarsPhoto localPhoto = Hive.box(marsPhotosKey).get(photo.id);
    if (localPhoto != photo) {
      Hive.box(marsPhotosKey).put(photo.id, photo);
    }
  }
}

List<MarsPhoto> fetchDatePhotos(DateTime date) {
  return Hive.box<MarsPhoto>(marsPhotosKey)
      .values
      .where((MarsPhoto photo) => photo.earthDate == date)
      .toList();
}
