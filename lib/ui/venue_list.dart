import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:privilee_challenge/top_level_providers.dart';
import 'package:shimmer/shimmer.dart';

import '../models/venue.dart';
import '../widgets/empty_list_layout.dart';

/* 
  Venue list basically shows all the venues according
  to the banner that's visible. It automatically updates
  the list if the banner is changed.
 */
class VenueList extends ConsumerWidget {
  const VenueList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Consumer(builder: (context, ref, _) {
      List<Venue> filteredVenues =
          ref.watch(homeProvider.select((value) => value.filteredVenues));

      if (filteredVenues.isEmpty) {
        return const EmptyListLayout();
      }

      return Padding(
        padding: const EdgeInsets.only(top: 16, left: 16, right: 16),
        child: ListView.builder(
            itemCount: filteredVenues.length,
            itemBuilder: (context, index) {
              return _listItem(filteredVenues, index, context);
            }),
      );
    });
  }

  Widget _listItem(
      List<Venue> filteredVenues, int index, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _image(filteredVenues, index),
          const SizedBox(width: 8),
          _titleAndLocation(filteredVenues, index, context)
        ],
      ),
    );
  }

  Widget _titleAndLocation(
      List<Venue> filteredVenues, int index, BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            filteredVenues[index].name,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
          ),
          Text(filteredVenues[index].locationName),
        ],
      ),
    );
  }

  Widget _image(List<Venue> filteredVenues, int index) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.network(filteredVenues[index].images.first,
          height: 70,
          width: 70,
          fit: BoxFit.cover, loadingBuilder: (BuildContext context,
              Widget child, ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) return child;

        return SizedBox(
       
          child: Shimmer.fromColors(
            baseColor: Colors.grey.shade300,
            highlightColor: Colors.grey.shade100,
            child: Container(
              width: 70,
              height: 70,
              color: Colors.grey,
            ),
          ),
        );
      }),
    );
  }
}
