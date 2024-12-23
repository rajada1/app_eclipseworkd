import 'package:app_eclipseworkd/utils/error_indicator.dart';
import 'package:app_eclipseworkd/utils/result.dart';
import 'package:app_eclipseworkd/ui/favorites_page/view_model/favorite_view_model.dart';
import 'package:app_eclipseworkd/ui/core/shared_widgets/list_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  final viewModel = Modular.get<ApodFavoritesViewModel>();

  @override
  void initState() {
    viewModel.load.execute();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favoritos'),
      ),
      body: ListView(
        children: [
          ListenableBuilder(
            listenable: viewModel.load,
            builder: (context, _) {
              if (viewModel.load.running) {
                return const Center(child: CircularProgressIndicator());
              }
              if (viewModel.load.error) {
                final error = viewModel.load.result as Error;
                return Center(
                  child: ErrorIndicator(
                      title: '${error.error}',
                      label: 'Tente novamente',
                      onPressed: () {
                        viewModel.load.execute();
                      }),
                );
              }
              return viewModel.apod!.isEmpty
                  ? Center(
                      child: Text('Você ainda não tem nenhum favorito'),
                    )
                  : Column(
                      children: viewModel.apod?.map((item) {
                            return ListTileWidget(
                              onRemove: () async {
                                await viewModel.removeFavorite.execute(item);
                                viewModel.load.execute();
                              },
                              item: item,
                              mode: ItemMode.remove,
                            );
                          }).toList() ??
                          []);
            },
          )
        ],
      ),
    );
  }
}
