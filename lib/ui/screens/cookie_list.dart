import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_projects/models/cookie_lawyer.dart' as model;

class CookiesList extends StatefulWidget {
  List<model.CookieLawyer> cookiesList = [];

  CookiesList({Key? key, required this.cookiesList}) : super(key: key);

  @override
  State<CookiesList> createState() => _CookiesListState();
}

class _CookiesListState extends State<CookiesList> {
  final GlobalKey<AnimatedListState> listKey = GlobalKey<AnimatedListState>();

  Tween<Offset> offset = Tween(begin: const Offset(1,0), end: const Offset(0,0));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
            color: Colors.black
        ),
        backgroundColor: Colors.white,
        title: const Text(
          'Lawyers list',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: AnimatedList(
        key: listKey,
        padding: const EdgeInsets.all(8),
        initialItemCount: widget.cookiesList.length,
        itemBuilder: (context, index, animation) {
          return getSlideItWidget(context, index, animation);
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          model.CookieLawyer cookieLawyer = model.CookieLawyer(id: 5);
        listKey.currentState?.insertItem(0,
            duration: const Duration(milliseconds: 500));
        widget.cookiesList = [cookieLawyer, ...widget.cookiesList];
      },
      ),
    );
  }

  Widget getSlideItWidget(BuildContext context, int index, animation) {
    model.CookieLawyer item = widget.cookiesList[index];
    return SizeTransition(
      sizeFactor: animation,
      child: SizedBox( // Actual widget to display
        height: 100.0,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Center(
              child: Text('$item'),
            ),
          ),
        ),
      ),
    );
  }
}