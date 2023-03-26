import '../entities/item.dart';
import '../repositories/item_repository.dart';

class GetItemsUseCase {
  final ItemRepository _itemRepository;

  GetItemsUseCase(this._itemRepository);

  Future<List<Item>> call() {
    return _itemRepository.getItems();
  }
}
