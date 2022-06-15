import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:privilee_challenge/top_level_providers.dart';
import 'package:privilee_challenge/ui/banner_layout.dart';
import 'package:privilee_challenge/ui/venue_list.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/* 
  User come here in Homepage when start the app. It is then 
  divided into two parts. The top banner layout, and the venue 
  list below it.
 */

class HomePage extends ConsumerWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.privilee_chanllenge),
      ),
      body: Consumer(builder: (context, ref, _) {
        bool isLoading = ref.watch(homeProvider).isLoading;
        if (isLoading) {
          return const Center(
            child: CircularProgressIndicator.adaptive(),
          );
        }
        return Column(
          children: const [
            BannerLayout(),
            Expanded(
              child: VenueList(),
            ),
          ],
        );
      }),
    );
  }
}
