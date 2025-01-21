import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:day_1/model/book.dart';
import 'package:day_1/service/book_repository.dart';
import 'package:equatable/equatable.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final BookRepository bookRepository;
  FavoriteBloc(this.bookRepository) : super(FavoriteInitial()) {
    on<FetchFavoriteBooks>((event, emit) async {
      emit(FavoriteLoading());
      try {
        final favoriteBooks = await bookRepository.fetchFavoriteBooks();
        log(favoriteBooks.toString());
        emit(FavoriteLoaded(favoriteBooks));
      } catch (e) {
        log(e.toString());
        emit(FavoriteError(e.toString()));
      }
    });
    on<AddToFavorite>(
      (event, emit) async {
        emit(FavoriteLoading());
        try {
          final favoriteBooks = await bookRepository.fetchFavoriteBooks();

          if (favoriteBooks.contains(event.book)) {
            emit(const FavoriteError('Already Added To Favorites'));
            log('Already exists');
          } else {
            await bookRepository.addFavoriteBook(event.book);
            emit(FavoriteAdded());
            final updatedFavoriteBooks =
                await bookRepository.fetchFavoriteBooks();
            emit(FavoriteLoaded(updatedFavoriteBooks));
            log(updatedFavoriteBooks.toString());
          }
        } catch (e) {
          log(e.toString());
          emit(FavoriteError(e.toString()));
        }
      },
    );
    on<RemoveFromFavorite>(
      (event, emit) async {
        emit(FavoriteLoading());
        try {
          await bookRepository.deleteFavoriteBook(event.book);
          emit(FavoriteRemoved());
          log("Removed from favorite");
          final updatedFavoriteBooks =
              await bookRepository.fetchFavoriteBooks();
          log(updatedFavoriteBooks.toString());
          emit(FavoriteLoaded(updatedFavoriteBooks));
        } catch (e) {
          log(e.toString());
          emit(FavoriteError(e.toString()));
        }
      },
    );
  }
}
