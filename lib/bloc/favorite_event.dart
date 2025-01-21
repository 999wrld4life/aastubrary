part of 'favorite_bloc.dart';

abstract class FavoriteEvent extends Equatable {
  const FavoriteEvent();

  @override
  List<Object> get props => [];
}

class FetchFavoriteBooks extends FavoriteEvent {
  const FetchFavoriteBooks();
}

class AddToFavorite extends FavoriteEvent {
  final Book book;
  const AddToFavorite(this.book);

  @override
  List<Object> get props => [book];
}

class RemoveFromFavorite extends FavoriteEvent {
  final Book book;
  const RemoveFromFavorite(this.book);

  @override
  List<Object> get props => [book];
}
