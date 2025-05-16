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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PostProvider>().post == null;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    id = ModalRoute.of(context)!.settings.arguments as String;
    postProvider = context.read<PostProvider>();
    postProvider.getPost(id);
    post = postProvider.post;
  }

  @override
  void dispose() {
    postProvider.post = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final postProvider = context.watch<PostProvider>();
    return postProvider.post != null
        ? Scaffold(
          appBar: AppBar(title: Text(post!.header)),
          body: Column(
            children: [
              Text(post!.body),
              Text(dateTime.format(post!.createdAt)),
            ],
          ),
        )
        : Scaffold(
          appBar: AppBar(title: Text('Loading...')),
          body: Center(child: CircularProgressIndicator()),
        );
  }
}
