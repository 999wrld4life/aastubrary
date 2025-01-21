part of 'favorite_bloc.dart';

abstract class FavoriteState extends Equatable {
  const FavoriteState();

  @override
  List<Object> get props => [];
}

class FavoriteInitial extends FavoriteState {}

class FavoriteLoading extends FavoriteState {}

class FavoriteLoaded extends FavoriteState {
  final List<Book> favoriteBooks;
  const FavoriteLoaded(this.favoriteBooks);

  @override
  List<Object> get props => [favoriteBooks];
}

class FavoriteDeleted extends FavoriteState {
  final List<Book> favoriteBooks;
  const FavoriteDeleted(this.favoriteBooks);

  @override
  List<Object> get props => [favoriteBooks];
}

class FavoriteAdded extends FavoriteState {}

class FavoriteRemoved extends FavoriteState {}

class FavoriteError extends FavoriteState {
  final String error;
  const FavoriteError(this.error);

  @override
  List<Object> get props => [error];
}
