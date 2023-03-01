import 'package:dio/dio.dart';
import 'package:user_infos/models/photo_model.dart';
import 'package:user_infos/models/photo_model.dart';
import 'package:user_infos/models/photo_model.dart';
import 'package:user_infos/models/photo_model.dart';
import 'package:user_infos/models/photo_model.dart';

import '../config/dio_config.dart';
import '../dio_network/api.dart';
import '../models/post_model.dart';
import 'log_service.dart';

class GetPhotoService {
  static final GetPhotoService _inheritance = GetPhotoService._init();

  static GetPhotoService get inheritance => _inheritance;

  GetPhotoService._init();

  static Future<List<PhotoModel>?> getPhoto() async {
    try {
      Response res =
      await DioConfig.inheritance.createRequest().get(Urls.getPhotos);
      Log.i(res.data.toString());
      Log.i(res.statusCode.toString());

      if (res.statusCode == 200) {
        List<PhotoModel> userList = [];
        for (var e in (res.data as List)) {
          userList.add(PhotoModel.fromJson(e));
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

  // static Future<bool> createPost(PhotoModel newPost) async {
  //   try {
  //     Response res = await DioConfig.inheritance
  //         .createRequest()
  //         .post(Urls.addPost, data: {
  //       "userId": newPost.userId,
  //       "title": newPost.title,
  //       "body": newPost.body
  //     });
  //     Log.i(res.data.toString());
  //     Log.i(res.statusCode.toString());
  //
  //     if (res.statusCode == 200 || res.statusCode == 201) {
  //       return true;
  //     } else {
  //       Log.e("${res.statusMessage} ${res.statusCode}");
  //       return false;
  //     }
  //   } on DioError catch (e) {
  //     if (e.response != null) {
  //       Log.e(e.response!.toString());
  //       return false;
  //     } else {
  //       rethrow;
  //     }
  //   } catch (e) {
  //     Log.e(e.toString());
  //     return false;
  //   }
  // }
  //
  // static Future<bool> editPost(PhotoModel newPost) async {
  //   try {
  //     Response res = await DioConfig.inheritance
  //         .createRequest()
  //         .put(Urls.updatePost + newPost.id.toString(), data: {
  //       "userId": newPost.userId,
  //       "title": newPost.title,
  //       "body": newPost.body
  //     });
  //     Log.i(res.data.toString());
  //     Log.i(res.statusCode.toString());
  //
  //     if (res.statusCode == 200 || res.statusCode == 201) {
  //       return true;
  //     } else {
  //       Log.e("${res.statusMessage} ${res.statusCode}");
  //       return false;
  //     }
  //   } on DioError catch (e) {
  //     if (e.response != null) {
  //       Log.e(e.response!.toString());
  //       return false;
  //     } else {
  //       rethrow;
  //     }
  //   } catch (e) {
  //     Log.e(e.toString());
  //     return false;
  //   }
  // }
  //
  // static Future<bool> deletePost(int id) async {
  //   try {
  //     Response res = await DioConfig.inheritance
  //         .createRequest()
  //         .put(Urls.deletePost + id.toString(),);
  //     Log.i(res.data.toString());
  //     Log.i(res.statusCode.toString());
  //
  //     if (res.statusCode == 200 || res.statusCode == 201) {
  //       return true;
  //     } else {
  //       Log.e("${res.statusMessage} ${res.statusCode}");
  //       return false;
  //     }
  //   } on DioError catch (e) {
  //     if (e.response != null) {
  //       Log.e(e.response!.toString());
  //       return false;
  //     } else {
  //       rethrow;
  //     }
  //   } catch (e) {
  //     Log.e(e.toString());
  //     return false;
  //   }
  // }


}
