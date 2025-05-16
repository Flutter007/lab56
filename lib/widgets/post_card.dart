import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/post.dart';

final dateTime = DateFormat('MM d,y,HH:mm');

class PostCard extends StatelessWidget {
  final Post post;
  final void Function() onTap;
  final void Function() onLongPress;
  const PostCard({
    super.key,
    required this.post,
    required this.onTap,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 0,
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: onTap,
        onLongPress: onLongPress,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Ink(
                child: ListTile(
                  title: Text(post.header, style: theme.textTheme.titleLarge),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Text(dateTime.format(post.createdAt)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
