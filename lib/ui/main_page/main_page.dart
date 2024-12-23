import 'package:app_eclipseworkd/app_module.dart';
import 'package:app_eclipseworkd/ui/core/themes/change_theme_widget.dart';
import 'package:app_eclipseworkd/utils/error_indicator.dart';
import 'package:app_eclipseworkd/utils/result.dart';
import 'package:app_eclipseworkd/ui/main_page/view_model/main_view_models.dart';
import 'package:app_eclipseworkd/ui/main_page/widgets/filter_bar.dart';
import 'package:app_eclipseworkd/ui/core/shared_widgets/list_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class MainPage extends StatelessWidget {
  MainPage({super.key});

  final viewModel = Modular.get<MainViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Imagem do dia'),
        actions: [ChangeThemeWidget()],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Modular.to.pushNamed(AppRoutes.favorites);
        },
        label: Text('Ver Favoritos'),
        icon: Icon(
          Icons.favorite,
          color: Colors.red,
        ),
      ),
      body: ListView(
        children: [
          FilterBarWidget(),
          ListenableBuilder(
            listenable: viewModel.load,
            builder: (context, _) {
              if (viewModel.load.running) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: const Center(child: CircularProgressIndicator()),
                );
              }
              if (viewModel.load.error) {
                final error = viewModel.load.result as Error;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: ErrorIndicator(
                        title: '${error.error}',
                        label: 'Tente novamente',
                        onPressed: () {
                          viewModel.load.execute(false);
                        }),
                  ),
                );
              }
              return ListenableBuilder(
                  listenable: viewModel,
                  builder: (_, child) {
                    return ListView.builder(
                      padding: EdgeInsets.only(bottom: 100),
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: viewModel.apod?.length ?? 0,
                      itemBuilder: (context, index) {
                        final item = viewModel.apod![index];
                        return ListTileWidget(
                          mode:
                              item.isFavorite ? ItemMode.remove : ItemMode.add,
                          item: item,
                          onRemove: () {
                            viewModel.removeFavorite.execute(item);
                          },
                          onSave: () {
                            viewModel.saveFavorite.execute(item);
                          },
                        );
                      },
                    );
                  });
            },
          )
        ],
      ),
    );
  }
}
