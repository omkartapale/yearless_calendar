// Copyright 2024 Omkar Tapale. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:yearless_calendar/utils.dart';

void main() {
  final date = DateTime(2024, 2, 12);
  group('Calendar formatting functions.', () {
    group('customDateFormat Tests:', () {
      test(
          'Should execute with default en_US locale and without format params.',
          () {
        final formattedDate = CalendarFormatter.customDateFormat(date);
        expect(formattedDate, 'February 12, 2024 12:00:00 AM');
      });
      test(
          'Should return formatted date with specified format and default en_US locale.',
          () {
        final formattedDate =
            CalendarFormatter.customDateFormat(date, 'dd/MM/yyyy');
        expect(formattedDate, '12/02/2024');
      });
      test(
          'Should return formatted date with specified format in de_DE locale.',
          () {
        initializeDateFormatting('de_DE', null).then((_) {
          final formattedDate = CalendarFormatter.customDateFormat(
              date, 'EEE dd MMM yyyy', 'de_DE');
          expect(formattedDate, 'Mo. 12 Feb. 2024');
        });
      });
    });
    group('dayName Tests:', () {
      test('Should return day name in default en_US.', () {
        final formattedDate = CalendarFormatter.dayName(date);
        expect(formattedDate, 'Monday');
      });
      test('Should return day name in fr_FR.', () {
        initializeDateFormatting('fr_FR', null).then((_) {
          final formattedDate = CalendarFormatter.dayName(date, 'fr_FR');
          expect(formattedDate, 'lundi');
        });
      });
    });
    group('dayShortName Tests:', () {
      test('Should return abbreviated day name in default en_US.', () {
        final formattedDate = CalendarFormatter.dayShortName(date);
        expect(formattedDate, 'Mon');
      });
      test('Should return abbreviated day name in mr_IN.', () {
        initializeDateFormatting('mr_IN', null).then((_) {
          final formattedDate = CalendarFormatter.dayShortName(date, 'mr_IN');
          expect(formattedDate, 'सोम');
        });
      });
    });
    group('fullDate Tests:', () {
      test('Should return full date in dd/MM/yyyy format in default en_US.',
          () {
        final formattedDate = CalendarFormatter.fullDate(date);
        expect(formattedDate, '12/02/2024');
      });
      test('Should return full date in dd/MM/yyyy format in mr_IN.', () {
        initializeDateFormatting('mr_IN', null).then((_) {
          final formattedDate = CalendarFormatter.fullDate(date, 'mr_IN');
          expect(formattedDate, '१२/०२/२०२४');
        });
      });
    });
    group('monthName Tests:', () {
      test('Should return month name in default en_US.', () {
        final formattedDate = CalendarFormatter.monthName(date);
        expect(formattedDate, 'February');
      });
      test('Should return month name in pt_BR.', () {
        initializeDateFormatting('pt_BR', null).then((_) {
          final formattedDate = CalendarFormatter.monthName(date, 'pt_BR');
          expect(formattedDate, 'fevereiro');
        });
      });
    });
    group('monthShortName Tests:', () {
      test('Should return abbreviated month name in default en_US.', () {
        final formattedDate = CalendarFormatter.monthShortName(date);
        expect(formattedDate, 'Feb');
      });
      test('Should return abbreviated month name in fr_FR.', () {
        initializeDateFormatting('fr_FR', null).then((_) {
          final formattedDate = CalendarFormatter.monthShortName(date, 'fr_FR');
          expect(formattedDate, 'févr.');
        });
      });
    });
  });
}
