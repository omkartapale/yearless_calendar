// Copyright 2024 Omkar Tapale. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

/// A model class structure for a Calendar Month.
class CalendarMonth {
  /// Constructs an instance with the given values.
  const CalendarMonth({
    required this.name,
    required this.monthNum,
  }) : assert(
          monthNum >= 1 && monthNum <= 12,
          'The month number must be in the range of 1 to 12.',
        );

  /// The name of the month.
  final String name;

  /// The number of the month ranges from 1,2...12.
  final int monthNum;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CalendarMonth &&
          runtimeType == other.runtimeType &&
          name == other.name &&
          monthNum == other.monthNum;

  @override
  int get hashCode => Object.hash(
        name.hashCode,
        monthNum.hashCode,
      );

  @override
  String toString() => "<$monthNum,$name>";
}
