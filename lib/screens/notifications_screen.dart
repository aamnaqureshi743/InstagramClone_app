import 'package:flutter/material.dart';

class _NotificationItem {
  final String username;
  final String avatarUrl;
  final String action;
  final String time;
  final IconData icon;
  final bool isFollowAction;
  final bool isFollowingBack;

  const _NotificationItem({
    required this.username,
    required this.avatarUrl,
    required this.action,
    required this.time,
    required this.icon,
    this.isFollowAction = false,
    this.isFollowingBack = false,
  });
}

// --- Dynamic Notification Array with clean Pakistani names and unique Web CORS-clean images ---
final List<_NotificationItem> _sampleNotifications = [
  const _NotificationItem(
    username: 'hira_studio',
    avatarUrl: 'https://picsum.photos/id/65/150/150',
    action: 'liked your photo.',
    time: '5m',
    icon: Icons.favorite,
  ),
  const _NotificationItem(
    username: 'aamna_q',
    avatarUrl: 'https://picsum.photos/id/64/150/150',
    action: 'started following you.',
    time: '1h',
    icon: Icons.person_add,
    isFollowAction: true,
    isFollowingBack: false,
  ),
  const _NotificationItem(
    username: 'mariyam_vlogs',
    avatarUrl: 'https://picsum.photos/id/91/150/150',
    action: 'commented: "Amazing shot!"',
    time: '3h',
    icon: Icons.chat_bubble,
  ),
  const _NotificationItem(
    username: 'ayesha_art',
    avatarUrl: 'https://picsum.photos/id/103/150/150',
    action: 'liked your comment.',
    time: '1d',
    icon: Icons.favorite,
  ),
  const _NotificationItem(
    username: 'zainab_bcs',
    avatarUrl: 'https://picsum.photos/id/177/150/150',
    action: 'mentioned you in a comment.',
    time: '2d',
    icon: Icons.chat_bubble,
    isFollowAction: true,
    isFollowingBack: true,
  ),
  const _NotificationItem(
    username: 'fatima_tech',
    avatarUrl: 'https://picsum.photos/id/237/150/150',
    action: 'started following you.',
    time: '3d',
    icon: Icons.person_add,
    isFollowAction: true,
    isFollowingBack: false,
  ),
];

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, 
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Colors.white, size: 26),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Notifications',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(0.5),
          child: Container(color: const Color(0xFF262626), height: 0.5), 
        ),
      ),
      body: ListView.separated(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: _sampleNotifications.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final item = _sampleNotifications[index];
          return ListTile(
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
            leading: Stack(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundColor: const Color(0xFF262626),
                  backgroundImage: NetworkImage(item.avatarUrl),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(3),
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        color: item.icon == Icons.favorite ? Colors.red : Colors.blue,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        item.icon,
                        size: 10,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            title: RichText(
              text: TextSpan(
                style: const TextStyle(color: Colors.white, fontSize: 13.5, height: 1.3),
                children: [
                  TextSpan(
                    text: '${item.username} ',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(
                    text: '${item.action} ',
                    style: const TextStyle(color: Colors.white70),
                  ),
                  TextSpan(
                    text: item.time,
                    style: const TextStyle(color: Color(0xFF8E8E8E), fontSize: 12),
                  ),
                ],
              ),
            ),
            trailing: item.isFollowAction
                ? SizedBox(
                    width: 100,
                    height: 32,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: item.isFollowingBack 
                            ? const Color(0xFF262626) 
                            : const Color(0xFF0095F6),
                        elevation: 0,
                        padding: EdgeInsets.zero,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        item.isFollowingBack ? 'Following' : 'Follow back',
                        style: const TextStyle( 
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                : const SizedBox(
                    width: 40,
                    height: 40,
                    child: Icon(Icons.more_horiz, color: Color(0xFF8E8E8E), size: 18),
                  ),
          );
        },
      ),
    );
  }
}