import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:user_infos/service/post_service.dart';

import '../../../comments/items/comment_item.dart';
import '../../../comments/service/comment_service.dart';
import '../../../models/post_model.dart';
import '../../../service/utils_sevice.dart';

Widget postItem(BuildContext context, PostModel post, void Function() edit,
    void Function() getId,void Function()isLiked) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        post.title,
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
              post.body,
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
                onPressed: () {
                  edit();
                },
                icon: Icon(Icons.edit),
              ),
              const SizedBox(
                height: 10,
              ),
              IconButton(
                onPressed: () async {
                  bool result = await GetPostService.deletePost(post.id);

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
      SizedBox(
        height: 10,
      ),
      Row(
        children: [
          InkWell(
              onTap: () {
                isLiked();
              },
              child: post.isLiked == false
                  ? Icon(CupertinoIcons.heart)
                  : Icon(
                      Icons.favorite,
                      color: Colors.red,
                    )),
          SizedBox(
            width: 17,
          ),
          InkWell(
            onTap: () {
              showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: FutureBuilder(
                        future: GetCommentService.getPostComment(post.id),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return ListView.builder(
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, i) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5.0, horizontal: 10),
                                    child: CommentItem(
                                        context, snapshot.data![i], () {}),
                                  );
                                });
                          } else {
                            return const Center(
                              child: Text('Loading...'),
                            );
                          }
                        },
                      ),
                    );
                  });
            },
            child: Icon(Icons.mode_comment_outlined),
          ),
          SizedBox(
            width: 17,
          ),
          InkWell(
            onTap: () {},
            child: Icon(Icons.send),
          ),
          SizedBox(
            width: 17,
          ),
        ],
      ),
      const Divider(
        thickness: 3,
      )
    ],
  );
}
