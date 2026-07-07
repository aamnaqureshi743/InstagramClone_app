import 'package:flutter/material.dart';
import 'explore_screen.dart';
import 'reels_screen.dart';
import 'upload_post_screen.dart';
import 'profile_screen.dart';
import 'messages_screen.dart';

class MainNavScreen extends StatefulWidget {
  const MainNavScreen({super.key});

  @override
  State<MainNavScreen> createState() => _MainNavScreenState();
}

class _MainNavScreenState extends State<MainNavScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const DummyHomeFeed(),
    const ExploreScreen(),
    const UploadPostScreen(),
    const ReelsScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    const Color scaffoldBg = Colors.black;
    const Color activeColor = Colors.white;
    const Color inactiveColor = Color(0xFF737373);
    const Color dividerColor = Color(0xFF262626);

    return Scaffold(
      backgroundColor: scaffoldBg,
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: dividerColor,
              width: 0.3,
            ),
          ),
        ),
        child: BottomNavigationBar(
          backgroundColor: scaffoldBg,
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          selectedItemColor: activeColor,
          unselectedItemColor: inactiveColor,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          elevation: 0,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_filled, size: 26),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search_outlined, size: 26),
              label: 'Search',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add_box_outlined, size: 26),
              label: 'Upload',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.video_library_outlined, size: 26),
              label: 'Reels',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined, size: 26),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}

class DummyHomeFeed extends StatelessWidget {
  const DummyHomeFeed({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Colors.white;
    const Color secondaryColor = Color(0xFFA8A8A8);
    const Color dividerColor = Color(0xFF262626);

    final List<Map<String, String>> stories = [
      {'name': 'Your Story', 'isMe': 'true', 'id': '64'},
      {'name': 'Hira', 'isMe': 'false', 'id': '65'},
      {'name': 'Mariyam', 'isMe': 'false', 'id': '91'},
      {'name': 'Ayesha', 'isMe': 'false', 'id': '103'},
      {'name': 'Zainab', 'isMe': 'false', 'id': '177'},
      {'name': 'Fatima', 'isMe': 'false', 'id': '237'},
    ];

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: const Text(
          'Instagram',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w900,
            letterSpacing: -0.9,
            color: primaryColor,
          ),
        ),
        centerTitle: false,
        actions: [
          // Notification Heart Icon with Aligned Red Badge
          IconButton(
            icon: Stack(
              children: [
                const Icon(
                  Icons.favorite_border_rounded,
                  size: 25,
                  color: primaryColor,
                ),
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Color(0xFFFF3040),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ],
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/notifications');
            },
          ),
          // Message Paper Airplane with Aligned Red Badge
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const MessagesScreen()),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Stack(
                children: [
                  CustomPaint(
                    size: const Size(24, 24),
                    painter: InstagramPaperAirplanePainter(color: primaryColor),
                  ),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Color(0xFFFF3040),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: stories.length,
        itemBuilder: (context, index) {
          if (index == 0) {
            return Container(
              height: 110,
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: dividerColor,
                    width: 0.3,
                  ),
                ),
              ),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                itemCount: stories.length,
                itemBuilder: (context, sIndex) {
                  final story = stories[sIndex];
                  final bool isMe = story['isMe'] == 'true';
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(2.5),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: isMe
                                ? null
                                : const LinearGradient(
                                    colors: [
                                      Color(0xFFFCAF45),
                                      Color(0xFFE1306C),
                                      Color(0xFF405DE6),
                                    ],
                                    begin: Alignment.bottomLeft,
                                    end: Alignment.topRight,
                                  ),
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.black,
                            ),
                            child: CircleAvatar(
                              radius: 26,
                              backgroundColor: const Color(0xFF262626),
                              backgroundImage: NetworkImage(
                                'https://picsum.photos/id/${story['id']}/150/150',
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        SizedBox(
                          width: 68,
                          child: Text(
                            story['name']!,
                            style: TextStyle(
                              fontSize: 11,
                              color: isMe ? secondaryColor : primaryColor,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          }

          final postOwner = stories[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 16,
                      backgroundColor: const Color(0xFF262626),
                      backgroundImage: NetworkImage(
                        'https://picsum.photos/id/${postOwner['id']}/150/150',
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(
                      postOwner['name']!,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: primaryColor,
                      ),
                    ),
                    const Spacer(),
                    const Icon(
                      Icons.more_horiz,
                      color: primaryColor,
                      size: 20,
                    ),
                  ],
                ),
              ),
              AspectRatio(
                aspectRatio: 1,
                child: Image.network(
                  'https://picsum.photos/id/${int.parse(postOwner['id']!) + 1}/600/600',
                  fit: BoxFit.cover,
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(14),
                child: Row(
                  children: [
                    Icon(Icons.favorite_border_outlined,
                        color: primaryColor, size: 25),
                    SizedBox(width: 16),
                    Icon(Icons.chat_bubble_outline_rounded,
                        color: primaryColor, size: 23),
                    SizedBox(width: 16),
                    Icon(Icons.send_outlined, color: primaryColor, size: 23),
                    Spacer(),
                    Icon(Icons.bookmark_border_rounded,
                        color: primaryColor, size: 25),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '4,821 likes',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: primaryColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    RichText(
                      text: TextSpan(
                        style: const TextStyle(
                          fontSize: 13,
                          color: primaryColor,
                        ),
                        children: [
                          TextSpan(
                            text: '${postOwner['name']} ',
                            style: const TextStyle(fontWeight: FontWeight.w700),
                          ),
                          const TextSpan(
                            text: 'Visual interface updates render flawlessly! ✨',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          );
        },
      ),
    );
  }
}

class InstagramPaperAirplanePainter extends CustomPainter {
  final Color color;
  InstagramPaperAirplanePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final path = Path();
    path.moveTo(size.width * 0.95, size.height * 0.05);
    path.lineTo(size.width * 0.05, size.height * 0.45);
    path.lineTo(size.width * 0.40, size.height * 0.60);
    path.lineTo(size.width * 0.55, size.height * 0.95);
    path.close();

    path.moveTo(size.width * 0.40, size.height * 0.60);
    path.lineTo(size.width * 0.95, size.height * 0.05);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}