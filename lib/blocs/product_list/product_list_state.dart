import '../../models/product.dart';

abstract class ProductListState {}

class ProductListInitial extends ProductListState {}

class ProductListLoading extends ProductListState {}

class ProductListSuccess extends ProductListState {
  final List<Product> products;
  final bool hasReachedMax;
  ProductListSuccess({required this.products, required this.hasReachedMax});
}

class ProductListFailure extends ProductListState {
  final String error;
  ProductListFailure(this.error);
}
