import 'package:flutter/material.dart';
import 'package:lab56/provider/post_provider.dart';
import 'package:lab56/widgets/post_card.dart';
import 'package:provider/provider.dart';

import '../app_routes.dart';

class HomeBlog extends StatefulWidget {
  const HomeBlog({super.key});

  @override
  State<HomeBlog> createState() => _HomeBlogState();
}

class _HomeBlogState extends State<HomeBlog> {
  late PostProvider postProvider;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PostProvider>().fetchPosts();
    });
  }

  void goToPostForm() {
    Navigator.of(context).pushNamed(AppRoutes.create);
  }

  void goToPostInfo(String id) {
    Navigator.of(context).pushNamed(AppRoutes.singlePost, arguments: id);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    postProvider = context.read<PostProvider>();
  }

  @override
  Widget build(BuildContext context) {
    final postProvider = context.watch<PostProvider>();
    Widget body;
    if (postProvider.isFetching || postProvider.isCreating) {
      body = Center(child: CircularProgressIndicator());
    } else if (postProvider.isError) {
      body = Center(child: Text('Error'));
    } else if (postProvider.posts.isEmpty) {
      body = Center(child: Text('No posts'));
    } else {
      body = Center(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemBuilder:
                    (ctx, i) => PostCard(
                      post: postProvider.posts[i],
                      onTap: () => goToPostInfo(postProvider.posts[i].id!),
                      onLongPress: goToPostForm,
                    ),
                itemCount: postProvider.posts.length,
              ),
            ),
          ],
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Blog Feed'),
        actions: [IconButton(onPressed: goToPostForm, icon: Icon(Icons.add))],
      ),
      body: body,
    );
  }
}
