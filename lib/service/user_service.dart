import 'package:dio/dio.dart';
import 'package:user_infos/models/user_model.dart';

import '../config/dio_config.dart';
import '../dio_network/api.dart';
import '../models/post_model.dart';
import 'log_service.dart';

class GetUserService {
  static final GetUserService _inheritance = GetUserService._init();

  static GetUserService get inheritance => _inheritance;

  GetUserService._init();

  static Future<List<UserModel>?> getUser() async {
    try {
      Response res =
      await DioConfig.inheritance.createRequest().get(Urls.getUser);
      Log.i(res.data.toString());
      Log.i(res.statusCode.toString());

      if (res.statusCode == 200) {
        List<UserModel> userList = [];
        for (var e in (res.data as List)) {
          userList.add(UserModel.fromJson(e));
        }

        return userList;
      } else {
        Log.e("${res.statusMessage} ${res.statusCode}");
      }
    } on DioError catch (e) {
      if (e.response != null) {
        Log.e(e.response!.toString());
      } else {
        rethrow;
      }
    } catch (e) {
      Log.e(e.toString());
    }
    return null;
  }

  static Future<bool> createUser(PostModel newPost) async {
    try {
      Response res = await DioConfig.inheritance
          .createRequest()
          .post(Urls.addPost, data: {
        "userId": newPost.userId,
        "title": newPost.title,
        "body": newPost.body
      });
      Log.i(res.data.toString());
      Log.i(res.statusCode.toString());

      if (res.statusCode == 200 || res.statusCode == 201) {
        return true;
      } else {
        Log.e("${res.statusMessage} ${res.statusCode}");
        return false;
      }
    } on DioError catch (e) {
      if (e.response != null) {
        Log.e(e.response!.toString());
        return false;
      } else {
        rethrow;
      }
    } catch (e) {
      Log.e(e.toString());
      return false;
    }
  }

  static Future<bool> editUser(PostModel newPost) async {
    try {
      Response res = await DioConfig.inheritance
          .createRequest()
          .put(Urls.updatePost + newPost.id.toString(), data: {
        "userId": newPost.userId,
        "title": newPost.title,
        "body": newPost.body
      });
      Log.i(res.data.toString());
      Log.i(res.statusCode.toString());

      if (res.statusCode == 200 || res.statusCode == 201) {
        return true;
      } else {
        Log.e("${res.statusMessage} ${res.statusCode}");
        return false;
      }
    } on DioError catch (e) {
      if (e.response != null) {
        Log.e(e.response!.toString());
        return false;
      } else {
        rethrow;
      }
    } catch (e) {
      Log.e(e.toString());
      return false;
    }
  }

  static Future<bool> deleteUser(int id) async {
    try {
      Response res = await DioConfig.inheritance.createRequest().put(
        Urls.deletePost + id.toString(),
      );
      Log.i(res.data.toString());
      Log.i(res.statusCode.toString());

      if (res.statusCode == 200 || res.statusCode == 201) {
        return true;
      } else {
        Log.e("${res.statusMessage} ${res.statusCode}");
        return false;
      }
    } on DioError catch (e) {
      if (e.response != null) {
        Log.e(e.response!.toString());
        return false;
      } else {
        rethrow;
      }
    } catch (e) {
      Log.e(e.toString());
      return false;
    }
  }
  static Future<List<PostModel>?> getUserPosts(int id) async {
    try {
      Response res =
      await DioConfig.inheritance.createRequest().get('${Urls.getPosts}?userId=$id');
      Log.i(res.data.toString());
      Log.i(res.statusCode.toString());

      if (res.statusCode == 200) {
        List<PostModel> userList = [];
        for (var e in (res.data as List)) {
          userList.add(PostModel.fromJson(e));
        }

        return userList;
      } else {
        Log.e("${res.statusMessage} ${res.statusCode}");
      }
    } on DioError catch (e) {
      if (e.response != null) {
        Log.e(e.response!.toString());
      } else {
        rethrow;
      }
    } catch (e) {
      Log.e(e.toString());
    }
    return null;
  }
}