import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_api/controller/book_controller.dart';
import 'package:sample_api/view/booklist_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => BookController(),
      child: const MaterialApp(
        home: BookListPage(),
      ),
    );
  }
}
