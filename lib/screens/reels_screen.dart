import 'package:flutter/material.dart';

class ReelsScreen extends StatelessWidget {
  const ReelsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        itemCount: 5,
        itemBuilder: (context, index) {
          return Stack(
            children: [
              // Immersive Full-Screen Visual Layer Placeholder
              Positioned.fill(
                child: Container(
                  color: const Color(0xFF121212),
                  child: Image.network(
                    'https://picsum.photos/seed/reels_$index/1080/1920',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              
              // Top Overlay Heading
              Positioned(
                top: 50,
                left: 16,
                child: const Text(
                  'Reels',
                  style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
              
              // Right-Side Action Interaction Column
              Positioned(
                right: 12,
                bottom: 100,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    _buildReelAction(Icons.favorite_border_rounded, '1.2M'),
                    _buildReelAction(Icons.chat_bubble_outline_rounded, '45K'),
                    _buildReelAction(Icons.send_outlined, ''),
                    _buildReelAction(Icons.more_vert_rounded, ''),
                    const SizedBox(height: 10),
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(color: Colors.white, width: 2),
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              
              // Bottom Creator Context Block
              Positioned(
                left: 16,
                bottom: 30,
                right: 80,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(radius: 16, backgroundColor: Colors.grey),
                        const SizedBox(width: 10),
                        Text(
                          'reel_creator_$index',
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14),
                        ),
                        const SizedBox(width: 12),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white54, width: 1),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: const Text('Follow', style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      'Designing pure immersive mobile layouts utilizing strict layout canvas properties... 🚀 #flutter #uidesign',
                      style: TextStyle(color: Colors.white, fontSize: 13),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildReelAction(IconData icon, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Icon(icon, color: Colors.white, size: 28),
          if (label.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(label, style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500)),
          ]
        ],
      ),
    );
  }
}