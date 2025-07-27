import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/product_list/product_list_bloc.dart';
import '../blocs/product_list/product_list_event.dart';
import '../blocs/product_list/product_list_state.dart';
import '../widgets/product_list_item.dart';
import '../widgets/product_grid_item.dart';
import '../widgets/shimmer_loader.dart';
import 'detail_screen.dart';
import 'favorites_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scroll = ScrollController();
  bool _isGrid = false;

  @override
  void initState() {
    super.initState();
    _scroll.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scroll.position.pixels >= _scroll.position.maxScrollExtent - 200) {
      context.read<ProductListBloc>().add(FetchProducts());
    }
  }

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  void _onSortSelected(SortField field) {
    context.read<ProductListBloc>().add(SortProducts(field));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Products'),
        actions: [
          IconButton(
            icon: Icon(_isGrid ? Icons.view_list : Icons.grid_view),
            onPressed: () => setState(() => _isGrid = !_isGrid),
          ),
          PopupMenuButton<SortField>(
            onSelected: _onSortSelected,
            itemBuilder:
                (_) => [
                  PopupMenuItem(
                    value: SortField.price,
                    child: Text('Sort by Price'),
                  ),
                  PopupMenuItem(
                    value: SortField.rating,
                    child: Text('Sort by Rating'),
                  ),
                  PopupMenuItem(
                    value: SortField.name,
                    child: Text('Sort by Name'),
                  ),
                ],
          ),
          IconButton(
            icon: Icon(Icons.favorite),
            onPressed:
                () => Navigator.of(
                  context,
                ).push(MaterialPageRoute(builder: (_) => FavoritesScreen())),
          ),
        ],
      ),
      body: BlocBuilder<ProductListBloc, ProductListState>(
        builder: (context, state) {
          if (state is ProductListLoading && state is! ProductListSuccess) {
            return ShimmerLoader(isGrid: _isGrid);
          } else if (state is ProductListFailure) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error: ${state.error}'),
                  ElevatedButton(
                    onPressed:
                        () => context.read<ProductListBloc>().add(
                          RefreshProducts(),
                        ),
                    child: Text('Retry'),
                  ),
                ],
              ),
            );
          } else if (state is ProductListSuccess) {
            final products = state.products;
            if (products.isEmpty) {
              return Center(child: Text('No products found.'));
            }
            return RefreshIndicator(
              onRefresh:
                  () async =>
                      context.read<ProductListBloc>().add(RefreshProducts()),
              child:
                  _isGrid
                      ? GridView.builder(
                        controller: _scroll,
                        padding: EdgeInsets.all(8),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.75,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 8,
                        ),
                        itemCount:
                            state.hasReachedMax
                                ? products.length
                                : products.length + 1,
                        itemBuilder: (context, idx) {
                          if (idx >= products.length) {
                            return Center(child: CircularProgressIndicator());
                          }
                          final p = products[idx];
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
                      )
                      : ListView.builder(
                        controller: _scroll,
                        padding: EdgeInsets.all(8),
                        itemCount:
                            state.hasReachedMax
                                ? products.length
                                : products.length + 1,
                        itemBuilder: (context, idx) {
                          if (idx >= products.length) {
                            return Center(child: CircularProgressIndicator());
                          }
                          final p = products[idx];
                          return ProductListItem(
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
          return ShimmerLoader(isGrid: _isGrid);
        },
      ),
    );
  }
}
