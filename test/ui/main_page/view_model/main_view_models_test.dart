import 'package:app_eclipseworkd/app_module.dart';
import 'package:app_eclipseworkd/data/services/apod_api.dart';
import 'package:app_eclipseworkd/data/shared_preferences_service.dart';
import 'package:app_eclipseworkd/ui/favorites_page/view_model/favorite_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:app_eclipseworkd/ui/main_page/view_model/main_view_models.dart';
import 'package:app_eclipseworkd/domain/models/apod_model.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:app_eclipseworkd/utils/result.dart';
import 'package:mocktail/mocktail.dart';

class MockApodApi extends Mock implements ApodApi {}

class MockSharedPreferencesService extends Mock
    implements SharedPreferencesService {}

final apodList = [
  ApodModel(
      thumb: '',
      date: '',
      explanation: '',
      hdurl: '',
      mediaType: '',
      serviceVersion: '',
      title: '',
      url: ''),
];
void main() {
  final mockApodApi = MockApodApi();
  final mockSharedPreferencesService = MockSharedPreferencesService();
  setUp(
    () {
      when(() => mockApodApi.getApod(any()))
          .thenAnswer((_) async => Result.ok(apodList));
      when(() => mockSharedPreferencesService.getFavotiresRawData())
          .thenAnswer((_) async => Result.ok(apodList));
      Modular.bindModule(AppModule());
    },
  );

  Modular.replaceInstance<ApodApi>(mockApodApi);
  Modular.replaceInstance<SharedPreferencesService>(
      mockSharedPreferencesService);

  test('Carrega uma lista de ApodModel', () async {
    var viewModel = Modular.get<MainViewModel>();
    await viewModel.load.execute(false);
    expect(viewModel.apod, isA<List<ApodModel>>());
    expect(viewModel.apod, apodList);
  });

  test('Lida com erro ao carregar lista de ApodModel', () async {
    when(() => mockApodApi.getApod(any())).thenAnswer(
        (_) async => Result.error(Exception('Erro ao carregar dados')));

    var viewModel = Modular.get<MainViewModel>();
    await viewModel.load.execute(false);
    expect(viewModel.load.error, true);
  });

  test('Adiciona um ApodModel aos favoritos', () async {
    var viewModel = Modular.get<MainViewModel>();
    var favoriteModel = Modular.get<ApodFavoritesViewModel>();
    await viewModel.saveFavorite.execute(apodList.first);
    await favoriteModel.load.execute();
    expect(favoriteModel.apod?.contains(apodList.first), true);
  });
}
