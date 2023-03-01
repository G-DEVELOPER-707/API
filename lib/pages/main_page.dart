import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:user_infos/pages/albums_page.dart';
import 'package:user_infos/pages/posts_page.dart';
import 'package:user_infos/pages/search_page.dart';
import 'package:user_infos/states.dart';

class MainView extends StatefulWidget {
  const MainView({Key? key}) : super(key: key);

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  final _pages = [
    const PostsPage(),
    const SearchPage(),
    const AlbumsPage(),
  ];

  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[currentPage],
      backgroundColor: Colors.brown,
      bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.brown,
          currentIndex: currentPage,
          onTap: (i) {
            setState(() {});
            currentPage = i;
            if (i != 1) {
              users.clear();
              setState(() {

              });
            }
          },
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.orangeAccent,
          unselectedItemColor: Colors.black,
          selectedIconTheme: const IconThemeData(size: 30),
          // selectedFontSize: 14,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: "Posts",
            ),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: "Users"),
            BottomNavigationBarItem(
                icon: Icon(Icons.photo_album_sharp), label: "Albums"),
          ]),
    );
  }
}
