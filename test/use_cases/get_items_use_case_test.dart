// test/use_cases/get_items_use_case_test.dart

import 'package:anunciei_app/domain/entities/item.dart';
import 'package:anunciei_app/domain/repositories/item_repository.dart';
import 'package:anunciei_app/domain/use_cases/get_items_use_case.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockItemRepository extends Mock implements ItemRepository {}

class GetItemsUseCaseTest {
  void run() {
    late ItemRepository itemRepository;
    late GetItemsUseCase getItemsUseCase;

    setUp(() {
      itemRepository = MockItemRepository();
      getItemsUseCase = GetItemsUseCase(itemRepository);
    });

    test('returns a list of items', () async {
      final repository = MockItemRepository();
      final testItems = [
        const Item(id: 1, name: 'Item 1'),
        const Item(id: 2, name: 'Item 2'),
      ];

      when(() => repository.getItems()).thenAnswer((_) async => testItems);

      final useCase = GetItemsUseCase(repository);
      final result = await useCase.call();

      expect(result, isA<List<Item>>());
      expect(result, equals(testItems));
    });

    group('GetItemsUseCase', () {
      final testItems = [
        const Item(id: 1, name: 'Item 1'),
        const Item(id: 2, name: 'Item 2'),
      ];

      test('returns list of items from repository', () async {
        when(() => itemRepository.getItems()).thenAnswer((_) async => testItems);

        final result = await getItemsUseCase();

        expect(result, testItems);
        verify(() => itemRepository.getItems()).called(1);
      });
    });
  }
}
