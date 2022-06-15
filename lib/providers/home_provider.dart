import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/banner.dart' as b;
import '../models/venue.dart';

/* 
  HomeProvider handles all the logic and data
  for homepage.
 */

class HomeProvider extends ChangeNotifier {
  /// used to show the loader while data is loading
  bool isLoading = false;

  /// list of banners loaded from the data (json file in this case)
  List<b.Banner> listBanners = [];

  /// list of venues loaded from the data (json file in this case)
  List<Venue> listVenues = [];

  /// list of filtered Venues, this list will update according to the banner
  List<Venue> filteredVenues = [];

  /// currenlty selected banner index
  int selectedBannerIndex = 0;

  HomeProvider() {
    init();
  }

  /// this method initializes everything. It displays loader
  /// while it gathers all the data (banners and venues) from
  /// json files in assets.
  init() async {
    isLoading = true;
    notifyListeners();

    await _getBanners();
    await _getVenues();
    _filterFirstTime();

    isLoading = false;
    notifyListeners();
  }

  /// Get all the banners from banner.json in assets
  _getBanners() async {
    String bannerStr = await rootBundle.loadString('assets/banner.json');
    listBanners = b.bannerFromJson(bannerStr);
  }

  /// Get all the banners from venues.json in assets
  _getVenues() async {
    String venueStr = await rootBundle.loadString('assets/venues.json');
    listVenues = venueFromJson(venueStr);
  }

  /// updates the venue list upon banner changed
  bannerChanged(int index) {
    filteredVenues.clear();
    selectedBannerIndex = index;
    String currentBanner = listBanners[index].type;
    filteredVenues =
        listVenues.where((element) => element.type == currentBanner).toList();
    notifyListeners();
  }

  /// updates the venue list for the first time
  _filterFirstTime() {
    bannerChanged(0); // for the first time, index is always going to be zero
    notifyListeners();
  }
}
