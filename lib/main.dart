

import 'package:flutter/material.dart';
import 'package:user_infos/pages/albums_page.dart';
import 'package:user_infos/pages/comment_page.dart';
import 'package:user_infos/pages/main_page.dart';
import 'package:user_infos/pages/posts_page.dart';
import 'package:user_infos/pages/photos_page.dart';
import 'package:user_infos/pages/user_posts.dart';
import 'package:user_infos/pages/users_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MainView(),routes: {
        '/Posts':(context)=>PostsPage(),
      '/Photos':(context)=>PhotosPage(),
      '/Users':(context)=>UserPage(),
      '/Albums':(context)=>AlbumsPage(),
    },
    );
  }
}
