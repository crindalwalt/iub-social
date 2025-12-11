import 'package:flutter/material.dart';
import 'package:iub_social/providers/authentication_provider.dart';
import 'package:provider/provider.dart';
import '../../utils/app_colors.dart';
import '../common/custom_app_bar.dart';
import '../common/post_card.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final username = Provider.of<AuthenticationProvider>(context);
    final name = username.user!.displayName;
    return Scaffold(
      backgroundColor: AppColors.offWhite,
      appBar: CustomAppBar(
        title: 'Profile',
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined, color: AppColors.pureWhite),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Header
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: AppColors.pureWhite,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const SizedBox(height: 24),
                  
                  // Profile Picture
                  Stack(
                    children: [
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.lightNavy,
                          border: Border.all(color: AppColors.pureWhite, width: 4),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: const Center(
                          child: Text(
                            'YN',
                            style: TextStyle(
                              color: AppColors.pureWhite,
                              fontSize: 48,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: AppColors.accentNavy,
                            shape: BoxShape.circle,
                            border: Border.all(color: AppColors.pureWhite, width: 3),
                          ),
                          child: const Icon(
                            Icons.camera_alt,
                            color: AppColors.pureWhite,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Name and Info
                   Text(
                    name??"User",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryNavy,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    'Computer Science • 3rd Year',
                    style: TextStyle(
                      fontSize: 15,
                      color: AppColors.darkGray,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(Icons.location_on, size: 16, color: AppColors.mediumGray),
                      SizedBox(width: 4),
                      Text(
                        'Islamia University of Bahawalpur',
                        style: TextStyle(
                          fontSize: 13,
                          color: AppColors.mediumGray,
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Stats
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _StatItem(label: 'Posts', count: '48'),
                        Container(width: 1, height: 40, color: AppColors.lightGray),
                        _StatItem(label: 'Friends', count: '342'),
                        Container(width: 1, height: 40, color: AppColors.lightGray),
                        _StatItem(label: 'Photos', count: '127'),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Action Buttons
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: () {},
                            icon: const Icon(Icons.edit),
                            label: const Text('Edit Profile'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.accentNavy,
                              foregroundColor: AppColors.pureWhite,
                              elevation: 0,
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 12),
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.offWhite,
                            foregroundColor: AppColors.primaryNavy,
                            elevation: 0,
                            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: const BorderSide(color: AppColors.lightGray),
                            ),
                          ),
                          child: const Icon(Icons.share),
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                ],
              ),
            ),
            
            const SizedBox(height: 12),
            
            // About Section
            Container(
              width: double.infinity,
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
                  const Text(
                    'About',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryNavy,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _InfoRow(
                    icon: Icons.school,
                    label: 'Studying',
                    value: 'Computer Science at IUB',
                  ),
                  const SizedBox(height: 12),
                  _InfoRow(
                    icon: Icons.work,
                    label: 'Interests',
                    value: 'Web Development, AI, Machine Learning',
                  ),
                  const SizedBox(height: 12),
                  _InfoRow(
                    icon: Icons.email,
                    label: 'Email',
                    value: 'your.email@iub.edu.pk',
                  ),
                  const SizedBox(height: 12),
                  _InfoRow(
                    icon: Icons.cake,
                    label: 'Joined',
                    value: 'September 2022',
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 12),
            
            // Quick Links
            Container(
              width: double.infinity,
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
                  const Text(
                    'Quick Links',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryNavy,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _QuickLinkTile(
                    icon: Icons.bookmark,
                    title: 'Saved Posts',
                    onTap: () {},
                  ),
                  _QuickLinkTile(
                    icon: Icons.photo_library,
                    title: 'My Photos',
                    onTap: () {},
                  ),
                  _QuickLinkTile(
                    icon: Icons.group,
                    title: 'My Groups',
                    onTap: () {},
                  ),
                  _QuickLinkTile(
                    icon: Icons.event,
                    title: 'My Events',
                    onTap: () {},
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 12),
            
            // Recent Posts Section Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              child: const Text(
                'My Posts',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppColors.primaryNavy,
                ),
              ),
            ),
            
            // Posts
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 16),
            //   child: Column(
            //     children: const [
            //       PostCard(
            //         userId: 'Your Name',
            //         userAvatar: 'YN',
            //         timeAgo: '1 day ago',
            //         postContent: 'Just finished my final year project presentation! Thanks to everyone who supported me throughout this journey. #IUB #FinalYear 🎓',
            //         postImage: 'project.jpg',
            //         likes: 189,
            //         comments: 34,
            //         shares: 8,
            //       ),
            //       PostCard(
            //         userId: 'Your Name',
            //         userAvatar: 'YN',
            //         timeAgo: '3 days ago',
            //         postContent: 'Had an amazing time at the IUB tech fest! Met some incredible people and learned so much. Can\'t wait for next year! 💻',
            //         likes: 145,
            //         comments: 21,
            //         shares: 5,
            //       ),
            //       PostCard(
            //         userId: 'Your Name',
            //         userAvatar: 'YN',
            //         timeAgo: '1 week ago',
            //         postContent: 'Productive study session at the library today. Sometimes all you need is a good place and determination! 📚✨',
            //         likes: 98,
            //         comments: 12,
            //         shares: 2,
            //       ),
            //     ],
            //   ),
            // ),
            
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String count;

  const _StatItem({required this.label, required this.count});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          count,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: AppColors.primaryNavy,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            color: AppColors.darkGray,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 20, color: AppColors.accentNavy),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.mediumGray,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.primaryNavy,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _QuickLinkTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _QuickLinkTile({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.offWhite,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: AppColors.accentNavy, size: 22),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: AppColors.primaryNavy,
                ),
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.mediumGray),
          ],
        ),
      ),
    );
  }
}
