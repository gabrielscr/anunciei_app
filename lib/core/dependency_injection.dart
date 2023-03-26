import 'package:get_it/get_it.dart';
import '../data/data_sources/item_data_source.dart';
import '../data/repositories/item_repository_impl.dart';
import '../domain/repositories/item_repository.dart';
import '../domain/use_cases/get_items_use_case.dart';
import '../presentation/cubits/item/item_cubit.dart';

final getIt = GetIt.instance;

void setupDependencyInjection() {
  // Data sources
  getIt.registerLazySingleton(() => ItemDataSourceApiImpl());
  getIt.registerLazySingleton(() => ItemDataSourceLocalImpl());
  getIt.registerLazySingleton<ItemDataSource>(() => ItemDataSourceImpl(getIt(), getIt()));

  // Repositories
  getIt.registerLazySingleton<ItemRepository>(() => ItemRepositoryImpl(getIt()));

  // Use cases
  getIt.registerLazySingleton(() => GetItemsUseCase(getIt()));

  // Cubits
  getIt.registerLazySingleton(() => ItemCubit(getIt()));
}
