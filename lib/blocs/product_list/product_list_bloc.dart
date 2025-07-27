import 'dart:async';
import 'package:bloc/bloc.dart';
import '../../models/product.dart';
import '../../repositories/product_repository.dart';
import 'product_list_event.dart';
import 'product_list_state.dart';

class ProductListBloc extends Bloc<ProductListEvent, ProductListState> {
  final ProductRepository repository;
  static const int _limit = 20;

  final List<Product> _all = [];
  bool _hasReachedMax = false;
  int _offset = 0;

  SortField? _sort;

  ProductListBloc({required this.repository}) : super(ProductListInitial()) {
    on<FetchProducts>(_onFetch);
    on<RefreshProducts>(_onRefresh);
    on<SortProducts>(_onSort);
  }

  Future<void> _onFetch(
    FetchProducts event,
    Emitter<ProductListState> emit,
  ) async {
    if (_hasReachedMax) return;
    try {
      if (_offset == 0) emit(ProductListLoading());
      final fetched = await repository.fetchProducts(
        offset: _offset,
        limit: _limit,
      );
      if (fetched.isEmpty) {
        _hasReachedMax = true;
      } else {
        _offset += fetched.length;
        _all.addAll(fetched);
        if (_sort != null) {
          _applySort();
        }
      }
      emit(
        ProductListSuccess(
          products: List.of(_all),
          hasReachedMax: _hasReachedMax,
        ),
      );
    } catch (e) {
      emit(ProductListFailure(e.toString()));
    }
  }

  Future<void> _onRefresh(
    RefreshProducts event,
    Emitter<ProductListState> emit,
  ) async {
    _offset = 0;
    _all.clear();
    _hasReachedMax = false;
    await _onFetch(FetchProducts(), emit);
  }

  void _onSort(SortProducts event, Emitter<ProductListState> emit) {
    _sort = event.field;
    _applySort();
    emit(
      ProductListSuccess(
        products: List.of(_all),
        hasReachedMax: _hasReachedMax,
      ),
    );
  }

  void _applySort() {
    if (_sort == SortField.price) {
      _all.sort((a, b) => a.price.compareTo(b.price));
    } else if (_sort == SortField.rating) {
      _all.sort((a, b) => a.rating.compareTo(b.rating));
    } else if (_sort == SortField.name) {
      _all.sort((a, b) => a.title.compareTo(b.title));
    }
  }
}
