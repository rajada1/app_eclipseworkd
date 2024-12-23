import 'package:animations/animations.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:app_eclipseworkd/utils/helpers.dart';
import 'package:app_eclipseworkd/domain/models/apod_model.dart';
import 'package:app_eclipseworkd/ui/core/shared_widgets/image_view.dart';
import 'package:app_eclipseworkd/ui/core/shared_widgets/video_player.dart';

class ListTileWidget extends StatelessWidget {
  final ApodModel item;
  final void Function()? onRemove;
  final void Function()? onSave;
  final ItemMode mode;

  const ListTileWidget({
    super.key,
    required this.item,
    this.onSave,
    this.onRemove,
    required this.mode,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: OpenContainer(
        closedColor: Theme.of(context).cardColor,
        closedElevation: 2,
        openElevation: 5,
        closedBuilder: (context, action) {
          return ListTile(
            onTap: action,
            trailing: mode == ItemMode.add
                ? IconButton(
                    onPressed: onSave,
                    icon: Icon(
                      Icons.favorite_border_sharp,
                      color: Colors.redAccent,
                    ))
                : IconButton(
                    onPressed: onRemove,
                    icon: Icon(
                      Icons.favorite_sharp,
                      color: Colors.redAccent,
                    )),
            leading: item.mediaType.isVideo
                ? CachedNetworkImage(
                    imageUrl: item.thumb!,
                    cacheKey: item.thumb!,
                    height: 50,
                    width: 50,
                  )
                : CachedNetworkImage(
                    imageUrl: item.url!,
                    cacheKey: item.url!,
                    height: 50,
                    width: 50,
                  ),
            title: Text(item.title ?? ''),
            subtitle: Text(item.mediaType.toCapitalized),
          );
        },
        openBuilder: (context, action) {
          return item.mediaType.isVideo
              ? YoutubeVideoPlayer(item: item)
              : ImageView(item: item);
        },
      ),
    );
  }
}

enum ItemMode {
  remove,
  add,
}
