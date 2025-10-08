import '../../domain/entities/product.dart';
import '../../domain/repositories/product_repository.dart';
import '../data_sources/product_data_source.dart';
import '../data_sources/product_data_remote_source.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductLocalDataSource localDataSource;
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl({
    required this.localDataSource,
    required this.remoteDataSource,
  });

  @override
  Future<List<Product>> getProducts() async {
    try {
      final remoteProducts = await remoteDataSource.getRemoteProducts();
      await localDataSource.cacheProducts(remoteProducts);
      return remoteProducts;
    } catch (e) {
      final cached = await localDataSource.getCachedProducts();
      return cached;
    }
  }
}
