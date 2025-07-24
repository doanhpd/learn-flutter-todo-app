import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

enum TagType { university, home, work, general }

class Tag extends Equatable {
  final String name;
  final TagType type;
  final Color backgroundColor;
  final Color textColor;
  final IconData? icon;

  const Tag({
    required this.name,
    required this.type,
    required this.backgroundColor,
    required this.textColor,
    this.icon,
  });

  @override
  List<Object?> get props => [name, type, backgroundColor, textColor, icon];
}
