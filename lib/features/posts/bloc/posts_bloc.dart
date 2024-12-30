import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:block_api/features/posts/mappers/posts_network_repo.dart';
import 'package:block_api/features/posts/models/post_data_ui_model.dart';
import 'package:flutter/foundation.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;
part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  PostsBloc() : super(PostsInitial()) {
    on<InitialFetchEvent>(initialFetchEvent);
    on<PostAddedEvent>(postAddedEvent);
  }

  FutureOr<void> initialFetchEvent(
      InitialFetchEvent event, Emitter<PostsState> emit) async {
    emit(PostsLoading());
    List<PostDataUiModel> posts = await PostsNetworkRepo.fetchPosts();
    emit(PostsSuccess(posts));
  }

  FutureOr<void> postAddedEvent(PostAddedEvent event, Emitter<PostsState> emit) async {
    bool success =await PostsNetworkRepo.addEvent();
    if (kDebugMode) {
      print(success);
    }
    if(success){
      emit(PostAddedSuccess());
  }
  else{
    emit(PostAddedFailed());
  }
  }
}
