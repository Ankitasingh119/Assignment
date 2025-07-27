abstract class ProductListEvent {}

class FetchProducts extends ProductListEvent {}

class RefreshProducts extends ProductListEvent {}

enum SortField { price, rating, name }

class SortProducts extends ProductListEvent {
  final SortField field;
  SortProducts(this.field);
}
