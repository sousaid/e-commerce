import '../entities/product.dart';
import '../repositories/product_repository.dart';
import '../../../../core/use_case/use_case.dart';

class GetProducts implements UseCase<List<Product>, NoParams> {
  final ProductRepository repository;

  GetProducts(this.repository);

  @override
  Future<List<Product>> call(NoParams params) async {
    return await repository.getProducts();
  }
}
