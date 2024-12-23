import 'package:app_eclipseworkd/data/services/apod_api.dart';
import 'package:app_eclipseworkd/utils/command.dart';
import 'package:app_eclipseworkd/utils/result.dart';
import 'package:app_eclipseworkd/ui/favorites_page/view_model/favorite_view_model.dart';
import 'package:app_eclipseworkd/domain/models/apod_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class MainViewModel extends ChangeNotifier {
  final ApodApi _repository = Modular.get<ApodApi>();
  final ApodFavoritesViewModel _favoritesViewModel =
      Modular.get<ApodFavoritesViewModel>();

  List<ApodModel>? _apod;
  List<ApodModel>? get apod => _apod;

  DateTimeRange dateFilter =
      DateTimeRange(start: DateTime.now(), end: DateTime.now());
  set dateFilterSet(DateTimeRange value) {
    dateFilter = value;
  }

  late Command1<void, bool> load;
  late Command1<void, DateTimeRange> setDateFilter;
  late Command1<void, ApodModel> saveFavorite;
  late Command1<void, ApodModel> removeFavorite;

  MainViewModel() {
    load = Command1<void, bool>(_load)..execute(false);
    setDateFilter = Command1<void, DateTimeRange>(_setDateFilter);
    saveFavorite = Command1<void, ApodModel>(_saveFavorite);
    removeFavorite = Command1<void, ApodModel>(_removeFavorite);
    _favoritesViewModel.removeFavorite.addListener(_unsetFavorites);
  }

  Future<Result<void>> _setDateFilter(DateTimeRange value) async {
    dateFilter = value;
    return Ok<void>(null);
  }

  Future<Result> _saveFavorite(final ApodModel value) async {
    try {
      value.isFavorite = true;
      await _favoritesViewModel.saveFavorite.execute(value);
      await _favoritesViewModel.load.execute();
      return Ok(value);
    } catch (e) {
      return Error(Exception('Erro ao salvar favorito'));
    } finally {
      notifyListeners();
    }
  }

  Future<Result> _removeFavorite(final ApodModel value) async {
    try {
      value.isFavorite = false;
      await _favoritesViewModel.removeFavorite.execute(value);
      await _favoritesViewModel.load.execute();
      return Ok(value);
    } catch (e) {
      return Error(Exception('Erro ao salvar favorito'));
    } finally {
      notifyListeners();
    }
  }

  Future<Result> _load(final bool fakeError) async {
    try {
      if (fakeError) {
        return Result.error(Exception('FakeError'));
      }
      final apodResult = await _repository.getApod(dateFilter);

      switch (apodResult) {
        case Ok<List<ApodModel>>():
          _apod = apodResult.value;
          _setFavorites();
          debugPrint('Apod Carregado');
        case Error<List<ApodModel>>():
          debugPrint('Error Carregar Apod');
      }
      return apodResult;
    } catch (erro) {
      return Result.error(
          Exception('Erro Desconhecido, Tente novamente em alguns minutos'));
    } finally {
      notifyListeners();
    }
  }

  void _setFavorites() {
    final favoriteDates = _favoritesViewModel.apodId?.toSet();
    if (favoriteDates != null && apod != null) {
      for (var element in apod!) {
        element.isFavorite = favoriteDates.contains(element.date);
      }
    }
    notifyListeners();
  }

  void _unsetFavorites() {
    final favoriteDates = _favoritesViewModel.apodId?.toSet();
    if (favoriteDates != null && apod != null) {
      for (var element in apod!) {
        if (element.isFavorite) {
          element.isFavorite = favoriteDates.contains(element.date);
        }
      }
    }
    notifyListeners();
  }
}
