import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_api/constant/constants.dart';
import 'package:sample_api/controller/book_controller.dart';
import 'package:sample_api/widget/stars.dart';
import 'package:url_launcher/url_launcher.dart';

class BookDetailPage extends StatefulWidget {
  const BookDetailPage({required this.isbn});
  final String isbn;
  @override
  State<BookDetailPage> createState() => _BookDetailPageState();
}

class _BookDetailPageState extends State<BookDetailPage> {
  BookController bookController = BookController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bookController = Provider.of(context, listen: false);
    bookController.booksDetailResponse = null;
    bookController.fetchBookDetailApi(widget.isbn);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detail',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: appBarColor,
      ),
      body: Consumer<BookController>(
        builder: (context, value, child) => Center(
            child: bookController.booksDetailResponse == null
                ? const CircularProgressIndicator()
                : Column(
                    children: [
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              showDialog(
                                  useSafeArea: true,
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                        contentPadding: EdgeInsets.zero,
                                        content: Image.network(
                                          bookController
                                              .booksDetailResponse!.image
                                              .toString(),
                                          width: 300.0,
                                          height: 300.0,
                                          alignment: Alignment.center,
                                        ),
                                        title: Text('Image'),
                                        actions: [
                                          TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                              child: Text('Cancel'))
                                        ],
                                      ));
                            },
                            child: Image.network(
                              bookController.booksDetailResponse!.image
                                  .toString(),
                              width: 150.0,
                              height: 150.0,
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding:
                                      const EdgeInsets.only(top: 10, right: 10),
                                  child: Text(
                                    bookController.booksDetailResponse!.title
                                        .toString(),
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20.0),
                                  ),
                                ),
                                Text(
                                  bookController.booksDetailResponse!.authors
                                      .toString(),
                                  style: styleLabel1,
                                ),
                                const SizedBox(
                                  height: 5.0,
                                ),
                                Stars(
                                  rating: int.parse(bookController
                                      .booksDetailResponse!.rating
                                      .toString()),
                                ),
                                Text(
                                  bookController.booksDetailResponse!.subtitle
                                      .toString(),
                                  style: styleLabel1,
                                ),
                                Text(
                                  bookController.booksDetailResponse!.price ==
                                          "\$0.00"
                                      ? 'Free'
                                      : bookController
                                          .booksDetailResponse!.price
                                          .toString(),
                                  style: TextStyle(
                                      fontSize: 10.0,
                                      color: bookController
                                                  .booksDetailResponse!.price ==
                                              "\$0.00"
                                          ? Colors.green
                                          : Colors.red,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                        width: double.infinity,
                        child: ElevatedButton(
                            onPressed: () async {
                              final Uri uri = Uri.parse(bookController
                                  .booksDetailResponse!.url
                                  .toString());
                              try {
                                await canLaunchUrl(uri)
                                    ? launchUrl(uri)
                                    : print('Nothing');
                              } catch (e) {
                                print(e);
                              }
                            },
                            child: const Text('Buy')),
                      ),
                      Container(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, bottom: 10, top: 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                bookController.booksDetailResponse!.desc
                                    .toString(),
                                style: const TextStyle(fontSize: 13.0)),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Year : ' +
                                  bookController.booksDetailResponse!.year
                                      .toString(),
                              style: styleLabel2,
                            ),
                            Text(
                              'ISBN : ' +
                                  bookController.booksDetailResponse!.isbn13
                                      .toString(),
                              style: styleLabel2,
                            ),
                            Text(
                              bookController.booksDetailResponse!.pages
                                      .toString() +
                                  ' Pages',
                              style: styleLabel2,
                            ),
                            Text(
                              'Publisher : ' +
                                  bookController.booksDetailResponse!.publisher
                                      .toString(),
                              style: styleLabel2,
                            ),
                            Text(
                              'Language : ' +
                                  bookController.booksDetailResponse!.language
                                      .toString(),
                              style: styleLabel2,
                            ),
                          ],
                        ),
                      ),
                      const Divider(),
                      Container(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: Row(
                          children: const [
                            Text(
                              'Similiar books :',
                              textAlign: TextAlign.left,
                              style: TextStyle(fontSize: 12.0),
                            ),
                          ],
                        ),
                      ),
                      Container(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                          height: 200,
                          child: bookController.booksSearchResponse == null
                              ? const Center(child: CircularProgressIndicator())
                              : ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: bookController
                                      .booksSearchResponse!.books.length,
                                  itemBuilder: (context, index) {
                                    final book = bookController
                                        .booksSearchResponse!.books[index];
                                    return GestureDetector(
                                      onTap: () {
                                        Navigator.pop(context);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  BookDetailPage(
                                                    isbn: book.isbn13,
                                                  )),
                                        );
                                      },
                                      child: Container(
                                        width: 80,
                                        child: Column(
                                          children: [
                                            Image.network(
                                              book.image,
                                              width: 100,
                                              height: 100,
                                            ),
                                            Text(
                                              book.title,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              textAlign: TextAlign.center,
                                              style: const TextStyle(
                                                  fontSize: 10.0),
                                            )
                                          ],
                                        ),
                                      ),
                                    );
                                  })),
                    ],
                  )),
      ),
    );
  }
}
