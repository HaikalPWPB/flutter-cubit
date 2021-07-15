part of 'post_cubit.dart';

abstract class PostState extends Equatable {
  const PostState();

  @override
  List<Object> get props => [];
}

class PostInitial extends PostState {}

class PostLoading extends PostState {}

class PostListLoaded extends PostState {
  PostListLoaded(this.posts);
  
  final List<PostModel> posts;

  @override
  List<Object> get props => [posts];
}

class PostLoaded extends PostState {
  PostLoaded(this.post);
  final PostModel post;

  @override
  List<Object> get props => [post];
}

class PostError extends PostState {}
