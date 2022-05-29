import 'package:sample_api/model/book_detail.dart';
import 'package:sample_api/model/book_search.dart';

import 'package:sample_api/model/books.dart';
import 'package:sample_api/repository/books_repository.dart';

class BookService {
  BooksRepository? booksRepository = BooksRepository();

  Future<BooksResponse> getBooksCatalogue() async {
    BooksResponse? booksResponse = await booksRepository!.allBookCatalogue();
    booksResponse!.books.forEach((element) {
      print(element.title);
    });
    return booksResponse;
  }

  Future<BooksDetailResponse> getBookDetail(String isbn) async {
    BooksDetailResponse? booksResponse =
        await booksRepository!.bookDetail(isbn);
    return booksResponse!;
  }

  Future<BookSearch> getAllBookSearch(String title) async {
    BookSearch? booksResponse =
        await booksRepository!.allBookSearchResult(title);
    return booksResponse!;
  }
}
