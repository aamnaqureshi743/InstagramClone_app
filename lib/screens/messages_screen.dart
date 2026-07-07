import 'package:flutter/material.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryBg = Colors.black;
    const textPrimary = Colors.white;
    const textSecondary = Color(0xFF737373);

    final List<Map<String, String>> notes = [
      {'name': 'Your note', 'note': 'Coding late... 💻', 'isMe': 'true', 'id': '64'},
      {'name': 'Hira', 'note': 'HCI lab due tomorrow! 😭', 'isMe': 'false', 'id': '65'},
      {'name': 'Mariyam', 'note': 'Valorant tonight?', 'isMe': 'false', 'id': '91'},
      {'name': 'Ayesha', 'note': 'OrderSync UI looks 🔥', 'isMe': 'false', 'id': '103'},
      {'name': 'Zainab', 'note': 'Tea time ☕', 'isMe': 'false', 'id': '177'},
      {'name': 'Fatima', 'note': 'Designing widgets...', 'isMe': 'false', 'id': '237'},
    ];

    final List<Map<String, dynamic>> chats = [
      {'username': 'Hira', 'subtext': 'Shared a reel • 2h', 'isUnread': true, 'isOnline': true, 'id': '65'},
      {'username': 'Mariyam', 'subtext': 'Active 45m ago', 'isUnread': false, 'isOnline': false, 'id': '91'},
      {'username': 'Ayesha', 'subtext': 'You: Let\'s test the Flutter layout.', 'isUnread': false, 'isOnline': true, 'id': '103'},
      {'username': 'Zainab', 'subtext': 'Sent you a message • 1d', 'isUnread': true, 'isOnline': false, 'id': '177'},
      {'username': 'Fatima', 'subtext': 'Active 5m ago', 'isUnread': false, 'isOnline': true, 'id': '237'},
      {'username': 'Amina', 'subtext': 'Sent a photo • 3d', 'isUnread': false, 'isOnline': false, 'id': '338'},
      {'username': 'Sana', 'subtext': 'Typing...', 'isUnread': true, 'isOnline': true, 'id': '342'},
      {'username': 'Sadia', 'subtext': 'Active yesterday', 'isUnread': false, 'isOnline': false, 'id': '443'},
    ];

    return Scaffold(
      backgroundColor: primaryBg,
      appBar: AppBar(
        backgroundColor: primaryBg,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: textPrimary, size: 26),
          onPressed: () => Navigator.maybePop(context),
        ),
        title: const Row(
          children: [
            Text(
              'aamna',
              style: TextStyle(color: textPrimary, fontSize: 18, fontWeight: FontWeight.w700, letterSpacing: -0.3),
            ),
            Icon(Icons.keyboard_arrow_down_rounded, color: textPrimary, size: 18),
          ],
        ),
        actions: [
          IconButton(icon: const Icon(Icons.video_call_outlined, color: textPrimary, size: 28), onPressed: () {}),
          IconButton(icon: const Icon(Icons.open_in_new_rounded, color: textPrimary, size: 24), onPressed: () {}),
          const SizedBox(width: 6),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Container(
              height: 38,
              decoration: BoxDecoration(
                color: const Color(0xFF262626),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const TextField(
                style: TextStyle(color: textPrimary, fontSize: 14),
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search_rounded, color: textSecondary, size: 20),
                  hintText: 'Search',
                  hintStyle: TextStyle(color: textSecondary, fontSize: 14, fontWeight: FontWeight.w400),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(vertical: 10),
                ),
              ),
            ),
          ),

          Expanded(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                SizedBox(
                  height: 115,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    itemCount: notes.length,
                    itemBuilder: (context, index) {
                      final noteItem = notes[index];
                      final isMe = noteItem['isMe'] == 'true';

                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Column(
                          children: [
                            Stack(
                              clipBehavior: Clip.none,
                              children: [
                                CircleAvatar(
                                  radius: 28,
                                  backgroundColor: const Color(0xFF262626),
                                  backgroundImage: NetworkImage('https://picsum.photos/id/${noteItem['id']}/150/150'),
                                ),
                                Positioned(
                                  top: -10,
                                  left: -6,
                                  right: -6,
                                  child: Align(
                                    alignment: Alignment.topCenter,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF262626),
                                        borderRadius: BorderRadius.circular(14),
                                        border: Border.all(color: Colors.black, width: 1),
                                      ),
                                      child: Text(
                                        noteItem['note']!,
                                        style: const TextStyle(color: textPrimary, fontSize: 9.5),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                ),
                                if (isMe)
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: Container(
                                      padding: const EdgeInsets.all(2),
                                      decoration: const BoxDecoration(color: Colors.black, shape: BoxShape.circle),
                                      child: const CircleAvatar(
                                        radius: 8,
                                        backgroundColor: textSecondary,
                                        child: Icon(Icons.add, size: 10, color: Colors.white),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              noteItem['name']!,
                              style: TextStyle(color: isMe ? textSecondary : textPrimary, fontSize: 11, letterSpacing: -0.1),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),

                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Messages', style: TextStyle(color: textPrimary, fontSize: 15, fontWeight: FontWeight.w700)),
                      Text('Requests (1)', style: TextStyle(color: Color(0xFF0095F6), fontSize: 14, fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),

                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: chats.length,
                  itemBuilder: (context, index) {
                    final chat = chats[index];
                    final bool isUnread = chat['isUnread'];
                    final bool isOnline = chat['isOnline'];

                    return InkWell(
                      onTap: () {}, 
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        child: Row(
                          children: [
                            Stack(
                              children: [
                                CircleAvatar(
                                  radius: 26,
                                  backgroundColor: const Color(0xFF262626),
                                  backgroundImage: NetworkImage('https://picsum.photos/id/${chat['id']}/150/150'),
                                ),
                                if (isOnline)
                                  Positioned(
                                    bottom: 1,
                                    right: 1,
                                    child: Container(
                                      width: 14,
                                      height: 14,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF4BAC4E),
                                        shape: BoxShape.circle,
                                        border: Border.all(color: Colors.black, width: 2),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                            const SizedBox(width: 14),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    chat['username'],
                                    style: TextStyle(
                                      color: textPrimary,
                                      fontSize: 13.5,
                                      fontWeight: isUnread ? FontWeight.w700 : FontWeight.w400,
                                    ),
                                  ),
                                  const SizedBox(height: 3),
                                  Text(
                                    chat['subtext'],
                                    style: TextStyle(
                                      color: isUnread ? textPrimary : textSecondary,
                                      fontSize: 13,
                                      fontWeight: isUnread ? FontWeight.w600 : FontWeight.w400,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                            if (isUnread)
                              Container(
                                width: 8,
                                height: 8,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF0095F6),
                                  shape: BoxShape.circle,
                                ),
                              )
                            else
                              const Icon(Icons.camera_alt_outlined, color: textSecondary, size: 22),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}