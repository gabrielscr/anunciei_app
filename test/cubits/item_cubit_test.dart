import 'package:anunciei_app/domain/entities/item.dart';
import 'package:anunciei_app/domain/use_cases/get_items_use_case.dart';
import 'package:anunciei_app/presentation/cubits/item/item_cubit.dart';
import 'package:anunciei_app/presentation/cubits/item/item_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGetItemsUseCase extends Mock implements GetItemsUseCase {}

class ItemCubitTest {
  void run() {
    late GetItemsUseCase getItemsUseCase;
    late ItemCubit itemCubit;

    setUp(() {
      getItemsUseCase = MockGetItemsUseCase();
      itemCubit = ItemCubit(getItemsUseCase);
    });

    group('ItemCubit', () {
      final testItems = [
        const Item(id: 1, name: 'Item 1'),
        const Item(id: 2, name: 'Item 2'),
      ];

      test('calls GetItemsUseCase during initialization', () {
        final mockGetItemsUseCase = MockGetItemsUseCase();
        final itemCubit = ItemCubit(mockGetItemsUseCase);

        verify(() => mockGetItemsUseCase()).called(1);
      });

      test('initial state is empty', () {
        expect(itemCubit.state, []);
      });

      group('ItemCubit', () {
        late GetItemsUseCase mockGetItemsUseCase;

        setUp(() {
          mockGetItemsUseCase = MockGetItemsUseCase();
        });

        test('initial state is LoadingItemState', () {
          final itemCubit = ItemCubit(mockGetItemsUseCase);

          expect(itemCubit.state, const LoadingItemState());
        });
      });
    });
  }
}
