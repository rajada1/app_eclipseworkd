import 'dart:convert';

import 'package:app_eclipseworkd/utils/result.dart';
import 'package:app_eclipseworkd/domain/models/apod_model.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  Future<bool> setDarkMode(bool value) async {
    try {
      final instance = await SharedPreferences.getInstance();
      final isDarkMode = await instance.setBool('theme_mode', value);

      return isDarkMode;
    } on Exception catch (error) {
      debugPrint('Save AppTheme Error $error');
      return false;
    }
  }

  Future<bool?> isDarkMode() async {
    final instance = await SharedPreferences.getInstance();
    try {
      final isDarkMode = instance.getBool('theme_mode');
      // null is not Define,
      // true, is darkMode enabled
      // false darkMode disable
      return isDarkMode;
    } on Exception catch (error) {
      debugPrint('Save AppTheme Error $error');
      return null;
    }
  }

  Future<Result<List<ApodModel>>> getFavotiresRawData() async {
    try {
      final instance = await SharedPreferences.getInstance();
      final rawValue = instance.getStringList('favorites');
      if (rawValue == null) {
        return Result.ok([]);
      }
      return Result.ok(rawValue
          .map((json) => ApodModel.fromJson(jsonDecode(json)))
          .toList());
    } on Exception catch (error) {
      return Result.error(error);
    }
  }

  Future<Result<bool>> setFavorite(List<String> value) async {
    try {
      final instance = await SharedPreferences.getInstance();
      final success = await instance.setStringList('favorites', value);
      if (success) {
        return Result.ok(success);
      } else {
        return Result.error(Exception('Erro ao Salvar tente novamente'));
      }
    } on Exception catch (error) {
      return Result.error(error);
    }
  }
}
