import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../domain/use_cases/get_items_use_case.dart';
import 'item_state.dart';

class ItemCubit extends Cubit<ItemState> {
  final GetItemsUseCase _getItemsUseCase;

  ItemCubit(this._getItemsUseCase) : super(const LoadingItemState()) {
    loadItems();
  }

  Future<void> loadItems() async {
    try {
      final items = await _getItemsUseCase.call();
      emit(LoadedItemState(items));
    } catch (e) {
      emit(ErrorItemState(e.toString()));
    }
  }
}
