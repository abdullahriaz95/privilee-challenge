import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:privilee_challenge/top_level_providers.dart';
import 'package:shimmer/shimmer.dart';

import '../models/banner.dart' as b;

/* 
  This file contains the top header of the homepage.
  Which shows the banner images in a pageview and indicator
  dots to show where the user is at the moment.
 */

class BannerLayout extends ConsumerWidget {
  const BannerLayout({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Consumer(builder: (context, ref, _) {
      List<b.Banner> listBanners =
          ref.watch(homeProvider.select((value) => value.listBanners));
      if (listBanners.isEmpty) {
        return  Text(AppLocalizations.of(context)!.no_items_to_show);
      }
      return _bannerPageView(context, listBanners, ref);
    });
  }

  Widget _bannerPageView(
      BuildContext context, List<b.Banner> listBanners, WidgetRef ref) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.3,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          _pageView(listBanners, ref),
          _pageIndicators(),
        ],
      ),
    );
  }

  Widget _pageIndicators() {
    return Consumer(builder: (context, ref, _) {
      int selectedBannerIndex =
          ref.watch(homeProvider.select((value) => value.selectedBannerIndex));
      List<Widget> listIndicatorDots = [];
      List<b.Banner> listBanners = ref.read(homeProvider).listBanners;
      for (int i = 0; i < listBanners.length; i++) {
        listIndicatorDots.add(
          _indicatorDot(isSelected: i == selectedBannerIndex),
        );
      }

      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: listIndicatorDots,
        ),
      );
    });
  }

  Widget _indicatorDot({bool isSelected = false}) {
    return Container(
      height: 12,
      width: 12,
      margin: const EdgeInsets.symmetric(horizontal: 3),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: isSelected ? Colors.orange : Colors.white,
      ),
    );
  }

  Widget _pageView(List<b.Banner> listBanners, WidgetRef ref) {
    return PageView.builder(
        allowImplicitScrolling: true,
        itemCount: listBanners.length,
        onPageChanged: (i) {
          ref.read(homeProvider).bannerChanged(i);
        },
        itemBuilder: (context, index) {
          return _listItem(listBanners, index);
        });
  }

  Widget _listItem(List<b.Banner> listBanners, int index) {
    return Image.network(listBanners[index].image, fit: BoxFit.cover,
        loadingBuilder: (BuildContext context, Widget child,
            ImageChunkEvent? loadingProgress) {
      if (loadingProgress == null) return child;

      return SizedBox(
        child: Shimmer.fromColors(
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade100,
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.3,
            color: Colors.grey,
          ),
        ),
      );
    });
  }
}
