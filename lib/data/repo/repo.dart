import 'package:flutter/foundation.dart';
import 'package:mars_photos/data/api/api.dart';
import 'package:mars_photos/data/models/mars_photo.dart';

class Repo {
  late API _api;

  Repo(){
    _api = API();
  }

  Future<List<MarsPhoto>> fetchLatestPhotos() async {
    final data = await _api.fetchLatestPhotos();
    final photos = data.map((photoMap) => MarsPhoto.fromJson(photoMap)).toList();
    return photos;
  }
}