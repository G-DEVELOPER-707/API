import 'package:dio/dio.dart';

import '../../config/dio_config.dart';
import '../../dio_network/api.dart';
import '../../service/log_service.dart';
import '../dio_network_com/api.dart';
import '../models/employe_model.dart';



class GetCommentService {
  static final GetCommentService _inheritance = GetCommentService._init();

  static GetCommentService get inheritance => _inheritance;

  GetCommentService._init();

  static Future<List<CommentModel>?> getComment() async {
    try {
      Response res =
      await DioConfig.inheritance.createRequest().get(Urls2.getComment);
      Log.i(res.data.toString());
      Log.i(res.statusCode.toString());

      if (res.statusCode == 200) {
        List<CommentModel> userList = [];
        for (var e in (res.data as List)) {
          userList.add(CommentModel.fromJson(e));
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

  static Future<bool> createComment(CommentModel newComment) async {
    try {
      Response res = await DioConfig.inheritance
          .createRequest()
          .post(Urls2.addComment, data: {
        "postId": newComment.postId,
        "name": newComment.name,
        "email":newComment.name,
        "body":newComment.body
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

  static Future<bool> editComment(CommentModel newComment) async {
    try {
      Response res = await DioConfig.inheritance
          .createRequest()
          .put(Urls2.updateComment + newComment.id.toString(), data: {
        "postId": newComment.postId,
        "if": newComment.id,
        "name": newComment.name,
        "email":newComment.name,
        "body":newComment.body
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

  static Future<bool> deleteComment(int id) async {
    try {
      Response res = await DioConfig.inheritance
          .createRequest()
          .put(Urls2.deleteComment + id.toString(),);
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
  static Future<List<CommentModel>?> getPostComment(int postId) async {
    try {
      Response res =
      await DioConfig.inheritance.createRequest().get(Urls2.getPostComment+postId.toString());
      Log.i(res.data.toString());
      Log.i(res.statusCode.toString());

      if (res.statusCode == 200) {
        List<CommentModel> userList = [];
        for (var e in (res.data as List)) {
          userList.add(CommentModel.fromJson(e));
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