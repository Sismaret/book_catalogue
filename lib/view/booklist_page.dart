import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_api/constant/constants.dart';
import 'package:sample_api/controller/book_controller.dart';
import 'package:sample_api/model/books.dart';
import 'package:sample_api/services/books_service.dart';
import 'package:sample_api/view/bookdetail_page.dart';
import 'package:sample_api/widget/box_card.dart';

class BookListPage extends StatefulWidget {
  const BookListPage({Key? key}) : super(key: key);

  @override
  State<BookListPage> createState() => _BookListPageState();
}

class _BookListPageState extends State<BookListPage> {
  BookController? bookController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bookController = Provider.of(context, listen: false);
    bookController!.fetchBookCatalogueApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Book Catalogue',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: appBarColor,
      ),
      body: Consumer<BookController>(
        builder: (context, value, child) => Container(
            child: bookController!.booksResponse == null
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    itemCount: bookController!.booksResponse!.books.length,
                    itemBuilder: (context, index) {
                      final book = bookController!.booksResponse!.books[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => BookDetailPage(
                                      isbn: book.isbn13,
                                    )),
                          );
                        },
                        child: BoxCard.title(
                          imageUrl: book.image,
                          title: book.title,
                          subTitle: book.subtitle,
                          price: book.price == "\$0.00" ? 'Free' : book.price,
                        ),
                      );
                    })),
      ),
    );
  }
}
