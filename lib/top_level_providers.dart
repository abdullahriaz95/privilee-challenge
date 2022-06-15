import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:privilee_challenge/providers/home_provider.dart';

/* 
  This file contains all the top level providers. This is
  basically the implementation of Rivepod. We get these
  providers from within a widget with the help of WidgetRef.
 */

final homeProvider = ChangeNotifierProvider<HomeProvider>((ref) {
  return HomeProvider();
});
