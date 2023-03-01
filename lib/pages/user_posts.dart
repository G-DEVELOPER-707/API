import 'package:flutter/material.dart';
import 'package:user_infos/service/user_service.dart';
import '../../service/post_service.dart';
import '../items/user_item.dart';
import '../models/post_model.dart';
import '../screen/Home/widgets/post_item.dart';
import '../service/utils_sevice.dart';

class UsersPosts extends StatefulWidget {
  UsersPosts({required this.id, Key? key}) : super(key: key);
  int id;

  @override
  State<UsersPosts> createState() => _UsersPostsState();
}

class _UsersPostsState extends State<UsersPosts> {
  TextEditingController userIdCtr = TextEditingController();
  TextEditingController titleCtr = TextEditingController();
  TextEditingController bodyCtr = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GetUserService.getUserPosts(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Text(
          "User's posts",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            onPressed: () {
              _showBottomSheet(context, () async {
                if (userIdCtr.text.isNotEmpty &&
                    titleCtr.text.isNotEmpty &&
                    bodyCtr.text.isNotEmpty) {
                  PostModel newPost = PostModel(
                      userId: int.parse(userIdCtr.text),
                      id: 1,
                      title: titleCtr.text,
                      body: bodyCtr.text);
                  bool result = await GetPostService.createPost(newPost);

                  if (result) {
                    Utils.snackBarSuccess('Added successfully', context);
                    Navigator.pop(context);
                  } else {
                    Utils.snackBarError('Someting is wrong', context);
                  }
                } else {
                  Utils.snackBarError('Please fill all fields', context);
                }
              });
            },
            icon: const Icon(Icons.add),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder(
          future: GetUserService.getUserPosts(widget.id),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, i) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5.0, horizontal: 10),
                      child: postItem(
                          context,
                          snapshot.data![i],
                          () {
                            userIdCtr.text =
                                snapshot.data![i].userId.toString();
                            titleCtr.text = snapshot.data![i].title;
                            bodyCtr.text = snapshot.data![i].body;
                            _showBottomSheet(context, () async {
                              if (userIdCtr.text.isNotEmpty &&
                                  titleCtr.text.isNotEmpty &&
                                  bodyCtr.text.isNotEmpty) {
                                PostModel newPost = PostModel(
                                    userId: int.parse(userIdCtr.text),
                                    id: snapshot.data![i].id,
                                    title: titleCtr.text,
                                    body: bodyCtr.text);
                                bool result =
                                    await GetPostService.editPost(newPost);

                                if (result) {
                                  Utils.snackBarSuccess(
                                      'Edited successfully', context);
                                  Navigator.pop(context);
                                } else {
                                  Utils.snackBarError(
                                      'Someting is wrong', context);
                                }
                              } else {
                                Utils.snackBarError(
                                    'Please fill all fields', context);
                              }
                            });
                          },
                          () {},
                          () {
                            snapshot.data![i].isLiked =
                                !snapshot.data![i].isLiked;
                            setState(() {

                            });
                          }),
                    );
                  });
            } else {
              return const Center(
                child: Text('No data'),
              );
            }
          },
        ),
      ),
    );
  }

  void _showBottomSheet(BuildContext context, void Function() func) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                //mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  const Text(
                    'Add new post',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 20.0),
                  ),
                  TextFormField(
                    controller: userIdCtr,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(labelText: 'UserID'),
                  ),
                  TextFormField(
                    controller: titleCtr,
                    decoration: const InputDecoration(labelText: 'Title'),
                  ),
                  TextFormField(
                    controller: bodyCtr,
                    decoration: const InputDecoration(labelText: 'Body'),
                  ),
                  ElevatedButton(
                    onPressed: func,
                    child: const Text('Add'),
                  ),
                  const SizedBox(
                    height: 400,
                  )
                ],
              ),
            ),
          );
        });
  }
}
