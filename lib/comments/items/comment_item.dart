

import 'package:flutter/material.dart';
import 'package:user_infos/service/post_service.dart';


import '../../../service/utils_sevice.dart';
import '../models/employe_model.dart';

Widget CommentItem(BuildContext context, CommentModel comment,void Function() edit) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        comment.email,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
            fontWeight: FontWeight.w700, fontSize: 24, color: Colors.black),
      ),
      const SizedBox(
        height: 5,
      ),
      Row(
        children: [
          Expanded(
            child: Text(
              comment.body,
              maxLines: 6,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: Colors.black38),
            ),
          ),
          Column(
            children: [
              IconButton(
                onPressed: () {edit();},
                icon: Icon(Icons.edit),
              ),
              const SizedBox(
                height: 10,
              ),
              IconButton(
                onPressed: () async {
                  bool result = await GetPostService.deletePost(comment.id);

                  if (result) {
                    Utils.snackBarSuccess('Deleted successfully', context);
                  } else {
                    Utils.snackBarError('Someting is wrong', context);
                  }
                },
                icon: Icon(Icons.delete),
              ),
            ],
          )
        ],
      ),
      const Divider(
        thickness: 3,
      )
    ],
  );
}