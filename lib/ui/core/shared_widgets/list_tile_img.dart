import 'package:app_eclipseworkd/utils/helpers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:app_eclipseworkd/domain/models/apod_model.dart';

class LeadingImgListTile extends StatelessWidget {
  final ApodModel item;
  const LeadingImgListTile({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    return !item.mediaType.isVideo && item.url.isImageUrl
        ? CachedNetworkImage(
            imageUrl: item.url!,
            cacheKey: item.url!,
            height: 50,
            width: 50,
          )
        : item.mediaType.isVideo && item.url.isImageUrl
            ? CachedNetworkImage(
                imageUrl: item.thumb!,
                cacheKey: item.thumb!,
                height: 50,
                width: 50,
                errorWidget: (context, url, error) {
                  return Icon(
                    Icons.image_not_supported_rounded,
                    size: 40,
                  );
                },
              )
            : Icon(
                Icons.image_not_supported_rounded,
                size: 40,
                color: Colors.red[100],
              );
  }
}
