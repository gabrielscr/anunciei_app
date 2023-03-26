import 'package:connectivity/connectivity.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../domain/entities/item.dart';
import '../models/item_model.dart';

abstract class ItemDataSource {
  Future<bool> hasData();
  Future<List<Item>> fetchItems();
  Future<void> saveItems(List<Item> items);
}

class ItemDataSourceApiImpl implements ItemDataSource {
  @override
  Future<List<Item>> fetchItems() async {
    // Simula uma chamada de API com delay
    await Future.delayed(const Duration(seconds: 1));

    return [
      const Item(id: 1, name: 'Item 1'),
      const Item(id: 2, name: 'Item 2'),
    ];
  }

  @override
  Future<void> saveItems(List<Item> items) {
    throw UnimplementedError();
  }

  @override
  Future<bool> hasData() {
    // TODO: implement hasData
    throw UnimplementedError();
  }
}

class ItemDataSourceLocalImpl implements ItemDataSource {
  final _boxName = 'items';

  @override
  Future<List<Item>> fetchItems() async {
    final box = await Hive.openBox<ItemModel>(_boxName);
    return box.values.map((itemModel) => Item(id: itemModel.id, name: itemModel.name)).toList();
  }

  @override
  Future<void> saveItems(List<Item> items) async {
    final box = await Hive.openBox<ItemModel>(_boxName);
    await box.clear();
    for (var item in items) {
      await box.add(ItemModel(id: item.id, name: item.name));
    }
  }

  @override
  Future<bool> hasData() async {
    final box = await Hive.openBox<ItemModel>(_boxName);
    return box.isNotEmpty;
  }
}

class ItemDataSourceImpl implements ItemDataSource {
  final ItemDataSourceApiImpl _apiDataSource;
  final ItemDataSourceLocalImpl _itemDataSource;

  ItemDataSourceImpl(this._apiDataSource, this._itemDataSource);

  @override
  Future<List<Item>> fetchItems() async {
    final connectivityResult = await Connectivity().checkConnectivity();

    if (connectivityResult != ConnectivityResult.none) {
      final items = await _apiDataSource.fetchItems();
      await _itemDataSource.saveItems(items);
      return items;
    } else {
      if (await _itemDataSource.hasData()) {
        return await _itemDataSource.fetchItems();
      } else {
        throw Exception('No internet connection and no local data available');
      }
    }
  }

  @override
  Future<bool> hasData() {
    // TODO: implement hasData
    throw UnimplementedError();
  }

  @override
  Future<void> saveItems(List<Item> items) {
    // TODO: implement saveItems
    throw UnimplementedError();
  }
}
