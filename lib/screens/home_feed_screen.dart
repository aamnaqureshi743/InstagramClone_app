import 'package:flutter/material.dart';
import '../models/post.dart';
import '../routes/app_routes.dart';
import '../widgets/post_card.dart';

/// Home Feed Screen
///
/// Demonstrates Phase 1 & Phase 2 Components:
/// - AppBar, Scaffold, and Drawer structures
/// - Horizontal and Vertical ListView Layout structures
/// - MediaQueries for responsiveness
/// - Multi-destination App Navigator flows
class HomeFeedScreen extends StatefulWidget {
  const HomeFeedScreen({super.key});

  @override
  State<HomeFeedScreen> createState() => _HomeFeedScreenState();
}

class _HomeFeedScreenState extends State<HomeFeedScreen> {
  Future<void> _refreshFeed() async {
    // Simulated network delay for pull-to-refresh.
    await Future.delayed(const Duration(milliseconds: 700));
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    // Phase 1 Requirement: Responsive Layout using MediaQuery
    final double screenWidth = MediaQuery.of(context).size.width;
    final bool isWideScreen = screenWidth > 600;

    return Scaffold(
      backgroundColor: Colors.black, // Instagram crisp black background
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0.5,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0.5),
          child: Container(color: const Color(0xFF262626), height: 0.5), // Subtle divider line
        ),
        title: const Text(
          'Instagram',
          style: TextStyle(
            fontFamily: 'cursive', 
            fontSize: 26, 
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border, color: Colors.white),
            onPressed: () {
              // Phase 2: Named Route Navigation
              Navigator.of(context).pushNamed(AppRoutes.notifications);
            },
          ),
          IconButton(
            icon: const Icon(Icons.send_outlined, color: Colors.white),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Direct Messages coming soon!'),
                  behavior: SnackBarBehavior.floating,
                ),
              );
            },
          ),
        ],
      ),
      
      // Phase 1 & 2 Requirement: Drawer Component Navigation
      drawer: Drawer(
        backgroundColor: const Color(0xFF121212),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: Colors.black),
              accountName: Text('Aamna', style: TextStyle(fontWeight: FontWeight.bold)),
              accountEmail: Text('aamna@instaclone.com', style: TextStyle(color: Colors.grey)),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage('https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=150'),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.settings_outlined, color: Colors.white),
              title: const Text('Settings', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.of(context).pop(); // Close drawer
                Navigator.of(context).pushNamed(AppRoutes.settings);
              },
            ),
            ListTile(
              leading: const Icon(Icons.bookmark_border, color: Colors.white),
              title: const Text('Saved Items', style: TextStyle(color: Colors.white)),
              onTap: () => Navigator.of(context).pop(),
            ),
          ],
        ),
      ),

      // Phase 1 Requirement: Floating Action Button Component
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF121212),
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Color(0xFF262626), width: 1),
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(Icons.add_a_photo_outlined, color: Colors.white),
        onPressed: () {
          // Placeholder route or action for creating posts
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Navigate to Create Screen')),
          );
        },
      ),

      body: RefreshIndicator(
        color: Colors.white,
        backgroundColor: const Color(0xFF121212),
        onRefresh: _refreshFeed,
        child: Center(
          child: Container(
            constraints: BoxConstraints(maxWidth: isWideScreen ? 600 : double.infinity),
            child: ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: samplePosts.length + 1, // Add 1 to account for the horizontal Stories section
              itemBuilder: (context, index) {
                if (index == 0) {
                  // Phase 1 Requirement: Horizontal ListView inside standard Vertical ListView
                  return Column(
                    children: [
                      SizedBox(
                        height: 105,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          children: const [
                            _StoryItem(username: 'Your Story', imageUrl: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=150', isMe: true),
                            _StoryItem(username: 'Aamna', imageUrl: 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=150'),
                            _StoryItem(username: 'Hira', imageUrl: 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?w=150'),
                            _StoryItem(username: 'Mariyam', imageUrl: 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?w=150'),
                          ],
                        ),
                      ),
                      Container(color: const Color(0xFF1A1A1A), height: 0.5), // Subtle break line beneath stories
                    ],
                  );
                }
                
                // Return custom decorated item layout offsets
                final postItem = samplePosts[index - 1];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2.0),
                  child: PostCard(post: postItem),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

/// Phase 1 Component Layout: Sub-component widget representing an Instagram story bubble
class _StoryItem extends StatelessWidget {
  final String username;
  final String imageUrl;
  final bool isMe;

  const _StoryItem({
    required this.username,
    required this.imageUrl,
    this.isMe = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 4.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 66,
                height: 66,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: isMe
                      ? null
                      : const LinearGradient(
                          colors: [Colors.purple, Colors.orange, Colors.yellow],
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                        ),
                  color: isMe ? Colors.grey[900] : null,
                ),
              ),
              CircleAvatar(
                radius: 31,
                backgroundColor: Colors.black,
                child: CircleAvatar(
                  radius: 29,
                  backgroundColor: const Color(0xFF121212),
                  backgroundImage: NetworkImage(imageUrl),
                ),
              ),
              if (isMe)
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                    padding: const EdgeInsets.all(2),
                    child: const Icon(Icons.add, size: 14, color: Colors.white),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 4),
          SizedBox(
            width: 70,
            child: Text(
              username,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 11, color: Colors.white70),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}