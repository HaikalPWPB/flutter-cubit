import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:learn_cubit/model/post_model.dart';
import 'package:learn_cubit/resources/post_repository.dart';

part 'post_state.dart';

class PostCubit extends Cubit<PostState> {
  PostCubit({required this.repository}) : super(PostInitial()) {
    getPosts();
  }

  final PostRepository repository;

  Future<List<PostModel>?> getPosts() async {
    try {
      emit(PostLoading());
      final posts = await repository.getPostsFromAPI();
      emit(PostListLoaded(posts));
    } catch (e) {
      emit(PostError());
    }
  }

  Future<PostModel?> storePost(data) async {
    try {
      emit(PostLoading());
      final post = await repository.storePostToAPI(data);
      emit(PostLoaded(post));
    }catch(e) {
      emit(PostError());
    }
  }

}
