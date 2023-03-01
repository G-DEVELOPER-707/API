import 'package:flutter/material.dart';
import 'package:user_infos/pages/user_posts.dart';
import 'package:user_infos/service/user_service.dart';
import '../../service/post_service.dart';
import '../items/user_item.dart';
import '../models/post_model.dart';
import '../service/utils_sevice.dart';
import '../states.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  TextEditingController userIdCtr = TextEditingController();
  TextEditingController titleCtr = TextEditingController();
  TextEditingController bodyCtr = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GetUserService.getUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueGrey,
        title: const Text(
          "Users",
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
          future: GetUserService.getUser(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, i) {
                    users.add(snapshot.data![i]);
                    return InkWell(
                        onTap:() {
                          setState(() {});
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    UsersPosts(id: snapshot.data![i].id,)),
                          );
                        },child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5.0, horizontal: 10),
                      child: userItem(context, snapshot.data![i], () {
                        userIdCtr.text = snapshot.data![i].name.toString();
                        titleCtr.text = snapshot.data![i].email;
                        bodyCtr.text = snapshot.data![i].phone;
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
                              Utils.snackBarError('Someting is wrong', context);
                            }
                          } else {
                            Utils.snackBarError(
                                'Please fill all fields', context);
                          }
                        });
                      }),
                    ));
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
