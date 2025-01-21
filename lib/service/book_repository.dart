import 'dart:convert';

import 'package:day_1/model/book.dart';
import 'package:shared_preferences/shared_preferences.dart';

class BookRepository {
  static const String _bookKey = 'book_list';

  Future<List<Book>> fetchFavoriteBooks() async {
    final prefs = await SharedPreferences.getInstance();
    final String? bookJsonString = prefs.getString(_bookKey);

    if (bookJsonString != null) {
      List<dynamic> decodedJson = jsonDecode(bookJsonString);
      List<Book> favoriteBooks =
          decodedJson.map((json) => Book.fromJson(json)).toList();
      return favoriteBooks;
    } else {
      return [];
    }
  }

  Future<void> addFavoriteBook(Book book) async {
    final prefs = await SharedPreferences.getInstance();
    final List<Book> favoriteBooks = await fetchFavoriteBooks();
    favoriteBooks.add(book);

    final String updatedBookJsonString = jsonEncode(favoriteBooks
        .map(
          (favoriteBook) => favoriteBook.toJson(),
        )
        .toList());
    await prefs.setString(_bookKey, updatedBookJsonString);
  }

  Future<void> deleteFavoriteBook(Book book) async {
    final prefs = await SharedPreferences.getInstance();
    final List<Book> favoriteBooks = await fetchFavoriteBooks();
    favoriteBooks.removeWhere(
      (favoriteBook) => favoriteBook == book,
    );
    final String updatedBookJsonString = jsonEncode(favoriteBooks
        .map(
          (favoriteBook) => favoriteBook.toJson(),
        )
        .toList());
    await prefs.setString(_bookKey, updatedBookJsonString);
  }
}
