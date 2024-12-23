import 'package:app_eclipseworkd/domain/models/apod_model.dart';
import 'package:app_eclipseworkd/utils/result.dart';
import 'package:flutter/material.dart';

abstract interface class ApodApi {
  Future<Result<List<ApodModel>>> getApod(DateTimeRange? date);
}
