import 'package:flutter/material.dart';
import 'package:my_todo/core/constants/app_color.dart';
import 'package:my_todo/core/constants/app_icons.dart';
import 'package:my_todo/feature/home/domain/entities/tag.dart';

class TagModel extends Tag {
  const TagModel({
    required super.name,
    required super.type,
    required super.backgroundColor,
    required super.textColor,
    super.icon,
  });

  factory TagModel.fromEntity(Tag tag) {
    return TagModel(
      name: tag.name,
      type: tag.type,
      backgroundColor: tag.backgroundColor,
      textColor: tag.textColor,
      icon: tag.icon,
    );
  }

  // Simplified mapping for simulation
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'type': type.name, // Convert enum to string
      // Note: Storing colors/icons directly in map is complex,
      // in real scenario, you'd map to predefined values or hex codes.
      // For this example, we'll recreate from type.
    };
  }

  factory TagModel.fromMap(Map<String, dynamic> map) {
    final TagType type = TagType.values.firstWhere(
      (e) => e.name == map['type'],
      orElse: () => TagType.general,
    );
    return _getTagProperties(type, map['name']);
  }

  static TagModel _getTagProperties(TagType type, String name) {
    switch (type) {
      case TagType.university:
        return TagModel(
          name: name,
          type: type,
          backgroundColor: AppColors.tagUniversity,
          textColor: AppColors.textLight,
          icon: AppIcons.universityCap,
        );
      case TagType.home:
        return TagModel(
          name: name,
          type: type,
          backgroundColor: AppColors.tagHome,
          textColor: AppColors.textLight,
          icon: AppIcons.homeHouse,
        );
      case TagType.work:
        return TagModel(
          name: name,
          type: type,
          backgroundColor: AppColors.tagWork,
          textColor: AppColors.textLight,
          icon: AppIcons.workBriefcase,
        );
      case TagType.general:
      default:
        return TagModel(
          name: name,
          type: type,
          backgroundColor: AppColors.tagDefaultBackground,
          textColor: AppColors.tagDefaultText,
        );
    }
  }

  // Helper to get predefined tags
  static List<TagModel> predefinedTags = const [
    TagModel(
      name: 'University',
      type: TagType.university,
      backgroundColor: AppColors.tagUniversity,
      textColor: AppColors.textLight,
      icon: AppIcons.universityCap,
    ),
    TagModel(
      name: 'Home',
      type: TagType.home,
      backgroundColor: AppColors.tagHome,
      textColor: AppColors.textLight,
      icon: AppIcons.homeHouse,
    ),
    TagModel(
      name: 'Work',
      type: TagType.work,
      backgroundColor: AppColors.tagWork,
      textColor: AppColors.textLight,
      icon: AppIcons.workBriefcase,
    ),
  ];
}
