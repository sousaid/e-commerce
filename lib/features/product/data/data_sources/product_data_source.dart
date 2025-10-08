import '../models/product_model.dart';

abstract class ProductLocalDataSource {
  Future<List<ProductModel>> getCachedProducts();
  Future<void> cacheProducts(List<ProductModel> products);
}

class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  List<ProductModel> _cache = [];

  @override
  Future<void> cacheProducts(List<ProductModel> products) async {
    _cache = products;
  }

  @override
  Future<List<ProductModel>> getCachedProducts() async {
    return _cache;
  }
}
