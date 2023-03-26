import 'package:hive_flutter/hive_flutter.dart';

import '../../domain/entities/item.dart';

part 'item_model.g.dart';

@HiveType(typeId: 0)
class ItemModel {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  ItemModel({required this.id, required this.name});

  factory ItemModel.fromJson(Map<String, dynamic> json) {
    return ItemModel(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

  Item toEntity(ItemModel model) {
    return Item(id: model.id, name: model.name);
  }

  ItemModel fromEntity(Item item) {
    return ItemModel(id: item.id, name: item.name);
  }
}
