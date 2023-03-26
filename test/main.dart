import 'cubits/item_cubit_test.dart';
import 'use_cases/get_items_use_case_test.dart';
import 'widgets/home_page_tests.dart';

void main() {
  GetItemsUseCaseTest().run();
  ItemCubitTest().run();
  HomePageTests().run();
}
