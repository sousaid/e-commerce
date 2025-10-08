import 'package:get_it/get_it.dart';
import 'features/product/data/repositories/product_repository_impl.dart';
import 'features/product/domain/repositories/product_repository.dart';
import 'features/product/domain/use_case/get_product.dart';
import 'features/product/presentation/state/product_notifier.dart';
import 'features/product/data/data_sources/product_data_source.dart';
import 'features/product/data/data_sources/product_data_remote_source.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Presentation
  sl.registerFactory(() => ProductNotifier(getProducts: sl()));

  // Use cases
  sl.registerLazySingleton(() => GetProducts(sl()));

  // Repository
  sl.registerLazySingleton<ProductRepository>(() => ProductRepositoryImpl(
    localDataSource: sl(),
    remoteDataSource: sl(),
  ));

  // Data sources
  sl.registerLazySingleton<ProductLocalDataSource>(
          () => ProductLocalDataSourceImpl());
  sl.registerLazySingleton<ProductRemoteDataSource>(
          () => ProductRemoteDataSourceImpl());
}
