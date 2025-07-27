import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/favorites/favorites_bloc.dart';
import '../blocs/product_list/product_list_bloc.dart';
import '../blocs/product_list/product_list_state.dart';
import '../models/product.dart';
import '../widgets/product_grid_item.dart';
import 'detail_screen.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final favIds = context.watch<FavoritesBloc>().state.favorites;
    final productState = context.watch<ProductListBloc>().state;
    List<Product> all = [];
    if (productState is ProductListSuccess) {
      all = productState.products;
    }
    final favs = all.where((p) => favIds.contains(p.id)).toList();
    return Scaffold(
      appBar: AppBar(title: Text('Favorites')),
      body:
          favs.isEmpty
              ? Center(child: Text('No favorites added.'))
              : GridView.builder(
                padding: EdgeInsets.all(8),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.75,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: favs.length,
                itemBuilder: (context, idx) {
                  final p = favs[idx];
                  return ProductGridItem(
                    product: p,
                    onTap:
                        () => Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => DetailScreen(product: p),
                          ),
                        ),
                  );
                },
              ),
    );
  }
}
