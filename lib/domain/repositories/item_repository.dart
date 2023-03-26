import '../entities/item.dart';

abstract class ItemRepository {
  Future<List<Item>> getItems();
  Future<void> saveItems(List<Item> items);
}
