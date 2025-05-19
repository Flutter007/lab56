import 'package:flutter/material.dart';
import 'package:lab56/helpers/request.dart';
import 'package:lab56/models/post.dart';

class PostProvider extends ChangeNotifier {
  List<Post> _posts = [];
  Post? post;
  bool _isFetching = false;
  bool _isError = false;
  bool _isCreating = false;
  bool _isDeleting = false;
  List<Post> get posts => [..._posts];
  bool get isFetching => _isFetching;
  bool get isError => _isError;
  bool get isCreating => _isCreating;
  bool get isDeleting => _isDeleting;

  final url =
      'https://my-db-7777-default-rtdb.europe-west1.firebasedatabase.app/';

  Future<void> fetchPosts() async {
    try {
      _isFetching = true;
      _isError = false;
      notifyListeners();

      final Map<String, dynamic>? response = await request(
        '$url/blog.json',
        method: 'GET',
      );
      if (response == null) {
        _posts = [];
        return;
      }
      final List<Post> newPosts = [];
      for (final key in response.keys) {
        final post = Post.fromJson({...response[key], 'id': key});
        newPosts.add(post);
      }
      _posts = newPosts;
    } catch (e) {
      _isError = true;
    } finally {
      _isFetching = false;
      notifyListeners();
    }
  }

  Future<void> createPost(Post post, String method) async {
    try {
      _isCreating = true;
      notifyListeners();
      if (method == 'POST') {
        await request('$url/blog.json', method: 'POST', body: post.toJson());
      } else if (method == 'PUT') {
        await request(
          '$url/blog/${post.id}.json',
          method: 'PUT',
          body: post.toJson(),
        );
      } else {
        throw Exception('Method not supported');
      }
    } finally {
      _isCreating = false;
      await fetchPosts();
      notifyListeners();
    }
  }

  Future<void> getPost(String id) async {
    try {
      _isFetching = true;
      notifyListeners();
      final Map<String, dynamic> response = await request('$url/blog/$id.json');
      post = Post.fromJson({...response, 'id': id});
    } finally {
      _isFetching = false;
      notifyListeners();
    }
  }

  Future<void> deletePost(String id) async {
    try {
      _isDeleting = true;
      notifyListeners();
      await request('$url/blog/$id.json', method: 'DELETE');
    } finally {
      _isDeleting = false;
      await fetchPosts();
      notifyListeners();
    }
  }
}
