import '../../models/product.dart';

abstract class FavoritesEvent {}

class ToggleFavorite extends FavoritesEvent {
  final Product product;
  ToggleFavorite(this.product);
}
