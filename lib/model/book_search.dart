import 'dart:convert';

BookSearch bookSearchFromJson(String str) =>
    BookSearch.fromJson(json.decode(str));

String bookSearchToJson(BookSearch data) => json.encode(data.toJson());

class BookSearch {
  BookSearch({
    required this.error,
    required this.total,
    required this.page,
    required this.books,
  });

  String error;
  String total;
  String page;
  List<Book> books;

  factory BookSearch.fromJson(Map<String, dynamic> json) => BookSearch(
        error: json["error"],
        total: json["total"],
        page: json["page"],
        books: List<Book>.from(json["books"].map((x) => Book.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "total": total,
        "page": page,
        "books": List<dynamic>.from(books.map((x) => x.toJson())),
      };
}

class Book {
  Book({
    required this.title,
    required this.subtitle,
    required this.isbn13,
    required this.price,
    required this.image,
    required this.url,
  });

  String title;
  String subtitle;
  String isbn13;
  String price;
  String image;
  String url;

  factory Book.fromJson(Map<String, dynamic> json) => Book(
        title: json["title"],
        subtitle: json["subtitle"],
        isbn13: json["isbn13"],
        price: json["price"],
        image: json["image"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "subtitle": subtitle,
        "isbn13": isbn13,
        "price": price,
        "image": image,
        "url": url,
      };
}
