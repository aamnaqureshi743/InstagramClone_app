import 'package:flutter/material.dart';

class UploadPostScreen extends StatefulWidget {
  const UploadPostScreen({super.key});

  @override
  State<UploadPostScreen> createState() => _UploadPostScreenState();
}

class _UploadPostScreenState extends State<UploadPostScreen> {
  final _formKey = GlobalKey<FormState>();
  final _captionController = TextEditingController();
  bool _imageSelected = false;
  bool _isPosting = false;

  // Additional Instagram settings states
  bool _shareToFacebook = false;
  bool _advancedSettingsOpen = false;

  @override
  void dispose() {
    _captionController.dispose();
    super.dispose();
  }

  Future<void> _showImageSourcePicker() async {
    final choice = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: const Color(0xFF262626),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
      ),
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 8),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: const Color(0xFF555555),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 12),
              child: Text(
                'Create new post',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ),
            const Divider(color: Color(0xFF363636), height: 1),
            ListTile(
              leading: const Icon(Icons.photo_library_outlined, color: Colors.white),
              title: const Text('Choose from Gallery', style: TextStyle(color: Colors.white, fontSize: 15)),
              onTap: () => Navigator.of(context).pop('gallery'),
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt_outlined, color: Colors.white),
              title: const Text('Take Photo', style: TextStyle(color: Colors.white, fontSize: 15)),
              onTap: () => Navigator.of(context).pop('camera'),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );

    if (choice != null) {
      setState(() => _imageSelected = true);
    }
  }

  void _handlePost() {
    if (!_imageSelected) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select an image first', style: TextStyle(color: Colors.white, fontSize: 14)),
          backgroundColor: Color(0xFFED4956),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isPosting = true);

    Future.delayed(const Duration(milliseconds: 1200), () {
      if (!mounted) return;
      setState(() {
        _isPosting = false;
        _imageSelected = false;
        _captionController.clear();
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Shared successfully!', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500)),
          backgroundColor: Color(0xFF0095F6),
          behavior: SnackBarBehavior.floating,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    const primaryBg = Colors.black;
    const itemSurfaceBg = Color(0xFF121212);
    const borderColor = Color(0xFF262626);
    const textPrimary = Colors.white;
    const textSecondary = Color(0xFF737373);
    const brandBlue = Color(0xFF0095F6);

    return Scaffold(
      backgroundColor: primaryBg,
      appBar: AppBar(
        backgroundColor: primaryBg,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close_rounded, color: textPrimary, size: 28),
          onPressed: () => Navigator.maybePop(context),
        ),
        title: const Text(
          'New post',
          style: TextStyle(color: textPrimary, fontSize: 18, fontWeight: FontWeight.w700, letterSpacing: -0.2),
        ),
        centerTitle: false,
        actions: [
          TextButton(
            onPressed: _isPosting ? null : _handlePost,
            style: TextButton.styleFrom(padding: const EdgeInsets.symmetric(horizontal: 16)),
            child: _isPosting
                ? const SizedBox(
                    height: 18,
                    width: 18,
                    child: CircularProgressIndicator(strokeWidth: 2, color: brandBlue),
                  )
                : const Text(
                    'Share',
                    style: TextStyle(
                      color: brandBlue,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.1,
                    ),
                  ),
          ),
        ],
        shape: const Border(bottom: BorderSide(color: borderColor, width: 0.3)),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                // --- INSTAGRAM ASYMMETRIC MEDIA & CAPTION BLOCK ---
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Interactive Left Media Container Box
                      GestureDetector(
                        onTap: _showImageSourcePicker,
                        child: Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: itemSurfaceBg,
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(color: borderColor, width: 0.5),
                          ),
                          child: _imageSelected
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(3),
                                  child: Image.network(
                                    'https://picsum.photos/seed/newpost/300/300',
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : const Center(
                                  child: Icon(Icons.add_a_photo_outlined, size: 26, color: textSecondary),
                                ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      
                      // Fluid Borderless Right Side Form Box
                      Expanded(
                        child: TextFormField(
                          controller: _captionController,
                          maxLines: 4,
                          style: const TextStyle(color: textPrimary, fontSize: 14, height: 1.3),
                          cursorColor: brandBlue,
                          decoration: const InputDecoration(
                            hintText: 'Write a caption or choose a template...',
                            hintStyle: TextStyle(color: textSecondary, fontSize: 14, fontWeight: FontWeight.w400),
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            focusedErrorBorder: InputBorder.none,
                            contentPadding: EdgeInsets.zero,
                          ),
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please insert a caption text details payload.';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                
                const Divider(color: borderColor, height: 0.3, thickness: 0.3),

                // --- METADATA CONFIGURATION LIST TILES ---
                _buildInstagramMenuTile(
                  icon: Icons.person_outline_rounded, 
                  title: 'Tag people',
                  onTap: () {},
                ),
                _buildInstagramMenuTile(
                  icon: Icons.local_offer_outlined, 
                  title: 'Add location',
                  onTap: () {},
                ),
                _buildInstagramMenuTile(
                  icon: Icons.music_note_outlined, 
                  title: 'Add music',
                  trailingText: 'Search audio tracks',
                  onTap: () {},
                ),
                
                const Divider(color: borderColor, height: 12, thickness: 8), // Instagram Separation Block Gaps

                // --- INTERACTIVE INTEGRATION SWITCHES ---
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.layers_outlined, color: textPrimary, size: 22),
                          SizedBox(width: 14),
                          Text(
                            'Share to Facebook',
                            style: TextStyle(color: textPrimary, fontSize: 14.5, fontWeight: FontWeight.w400),
                          ),
                        ],
                      ),
                      Switch.adaptive(
                        value: _shareToFacebook,
                        activeColor: brandBlue,
                        onChanged: (val) => setState(() => _shareToFacebook = val),
                      ),
                    ],
                  ),
                ),

                const Divider(color: borderColor, height: 0.3, thickness: 0.3),

                // --- ADVANCED CONFIGURATION EXPANSION ACCORDION ---
                Theme(
                  data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    title: const Text(
                      'Advanced settings',
                      style: TextStyle(color: textSecondary, fontSize: 13, fontWeight: FontWeight.w500),
                    ),
                    trailing: Icon(
                      _advancedSettingsOpen ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded,
                      color: textSecondary,
                      size: 18,
                    ),
                    onExpansionChanged: (val) => setState(() => _advancedSettingsOpen = val),
                    tilePadding: const EdgeInsets.symmetric(horizontal: 16),
                    childrenPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Hide like and view counts on this post', style: TextStyle(color: textPrimary, fontSize: 13.5)),
                                SizedBox(height: 2),
                                Text(
                                  'Only you will see the total number of likes and views on this post.',
                                  style: TextStyle(color: textSecondary, fontSize: 11),
                                ),
                              ],
                            ),
                          ),
                          Switch.adaptive(value: true, activeColor: brandBlue, onChanged: (v) {}),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Turn off commenting', style: TextStyle(color: textPrimary, fontSize: 13.5)),
                          Switch.adaptive(value: false, activeColor: brandBlue, onChanged: (v) {}),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // High-Fidelity Custom Instagram Row Builder Asset Item
  Widget _buildInstagramMenuTile({
    required IconData icon,
    required String title,
    String? trailingText,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Color(0xFF262626), width: 0.3)),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 22),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(color: Colors.white, fontSize: 14.5, fontWeight: FontWeight.w400, letterSpacing: -0.1),
              ),
            ),
            if (trailingText != null)
              Text(
                trailingText,
                style: const TextStyle(color: Color(0xFF737373), fontSize: 13),
              ),
            const SizedBox(width: 4),
            const Icon(Icons.arrow_forward_ios_rounded, color: Color(0xFF555555), size: 14),
          ],
        ),
      ),
    );
  }
}