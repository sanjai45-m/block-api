part of 'posts_bloc.dart';

@immutable
sealed class PostsState {}

abstract class PostActionState extends PostsState {}

final class PostsInitial extends PostsState {}

final class PostsLoading extends PostsState {}

final class PostsLoadedFailed extends PostsState {
  final String message;

  PostsLoadedFailed({required this.message});
  
}

final class PostsSuccess extends PostsState {
  final List<PostDataUiModel> posts;

  PostsSuccess(this.posts);
}


final class PostAddedSuccess extends PostActionState {}
final class PostAddedFailed extends PostActionState {}