import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../models/product.dart';
import '../blocs/favorites/favorites_bloc.dart';
import '../blocs/favorites/favorites_event.dart';

class DetailScreen extends StatelessWidget {
  final Product product;
  const DetailScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final isFav = context.select<FavoritesBloc, bool>(
      (bloc) => bloc.state.favorites.contains(product.id),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text(product.title),
        actions: [
          IconButton(
            icon: Icon(
              isFav ? Icons.favorite : Icons.favorite_border,
              color: isFav ? Colors.red : null,
            ),
            onPressed:
                () =>
                    context.read<FavoritesBloc>().add(ToggleFavorite(product)),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              product.thumbnail,
              height: 250,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 16),
            Text(product.title, style: Theme.of(context).textTheme.titleLarge),
            SizedBox(height: 8),
            Text('Category: ${product.category}'),
            SizedBox(height: 8),
            Text('Price: ₹${product.price.toStringAsFixed(2)}'),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.star, color: Colors.amber),
                SizedBox(width: 4),
                Text(product.rating.toString()),
              ],
            ),
            SizedBox(height: 16),
            Text('Description', style: Theme.of(context).textTheme.bodyMedium),
            SizedBox(height: 8),
            Text(product.description),
            SizedBox(height: 16),
            Text(
              product.inStock ? 'In Stock' : 'Out of Stock',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: product.inStock ? Colors.green : Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
