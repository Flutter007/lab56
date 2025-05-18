import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/post.dart';
import '../provider/post_provider.dart';

class SinglePostInfoScreen extends StatefulWidget {
  const SinglePostInfoScreen({super.key});

  @override
  State<SinglePostInfoScreen> createState() => _SinglePostInfoScreenState();
}

class _SinglePostInfoScreenState extends State<SinglePostInfoScreen> {
  late String id;
  late PostProvider postProvider;
  Post? post;
  final dateTime = DateFormat('MM d,y,HH:mm');
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      id = ModalRoute.of(context)!.settings.arguments as String;
      postProvider = context.read<PostProvider>();
      await postProvider.getPost(id);
      post = postProvider.post;
    });
  }

  @override
  void dispose() {
    context.read<PostProvider>().clearPosts();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final postProvider = context.watch<PostProvider>();
    return postProvider.isFetching
        ? Scaffold(
          appBar: AppBar(title: Text('Loading...')),
          body: Center(child: CircularProgressIndicator()),
        )
        : Scaffold(
          appBar: AppBar(title: Text(post!.header)),
          body: Column(
            children: [
              Text(post!.body),
              Text(dateTime.format(post!.createdAt)),
            ],
          ),
        );
  }
}
