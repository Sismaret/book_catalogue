import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:sample_api/constant/constants.dart';
import 'package:sample_api/model/book_detail.dart';
import 'package:sample_api/model/book_search.dart';
import 'package:sample_api/model/books.dart';

class BooksRepository {
  BooksResponse? _booksResponse;
  BooksDetailResponse? _booksDetailResponse;
  BookSearch? _bookSearch;

  Future<BooksResponse?> allBookCatalogue() async {
    var url = Uri.parse(urlCatalogueBook);
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        _booksResponse = BooksResponse.fromJson(result);
      }
    } catch (e) {
      print(e);
    }
    return _booksResponse;
  }

  Future<BooksDetailResponse?> bookDetail(String isbn) async {
    var url = Uri.parse(urlBookDetail + isbn);
    try {
      var responseDetail = await http.get(url);
      if (responseDetail.statusCode == 200) {
        var resultDetail = jsonDecode(responseDetail.body);
        _booksDetailResponse = BooksDetailResponse.fromJson(resultDetail);
      }
    } catch (e) {
      print(e);
    }
    return _booksDetailResponse;
  }

  Future<BookSearch?> allBookSearchResult(String title) async {
    var url = Uri.parse(urlSearchBook + title);
    try {
      var responseSearch = await http.get(url);
      if (responseSearch.statusCode == 200) {
        var resultSearch = jsonDecode(responseSearch.body);
        _bookSearch = BookSearch.fromJson(resultSearch);
      }
    } catch (e) {
      print(e);
    }
    return _bookSearch;
  }
}
