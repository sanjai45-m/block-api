part of 'posts_bloc.dart';

@immutable
sealed class PostsEvent {}

class InitialFetchEvent extends PostsEvent{}
class PostAddedEvent extends PostsEvent{
  
}
