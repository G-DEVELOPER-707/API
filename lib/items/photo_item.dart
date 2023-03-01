import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:user_infos/models/photo_model.dart';

Widget photoItem(PhotoModel photo) {
  return Container(
    margin: EdgeInsets.all(8),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: CupertinoColors.white,
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 2,
          blurRadius: 5,
          offset: Offset(0, 3),
        ),
      ],
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.network(
          photo.url,
          height: 100,
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          photo.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontSize: 16),
        )
      ],
    ),
  );
}
