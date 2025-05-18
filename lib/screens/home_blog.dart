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

  void goToEditForm() {
    Navigator.of(context).pushNamed(AppRoutes.edit);
  }

  void goToPostInfo(String id) {
    Navigator.of(context).pushNamed(AppRoutes.singlePost, arguments: id);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    postProvider = context.read<PostProvider>();
  }

  void deletePost(String id) async {
    try {
      await postProvider.deletePost(id);
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Post deleted!')));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Something went wrong!')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final postProvider = context.watch<PostProvider>();
    bool isLoading =
        postProvider.isFetching ||
        postProvider.isCreating ||
        postProvider.isDeleting;
    Widget body;
    if (isLoading) {
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
                      onLongPress: goToEditForm,
                      deletePost: () => deletePost(postProvider.posts[i].id!),
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
