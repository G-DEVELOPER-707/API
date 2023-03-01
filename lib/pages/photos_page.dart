import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:user_infos/items/photo_item.dart';
import 'package:user_infos/service/photo_service.dart';

class PhotosPage extends StatefulWidget {
  const PhotosPage({Key? key}) : super(key: key);

  @override
  State<PhotosPage> createState() => _PhotosPageState();
}

class _PhotosPageState extends State<PhotosPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GetPhotoService.getPhoto();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Photos"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8),
        child: FutureBuilder(
          future: GetPhotoService.getPhoto(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return GridView.builder(
                itemCount: snapshot.data!.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                itemBuilder: (BuildContext context, int index) {
                  return photoItem(snapshot.data![index]);
                },
              );
            }
            ;
            return const Center(
              child: Text("No data"),
            );
          },
        ),
      ),
    );
  }
}
