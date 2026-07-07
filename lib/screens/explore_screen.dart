import 'package:flutter/material.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const primaryBg = Colors.black;
    const borderColor = Color(0xFF262626);
    const textSecondary = Color(0xFF737373);

    return Scaffold(
      backgroundColor: primaryBg,
      appBar: AppBar(
        backgroundColor: primaryBg,
        elevation: 0,
        scrolledUnderElevation: 0,
        title: Container(
          height: 38,
          decoration: BoxDecoration(
            color: const Color(0xFF262626),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const TextField(
            style: TextStyle(color: Colors.white, fontSize: 14),
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
      body: GridView.builder(
        physics: const BouncingScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 2,
          mainAxisSpacing: 2,
        ),
        itemCount: 30,
        itemBuilder: (context, index) {
          // Dynamic layout variation: make every 7th item an asymmetric tall grid item feature
          final isLargeFeature = (index % 7 == 0);
          
          return Container(
            color: const Color(0xFF121212),
            child: Image.network(
              'https://picsum.photos/seed/explore_$index/400/${isLargeFeature ? 800 : 400}',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => const Center(
                child: Icon(Icons.image_not_supported_outlined, color: borderColor),
              ),
            ),
          );
        },
      ),
    );
  }
}