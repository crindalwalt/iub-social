import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:iub_social/models/post.dart';
import 'package:iub_social/providers/post_provider.dart';
import 'package:iub_social/providers/authentication_provider.dart';
import 'package:provider/provider.dart';
import '../../utils/app_colors.dart';
import '../common/custom_app_bar.dart';

class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  final TextEditingController _captionController = TextEditingController();
  bool _hasSelectedImage = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  // bool doneSelectingFile
  File? selectedFile;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.offWhite,
      appBar: CustomAppBar(
        title: 'Create Post',
        showBackButton: true,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: TextButton(
              onPressed: () {
                // Post functionality

                if (_formKey.currentState!.validate()) {
                  // proceed to post
                  final caption = _captionController.text;
                  print("Posting: $caption");

                  final postProvier = Provider.of<PostProvider>(context,listen: false);
                  final authProvider = Provider.of<AuthenticationProvider>(context,listen: false);
                  final userId = authProvider.user?.uid ?? null;
                  final post = Post(
                    title: caption,
                    content: selectedFile!,
                    createdAt: DateTime.now(),
                  );



                  final CreatePost newPost = CreatePost(
                    content: caption,
                    imageFile: selectedFile,
                    userId: userId!,
                  );

                  
                  postProvier.uploadPost(newPost);
                  // print(pickingFiles.files.first)
                }
              },
              style: TextButton.styleFrom(
                backgroundColor: AppColors.accentNavy,
                foregroundColor: AppColors.pureWhite,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 8,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Post',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // User Info Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.pureWhite,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 28,
                    backgroundColor: AppColors.lightNavy,
                    child: Text(
                      'YN',
                      style: TextStyle(
                        color: AppColors.pureWhite,
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Your Name',
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: AppColors.primaryNavy,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Posting to IUB Social',
                          style: TextStyle(
                            fontSize: 13,
                            color: AppColors.darkGray,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Privacy Dropdown
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.offWhite,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: AppColors.lightGray),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: const [
                        Icon(
                          Icons.public,
                          size: 16,
                          color: AppColors.accentNavy,
                        ),
                        SizedBox(width: 6),
                        Text(
                          'Public',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryNavy,
                          ),
                        ),
                        SizedBox(width: 4),
                        Icon(
                          Icons.arrow_drop_down,
                          size: 18,
                          color: AppColors.darkGray,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 2),

            // Caption Input Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(color: AppColors.pureWhite),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextFormField(
                      controller: _captionController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Caption cannot be empty";
                        }
                        return null;
                      },
                      maxLines: null,
                      minLines: 6,
                      style: const TextStyle(
                        fontSize: 16,
                        color: AppColors.primaryNavy,
                        height: 1.5,
                      ),
                      decoration: const InputDecoration(
                        hintText: "What's on your mind?",
                        hintStyle: TextStyle(
                          color: AppColors.mediumGray,
                          fontSize: 16,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Selected Images Preview
            if (_hasSelectedImage)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(color: AppColors.pureWhite),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Selected Images',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryNavy,
                          ),
                        ),
                        TextButton.icon(
                          onPressed: () {
                            setState(() {
                              _hasSelectedImage = false;
                            });
                          },
                          icon: const Icon(Icons.close, size: 18),
                          label: const Text('Remove'),
                          style: TextButton.styleFrom(
                            foregroundColor: AppColors.dangerRed,
                            padding: EdgeInsets.zero,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    // Image preview placeholder
                    GestureDetector(
                      onTap: () async {
                        FilePickerResult? pickingFiles = await FilePicker
                            .platform
                            .pickFiles();
                        print("picking image ... ");

                        if (pickingFiles != null) {
                          File pickedImage = File(
                            pickingFiles.files.single.path!,
                          );
                          setState(() {
                            _hasSelectedImage = true;
                          });
                          // proceed
                          selectedFile = pickedImage;
                          print("file picked");
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text("no media selected")),
                          );
                        }
                      },
                      child: Container(
                        height: 200,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: AppColors.lightGray,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: AppColors.mediumGray.withOpacity(0.3),
                          ),
                        ),
                        child: selectedFile != null
                            ? Image.file(selectedFile!)
                            : Center(
                                child: Icon(
                                  Icons.face,
                                  size: 80,
                                  color: AppColors.mediumGray,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),

            const SizedBox(height: 2),

            // Add to Post Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.pureWhite,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 5,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Add to your post',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryNavy,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: _AddToPostButton(
                          icon: Icons.photo_library,
                          label: 'Photo',
                          color: AppColors.successGreen,
                          onTap: () {
                            setState(() {
                              _hasSelectedImage = true;
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _AddToPostButton(
                          icon: Icons.videocam,
                          label: 'Video',
                          color: AppColors.dangerRed,
                          onTap: () {},
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _AddToPostButton(
                          icon: Icons.location_on,
                          label: 'Location',
                          color: AppColors.accentNavy,
                          onTap: () {},
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _AddToPostButton(
                          icon: Icons.emoji_emotions_outlined,
                          label: 'Feeling',
                          color: AppColors.goldAccent,
                          onTap: () {},
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Tips Section
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.pureWhite,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Icon(
                        Icons.lightbulb_outline,
                        color: AppColors.goldAccent,
                        size: 24,
                      ),
                      SizedBox(width: 12),
                      Text(
                        'Tips for Great Posts',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColors.primaryNavy,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _TipItem(
                    icon: Icons.check_circle_outline,
                    text: 'Be authentic and share your genuine experiences',
                  ),
                  const SizedBox(height: 12),
                  _TipItem(
                    icon: Icons.check_circle_outline,
                    text: 'Use clear photos and descriptive captions',
                  ),
                  const SizedBox(height: 12),
                  _TipItem(
                    icon: Icons.check_circle_outline,
                    text: 'Engage with your IUB community positively',
                  ),
                  const SizedBox(height: 12),
                  _TipItem(
                    icon: Icons.check_circle_outline,
                    text: 'Respect privacy and university guidelines',
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.accentNavy.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: const [
                        Icon(
                          Icons.info_outline,
                          size: 20,
                          color: AppColors.accentNavy,
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'Posts are visible to all IUB students',
                            style: TextStyle(
                              fontSize: 13,
                              color: AppColors.primaryNavy,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _captionController.dispose();
    super.dispose();
  }
}

class _AddToPostButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _AddToPostButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.offWhite,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: AppColors.lightGray),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(width: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.primaryNavy,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TipItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const _TipItem({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, size: 20, color: AppColors.successGreen),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.darkGray,
              height: 1.4,
            ),
          ),
        ),
      ],
    );
  }
}
