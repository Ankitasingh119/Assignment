import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/product.dart';
import '../blocs/favorites/favorites_bloc.dart';
import '../blocs/favorites/favorites_event.dart';

class ProductListItem extends StatelessWidget {
  final Product product;
  final VoidCallback onTap;
  const ProductListItem({
    super.key,
    required this.product,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isFav = context.select<FavoritesBloc, bool>(
      (bloc) => bloc.state.favorites.contains(product.id),
    );
    return ListTile(
      contentPadding: EdgeInsets.all(8),
      leading: Image.network(
        product.thumbnail,
        width: 60,
        height: 60,
        fit: BoxFit.cover,
      ),
      title: Text(product.title),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('${product.category} • ₹${product.price.toStringAsFixed(2)}'),
          Row(
            children: [
              Icon(Icons.star, size: 14, color: Colors.amber),
              SizedBox(width: 4),
              Text(product.rating.toString()),
              Spacer(),
              Text(
                product.inStock ? 'In Stock' : 'Out of Stock',
                style: TextStyle(
                  color: product.inStock ? Colors.green : Colors.red,
                ),
              ),
            ],
          ),
        ],
      ),
      trailing: IconButton(
        icon: Icon(
          isFav ? Icons.favorite : Icons.favorite_border,
          color: isFav ? Colors.red : null,
        ),
        onPressed:
            () => context.read<FavoritesBloc>().add(ToggleFavorite(product)),
      ),
      onTap: onTap,
    );
  }
}
