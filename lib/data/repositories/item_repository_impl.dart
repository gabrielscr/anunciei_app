import '../../domain/entities/item.dart';
import '../../domain/repositories/item_repository.dart';
import '../data_sources/item_data_source.dart';

class ItemRepositoryImpl implements ItemRepository {
  final ItemDataSource _itemDataSource;

  ItemRepositoryImpl(this._itemDataSource);

  @override
  Future<List<Item>> getItems() async {
    return await _itemDataSource.fetchItems();
  }

  @override
  Future<void> saveItems(List<Item> items) {
    // TODO: implement saveItems
    throw UnimplementedError();
  }
}
