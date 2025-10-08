import 'package:flutter/foundation.dart';
import '../../domain/entities/product.dart';
import '../../domain/use_case/get_product.dart';
import '../../../../core/use_case/use_case.dart';

class ProductNotifier extends ChangeNotifier {
  final GetProducts getProducts;
  List<Product> products = [];
  bool isLoading = false;

  ProductNotifier({required this.getProducts});

  Future<void> loadProducts() async {
    isLoading = true;
    notifyListeners();

    final result = await getProducts(NoParams());
    products = result;

    isLoading = false;
    notifyListeners();
  }
}
