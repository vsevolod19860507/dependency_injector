import 'package:flutter/material.dart';

@immutable
abstract class BaseService {
  BaseService(this.index) {
    colors[index] = Colors.primaries[index];
  }

  final Map<int, Color> colors = {};

  final int index;

  String get name {
    final dirtyName = toString();
    final name =
        dirtyName.substring(dirtyName.indexOf('\'') + 1, dirtyName.length - 1);

    return name;
  }

  Padding toText(
    double padding, {
    String suffix = '',
  }) {
    return Padding(
      padding: EdgeInsets.only(left: padding),
      child: Text(
        '$name$suffix: ${index + 1}',
        style: TextStyle(color: colors[index]),
      ),
    );
  }
}
