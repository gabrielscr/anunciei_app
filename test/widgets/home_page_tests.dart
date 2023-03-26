import 'package:anunciei_app/domain/entities/item.dart';
import 'package:anunciei_app/domain/use_cases/get_items_use_case.dart';
import 'package:anunciei_app/presentation/cubits/item/item_cubit.dart';
import 'package:anunciei_app/presentation/cubits/item/item_state.dart';
import 'package:anunciei_app/presentation/pages/home_page.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockItemCubit extends MockCubit<ItemState> implements ItemCubit {}

class MockGetItemsUseCase extends Mock implements GetItemsUseCase {}

class HomePageTests {
  void run() {
    group('HomePage', () {
      late MockItemCubit mockItemCubit;
      final testItems = [
        const Item(id: 1, name: 'Item 1'),
        const Item(id: 2, name: 'Item 2'),
        const Item(id: 3, name: 'Item 3'),
      ];

      setUp(() {
        mockItemCubit = MockItemCubit();
      });

      testWidgets('renders CircularProgressIndicator when state is loading',
          (WidgetTester tester) async {
        when(() => mockItemCubit.state).thenReturn(const LoadingItemState());

        await tester.pumpWidget(
          MaterialApp(
            home: BlocProvider.value(
              value: mockItemCubit,
              child: const HomePage(),
            ),
          ),
        );

        expect(find.byType(CircularProgressIndicator), findsOneWidget);
        expect(find.byType(ListView), findsNothing);
      });

      testWidgets('renders ListView with items when state is loaded', (WidgetTester tester) async {
        when(() => mockItemCubit.state).thenReturn(LoadedItemState(testItems));

        await tester.pumpWidget(
          MaterialApp(
            home: BlocProvider.value(
              value: mockItemCubit,
              child: const HomePage(),
            ),
          ),
        );

        expect(find.byType(CircularProgressIndicator), findsNothing);
        expect(find.byType(ListView), findsOneWidget);
        expect(find.byType(ListTile), findsNWidgets(testItems.length));
      });

      testWidgets('renders error message when state is error', (WidgetTester tester) async {
        when(() => mockItemCubit.state).thenReturn(const ErrorItemState('Test error message'));

        await tester.pumpWidget(
          MaterialApp(
            home: BlocProvider.value(
              value: mockItemCubit,
              child: const HomePage(),
            ),
          ),
        );

        expect(find.byType(CircularProgressIndicator), findsNothing);
        expect(find.byType(ListView), findsNothing);
        expect(find.text('Error: Test error message'), findsOneWidget);
      });
    });
  }
}
