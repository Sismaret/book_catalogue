import 'package:flutter/cupertino.dart';
import 'package:sample_api/model/book_detail.dart';
import 'package:sample_api/model/book_search.dart';
import 'package:sample_api/model/books.dart';
import 'package:sample_api/services/books_service.dart';

class BookController extends ChangeNotifier {
  BooksResponse? booksResponse;
  BooksDetailResponse? booksDetailResponse;
  BookSearch? booksSearchResponse;

  void fetchBookCatalogueApi() async {
    BookService? bookService = BookService();
    booksResponse = await bookService.getBooksCatalogue();
    notifyListeners();
  }

  void fetchBookDetailApi(isbn) async {
    BookService? bookService = BookService();
    booksDetailResponse = await bookService.getBookDetail(isbn);
    booksSearchResponse = await bookService
        .getAllBookSearch(booksDetailResponse!.title.toString());
    notifyListeners();
  }
}
