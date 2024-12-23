import 'package:app_eclipseworkd/data/shared_preferences_service.dart';
import 'package:app_eclipseworkd/utils/command.dart';
import 'package:app_eclipseworkd/utils/result.dart';
import 'package:app_eclipseworkd/domain/models/apod_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ApodFavoritesViewModel extends ChangeNotifier {
  final SharedPreferencesService _repository =
      Modular.get<SharedPreferencesService>();

  List<ApodModel>? _apod;
  List<ApodModel>? get apod => _apod;
  List<String>? _apodId;
  List<String>? get apodId => _apodId;

  late Command0 load;
  late Command1<void, ApodModel> saveFavorite;
  late Command1<void, ApodModel> removeFavorite;
  ApodFavoritesViewModel() {
    load = Command0(_load)..execute();
    saveFavorite = Command1(_saveFavorite);
    removeFavorite = Command1(_removeFavorite);
  }

  Future<Result> _load() async {
    try {
      final apodResult = await _repository.getFavotiresRawData();
      switch (apodResult) {
        case Ok<List<ApodModel>>():
          _apod = apodResult.value;
          _apodId = apodResult.value.map((e) => e.date!).toList();
          debugPrint('APODs favoritos Carregado');
        case Error<List<ApodModel>>():
          debugPrint('Error Carregar APODs favoritos');
      }
      return apodResult;
    } catch (erro) {
      return Result.error(Exception(
          'Erro Desconhecido, Tente novamente em alguns minutos $erro'));
    } finally {
      notifyListeners();
    }
  }

  Future<Result> _saveFavorite(ApodModel value) async {
    try {
      _apod ??= [];
      _apod?.add(value);
      final List<String> favoritesJson =
          _apod!.map((apod) => apod.toJson()).toList();
      await _repository.setFavorite(favoritesJson);
      return Result.ok(value);
    } catch (e) {
      return Result.error(Exception(e));
    } finally {
      notifyListeners();
    }
  }

  Future<Result> _removeFavorite(ApodModel value) async {
    try {
      _apod?.removeWhere((element) => element.date == value.date);
      final List<String> favoritesJson =
          _apod!.map((apod) => apod.toJson()).toList();
      _apodId?.removeWhere((element) => element == value.date);
      _unsetFavorites();
      await _repository.setFavorite(favoritesJson);
      return Result.ok(value);
    } catch (e) {
      return Result.error(Exception(e));
    } finally {
      notifyListeners();
    }
  }

  void _unsetFavorites() {
    final favoriteDates = apodId?.toSet();
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
