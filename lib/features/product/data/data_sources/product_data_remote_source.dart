import 'dart:convert';
import '../models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getRemoteProducts();
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  @override
  Future<List<ProductModel>> getRemoteProducts() async {
    // Mock JSON Data
    final jsonString = '''
    [
      {"id": 1, "name": "iPhone 15", "price": 1299.99, "imageUrl": "https://picsum.photos/200"},
      {"id": 2, "name": "MacBook Pro 1", "price": 2499.00, "imageUrl": "https://picsum.photos/200"},
      {"id": 3, "name": "AirPods Pro 2", "price": 309.99, "imageUrl": "https://picsum.photos/200"},
      {"id": 4, "name": "AirPods Pro 3", "price": 709.66, "imageUrl": "https://picsum.photos/200"},
      {"id": 5, "name": "AirPods Pro 4", "price": 499.77, "imageUrl": "https://picsum.photos/200"},
      {"id": 7, "name": "AirPods Pro 5", "price": 199.09, "imageUrl": "https://picsum.photos/200"},
      {"id": 8, "name": "AirPods Pro 6", "price": 199.09, "imageUrl": "https://picsum.photos/200"},
      {"id": 9, "name": "AirPods Pro 7", "price": 199.09, "imageUrl": "https://picsum.photos/200"},
      {"id": 10, "name": "AirPods Pro 8", "price": 199.09, "imageUrl": "https://picsum.photos/200"},
      {"id": 11, "name": "AirPods Pro 9", "price": 199.09, "imageUrl": "https://picsum.photos/200"},
      {"id": 12, "name": "AirPods Pro 10", "price": 199.09, "imageUrl": "https://picsum.photos/200"},
      {"id": 13, "name": "AirPods Pro 11", "price": 199.09, "imageUrl": "https://picsum.photos/200"}
    ]
    ''';

    final List<dynamic> decoded = json.decode(jsonString);
    return decoded.map((e) => ProductModel.fromJson(e)).toList();
  }
}
