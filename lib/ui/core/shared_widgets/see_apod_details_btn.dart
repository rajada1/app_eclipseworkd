import 'package:app_eclipseworkd/utils/helpers.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:url_launcher/url_launcher_string.dart';

class SeeApodDetailsBtn extends StatelessWidget {
  final String? date;
  const SeeApodDetailsBtn({super.key, required this.date});

  @override
  Widget build(BuildContext context) {
    return date != null
        ? FloatingActionButton.extended(
            onPressed: () {
              launchUrlString(
                  'https://apod.nasa.gov/apod/ap${date!.seeMoreApodUrlMake}.html');
            },
            label: Text('Ver mais na web'),
            icon: Icon(Symbols.travel_explore_rounded))
        : SizedBox.shrink();
  }
}
