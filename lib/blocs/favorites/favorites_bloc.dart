import 'package:bloc/bloc.dart';
import 'favorites_event.dart';
import 'favorites_state.dart';

class FavoritesBloc extends Bloc<FavoritesEvent, FavoritesState> {
  FavoritesBloc() : super(FavoritesState({})) {
    on<ToggleFavorite>(_onToggle);
  }

  void _onToggle(ToggleFavorite event, Emitter<FavoritesState> emit) {
    final current = Set<int>.from(state.favorites);
    if (current.contains(event.product.id)) {
      current.remove(event.product.id);
    } else {
      current.add(event.product.id);
    }
    emit(FavoritesState(current));
  }
}
