import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = isDark ? Colors.white : Colors.black;
    final scaffoldBg = isDark ? Colors.black : Colors.white;

    return Scaffold(
      backgroundColor: scaffoldBg,
      appBar: AppBar(
        backgroundColor: scaffoldBg,
        elevation: 0,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('aamna', style: TextStyle(color: primaryColor, fontWeight: FontWeight.bold, fontSize: 22)),
            const SizedBox(width: 4),
            Icon(Icons.keyboard_arrow_down, color: primaryColor, size: 20),
          ],
        ),
        actions: [
          IconButton(icon: Icon(Icons.add_box_outlined, color: primaryColor), onPressed: () {}),
          IconButton(
            icon: Icon(Icons.menu, color: primaryColor), 
            onPressed: () {
              // Using standard route string fallback safely
              Navigator.of(context).pushNamed('/settings');
            }
          ),
        ],
      ),
      body: DefaultTabController(
        length: 3,
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 935),
            child: NestedScrollView(
              headerSliverBuilder: (context, _) => [
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Header Section: Avatar and Stats balanced row
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
                        child: Row(
                          children: [
                            Container(
                              width: 88,
                              height: 88,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  image: NetworkImage('https://images.unsplash.com/photo-1494790108377-be9c29b29330?w=400'),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  _buildStatColumn('142', 'Posts', primaryColor),
                                  _buildStatColumn('48.2k', 'Followers', primaryColor),
                                  _buildStatColumn('612', 'Following', primaryColor),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Bio Layout
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Aamna', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: primaryColor)),
                            const SizedBox(height: 4),
                            Text('Digital Artist & UX Designer 🎨', style: TextStyle(color: primaryColor, fontSize: 13)),
                            const SizedBox(height: 4),
                            const Text('📍 Abbottabad, Pakistan', style: TextStyle(color: Colors.grey, fontSize: 13)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      // Action Buttons
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          children: [
                            Expanded(child: _buildButton('Edit Profile', isDark)),
                            const SizedBox(width: 8),
                            Expanded(child: _buildButton('Share Profile', isDark)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
                SliverPersistentHeader(
                  pinned: true,
                  delegate: _StickyTabBarDelegate(
                    TabBar(
                      indicatorColor: primaryColor,
                      labelColor: primaryColor,
                      unselectedLabelColor: Colors.grey,
                      tabs: const [
                        Tab(icon: Icon(Icons.grid_on_sharp)),
                        Tab(icon: Icon(Icons.video_library_outlined)),
                        Tab(icon: Icon(Icons.assignment_ind_outlined)),
                      ],
                    ),
                    scaffoldBg,
                  ),
                ),
              ],
              body: TabBarView(
                children: [
                  GridView.builder(
                    padding: EdgeInsets.zero,
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, 
                      crossAxisSpacing: 3, 
                      mainAxisSpacing: 3,
                    ),
                    itemCount: 12,
                    itemBuilder: (context, i) {
                      return Image.network(
                        'https://picsum.photos/id/${i + 15}/500/500', 
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                  Center(child: Icon(Icons.video_library_outlined, size: 32, color: primaryColor)),
                  Center(child: Icon(Icons.assignment_ind_outlined, size: 32, color: primaryColor)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  static Widget _buildStatColumn(String val, String label, Color textColor) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(val, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: textColor)),
        const SizedBox(height: 2),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }

  static Widget _buildButton(String title, bool isDark) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 9), 
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF262626) : const Color(0xFFEFEFEF), 
        borderRadius: BorderRadius.circular(8),
      ), 
      alignment: Alignment.center, 
      child: Text(
        title, 
        style: TextStyle(
          fontWeight: FontWeight.w600, 
          fontSize: 14, 
          color: isDark ? Colors.white : Colors.black,
        ),
      ),
    );
  }
}

class _StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar tabBar; 
  final Color bgColor;
  _StickyTabBarDelegate(this.tabBar, this.bgColor);
  
  @override double get minExtent => 48; 
  @override double get maxExtent => 48;
  
  @override 
  Widget build(BuildContext context, double shrinkOffset, bool overlaps) => Container(color: bgColor, child: tabBar);
  
  @override 
  bool shouldRebuild(covariant _StickyTabBarDelegate oldDelegate) {
    return oldDelegate.tabBar != tabBar || oldDelegate.bgColor != bgColor;
  }
}