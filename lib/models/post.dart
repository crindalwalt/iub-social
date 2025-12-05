import 'dart:io';

class Post {
  final String userName;
  final String userAvatar;
  final String title;
  final File content;
  final DateTime createdAt;
  final int likes;
  final int comments;
  final int shares;

  Post({required this.userName,required this.userAvatar,required this.title, required this.content, required this.createdAt,required this.likes,required this.comments,required this.shares});
}

class DummyPost {
  final String userName;
  final String userAvatar;
  final String timeAgo;
  final String postContent;
  final String? postImage;
  final int likes;
  final int comments;
  final int shares;

  DummyPost({
    required this.userName,
    required this.userAvatar,
    required this.timeAgo,
    required this.postContent,
    this.postImage,
    required this.likes,
    required this.comments,
    required this.shares,
  });
}

final List<DummyPost> dummyPosts = [
  DummyPost(
    userName: 'John Doe',
    userAvatar: 'https://i.pravatar.cc/150?img=1',
    timeAgo: '2 hours ago',
    postContent: 'Just had an amazing day at the campus! 🎓',
    postImage: 'https://picsum.photos/400/300?random=1',
    likes: 42,
    comments: 8,
    shares: 3,
  ),
  DummyPost(
    userName: 'Jane Smith',
    userAvatar: 'https://i.pravatar.cc/150?img=2',
    timeAgo: '5 hours ago',
    postContent: 'Working on my final project. Wish me luck! 💻',
    postImage: null,
    likes: 28,
    comments: 12,
    shares: 1,
  ),
  DummyPost(
    userName: 'Mike Johnson',
    userAvatar: 'https://i.pravatar.cc/150?img=3',
    timeAgo: '1 day ago',
    postContent: 'Check out this beautiful sunset from the library rooftop! 🌅',
    postImage: 'https://picsum.photos/400/300?random=2',
    likes: 156,
    comments: 24,
    shares: 15,
  ),
  DummyPost(
    userName: 'Sarah Williams',
    userAvatar: 'https://i.pravatar.cc/150?img=4',
    timeAgo: '2 days ago',
    postContent: 'Anyone up for a study group this weekend? 📚',
    postImage: null,
    likes: 18,
    comments: 32,
    shares: 0,
  ),
  DummyPost(
    userName: 'Alex Brown',
    userAvatar: 'https://i.pravatar.cc/150?img=5',
    timeAgo: '3 days ago',
    postContent: 'Finally finished my thesis! Time to celebrate! 🎉',
    postImage: 'https://picsum.photos/400/300?random=3',
    likes: 234,
    comments: 56,
    shares: 8,
  ),
];
