import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/* 
  A simple empty list layout.
 */
class EmptyListLayout extends StatelessWidget {
  const EmptyListLayout({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40.0),
      child: Column(
        children: [
          Image.asset(
            'assets/icons/shock.png',
            height: 50,
            width: 50,
          ),
          const SizedBox(height: 16),
          Text(
            AppLocalizations.of(context)!.you_have_got_nothing,
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
