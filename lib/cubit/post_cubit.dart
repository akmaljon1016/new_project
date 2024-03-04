import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:new_project/model/post.dart';
import 'package:new_project/network_info.dart';

part 'post_state.dart';

class PostCubit extends Cubit<PostState> {
  final Dio dio;
  final NetworkInfo networkInfo;

  PostCubit({required this.dio, required this.networkInfo})
      : super(PostInitial());

  void downloadPosts() async {
    emit(PostLoading());
    if (await networkInfo.isConnected) {
      try {
        var response =
            await dio.get("https://jsonplaceholder.typicode.com/posts");
        emit(PostSuccess(list: listFromJson(response.data)));
      } catch (e) {
        emit(PostError(message: e.toString()));
      }
    } else {
      emit(PostError(message: "Internet yo'q"));
    }
  }
}
