import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension FormatDate on DateTime? {
  String get formatDate => this == null
      ? ''
      : DateFormat('yyyy-MM-dd').format(this!.toUtc().subtract(5.hours));
}

extension FormatDateRange on DateTimeRange {
  String get formatDateRangeFilterBar {
    if (start.year == end.year) {
      final nStart = DateFormat('dd/MM').format(start);
      final nEnd = DateFormat('dd/MM').format(end);
      return nStart == nEnd ? nStart : '$nStart - $nEnd';
    } else {
      final nStart = DateFormat('MM/yy').format(start);
      final nEnd = DateFormat('MM/yy').format(end);
      return nStart == nEnd ? nStart : '$nStart - $nEnd';
    }
  }
}

extension StringExtensions on String? {
  String get cropLargeText =>
      (this?.length ?? 0) > 20 ? this?.substring(0, 20) ?? '' : (this ?? '');

  String get toCapitalized {
    if (this != null) {
      return this!.isNotEmpty
          ? '${this![0].toUpperCase()}${this!.substring(1).toLowerCase()}'
          : '';
    } else {
      return '';
    }
  }

  bool get isVideo => (this?.toLowerCase() == 'video');
  bool get isImageUrl {
    if (this == null) {
      return false;
    }
    const imageExtensions = [
      ".jpg",
      ".jpeg",
      ".png",
      ".gif",
      ".bmp",
      ".webp",
      ".svg"
    ];
    return imageExtensions
        .any((extension) => this!.toLowerCase().endsWith(extension));
  }

  String get seeMoreApodUrlMake {
    if (this == null) {
      return '';
    }
    final dateList = this!.split('-');
    return dateList.first.substring(2) + dateList[1] + dateList.last;
  }
}

extension DoubleToDuration on int {
  Duration get mc => Duration(microseconds: this);
  Duration get ms => Duration(milliseconds: this);
  Duration get sec => Duration(seconds: this);
  Duration get min => Duration(minutes: this);
  Duration get hours => Duration(hours: this);
  Duration get days => Duration(days: this);
}
