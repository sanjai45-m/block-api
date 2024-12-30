import 'package:block_api/features/posts/bloc/posts_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final PostsBloc postsBloc = PostsBloc();
  @override
  void initState() {
    postsBloc.add(InitialFetchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Posts Page'),
        ),
        floatingActionButton: FloatingActionButton(onPressed: () {
          postsBloc.add(PostAddedEvent());
        },
        child: const Icon(Icons.add),),
        body: BlocConsumer<PostsBloc, PostsState>(
          bloc: postsBloc,
          listener: (context, state) {},
          listenWhen: (previous, current) => current is PostActionState,
          buildWhen: (previous, current) => current is! PostActionState,
          builder: (context, state) {
            switch (state.runtimeType) {
              case const (PostsLoading):
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case const (PostsSuccess):
                final successState = state as PostsSuccess;
                return ListView.builder(
                  itemCount: successState.posts.length,
                  itemBuilder: (context, index) {
                    final post = successState.posts[index];
                    return Container(
                      margin: const EdgeInsets.all(16),
                      padding: const EdgeInsets.all(16),
                      color: Colors.grey.shade200,
                      child: ListTile(
                        title: Text(post.title!),
                        subtitle: Text(post.body!),
                      ),
                    );
                  },
                );

              default:
                return const Center(
                  child: Text("We get back to you soon"),
                );
            }
          },
        ));
  }
}
