
class Post {
  final String id;
  final String username;
  final String userAvatarUrl;
  final String imageUrl;
  final String caption;
  final int likes;
  final int comments;
  final String postedAgo;
  final String location; 

  const Post({
    required this.id,
    required this.username,
    required this.userAvatarUrl,
    required this.imageUrl,
    required this.caption,
    required this.likes,
    required this.comments,
    required this.postedAgo,
    required this.location,
  });
}


final List<Post> samplePosts = [
  const Post(
    id: '1',
    username: 'Aamna',
    userAvatarUrl: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=150',
    imageUrl: 'https://images.unsplash.com/photo-1618005182384-a83a8bd57fbe?w=600',
    caption: 'Building an Instagram clone from scratch! Phase 1 & 2 layout architectures are officially running smoothly. 🚀 #FlutterDev #CodingLife',
    likes: 1254,
    comments: 48,
    postedAgo: '12m ago',
    location: 'Islamabad, Pakistan',
  ),
  const Post(
    id: '2',
    username: 'Hira',
    userAvatarUrl: 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=150',
    imageUrl: 'https://images.unsplash.com/photo-1501854140801-50d01698950b?w=600',
    caption: 'Escaped the noisy city for a while to find some clean aesthetic spaces 🌄☕✨',
    likes: 842,
    comments: 29,
    postedAgo: '2h ago',
    location: 'Margalla Hills',
  ),
  const Post(
    id: '3',
    username: 'Mariyam',
    userAvatarUrl: 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=150',
    imageUrl: 'https://images.unsplash.com/photo-1517841905240-472988babdf9?w=600',
    caption: 'Sunday brunch layout inspiration. Good food, better company 🥞🍓',
    likes: 931,
    comments: 54,
    postedAgo: '5h ago',
    location: 'Lahore, Pakistan',
  ),
  const Post(
    id: '4',
    username: 'Aamna',
    userAvatarUrl: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=150',
    imageUrl: 'https://images.unsplash.com/photo-1555066931-4365d14bab8c?w=600',
    caption: 'Late night dark mode code sessions are unmatched. Firebase state machine logic coming together next week 💻🔥',
    likes: 1532,
    comments: 89,
    postedAgo: '1d ago',
    location: 'Tech Hub Desktop',
  ),
  const Post(
    id: '5',
    username: 'Mariyam',
    userAvatarUrl: 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=150',
    imageUrl: 'https://images.unsplash.com/photo-1447752875215-b2761acb3c5d?w=600',
    caption: 'Nature runs always help reset the creative mindset 🌿💚',
    likes: 621,
    comments: 18,
    postedAgo: '3d ago',
    location: 'Botanical Gardens',
  ),
];