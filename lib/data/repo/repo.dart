import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:intl/intl.dart';
import 'package:mars_photos/data/api/api.dart';
import 'package:mars_photos/data/models/mars_photo.dart';

import '../db/db_functions.dart';

class Repo {
  late API _api;

  Repo(){
    _api = API();
  }

  Future<List<MarsPhoto>> fetchLatestPhotos() async {
    final data = await _api.fetchLatestPhotos();
    final photos = data.map((photoMap) => MarsPhoto.fromJson(photoMap)).toList();
    savePhotosList(photos);
    return photos;
  }

  Future<List<MarsPhoto>> fetchDatePhotos(DateTime earthDate) async {
    bool online = await InternetConnectionChecker().hasConnection;
    if(online == true) {
      final formattedDate = DateFormat("yyyy-MM-dd").format(earthDate);
      final data = await _api.fetchDatePhotos(formattedDate);
      final photos = data.map((photoMap) => MarsPhoto.fromJson(photoMap)).toList();
      savePhotosList(photos);
      return photos;
    } else {
      return fetchDatePhotos(earthDate);
    }

  }
}