import 'package:app_eclipseworkd/domain/models/apod_model.dart';
import 'package:app_eclipseworkd/ui/core/shared_widgets/see_apod_details_btn.dart';
import 'package:app_eclipseworkd/utils/helpers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:photo_view/photo_view.dart';

class ImageView extends StatefulWidget {
  final ApodModel item;

  const ImageView({super.key, required this.item});

  @override
  State<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends State<ImageView>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  ValueNotifier<bool> hide = ValueNotifier(false);
  void textHideUpdate(PhotoViewScaleState photoState) {
    hide.value = photoState != PhotoViewScaleState.initial;
  }

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: 700.ms);

    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    hide.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detalhes da imagem')),
      floatingActionButton: SeeApodDetailsBtn(
        date: widget.item.date,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                child: SizedBox(
                  width: double.infinity,
                  height: MediaQuery.sizeOf(context).height / 2,
                  child: PhotoView(
                    imageProvider: CachedNetworkImageProvider(widget.item.url!),
                    scaleStateChangedCallback: textHideUpdate,
                  ),
                ),
              ),
              SizedBox(height: 10),
              ValueListenableBuilder(
                  valueListenable: hide,
                  builder: (_, value, __) {
                    !value
                        ? _animationController.forward()
                        : _animationController.reverse();
                    return Column(
                      children: [
                        Text(
                          '${widget.item.title} - ${widget.item.date}',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        SizedBox(height: 10),
                        Text(
                          '${widget.item.explanation}',
                        )
                      ],
                    ).animate(
                        controller: _animationController,
                        effects: [FadeEffect()]);
                  }),
              SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}
