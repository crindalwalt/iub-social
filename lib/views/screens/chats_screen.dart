import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../common/custom_app_bar.dart';
import '../common/chat_tile.dart';

class ChatsScreen extends StatefulWidget {
  const ChatsScreen({super.key});

  @override
  State<ChatsScreen> createState() => _ChatsScreenState();
}

class _ChatsScreenState extends State<ChatsScreen> {
  String selectedTab = 'All';
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.offWhite,
      appBar: CustomAppBar(
        title: 'Messages',
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_square, color: AppColors.pureWhite),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Search Bar
          Container(
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
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search messages...',
                hintStyle: const TextStyle(color: AppColors.mediumGray, fontSize: 14),
                prefixIcon: const Icon(Icons.search, color: AppColors.accentNavy),
                filled: true,
                fillColor: AppColors.offWhite,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            ),
          ),
          
          // Tabs
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: const BoxDecoration(
              color: AppColors.pureWhite,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _TabButton(
                  label: 'All',
                  count: 28,
                  isSelected: selectedTab == 'All',
                  onTap: () => setState(() => selectedTab = 'All'),
                ),
                _TabButton(
                  label: 'Unread',
                  count: 5,
                  isSelected: selectedTab == 'Unread',
                  onTap: () => setState(() => selectedTab = 'Unread'),
                ),
                _TabButton(
                  label: 'Groups',
                  count: 8,
                  isSelected: selectedTab == 'Groups',
                  onTap: () => setState(() => selectedTab = 'Groups'),
                ),
              ],
            ),
          ),
          
          // Chat List
          Expanded(
            child: Container(
              color: AppColors.pureWhite,
              child: ListView(
                padding: EdgeInsets.zero,
                children: const [
                  ChatTile(
                    userName: 'Ahmed Khan',
                    userInitial: 'AK',
                    lastMessage: 'Hey! Are you coming to the library today?',
                    time: '2:45 PM',
                    unreadCount: 2,
                    isOnline: true,
                  ),
                  ChatTile(
                    userName: 'Study Group - CS301',
                    userInitial: 'SG',
                    lastMessage: 'Ali: The assignment deadline has been extended',
                    time: '1:30 PM',
                    unreadCount: 5,
                    isOnline: false,
                  ),
                  ChatTile(
                    userName: 'Fatima Shahid',
                    userInitial: 'FS',
                    lastMessage: 'Thanks for sharing those notes!',
                    time: '12:15 PM',
                    unreadCount: 0,
                    isOnline: true,
                  ),
                  ChatTile(
                    userName: 'Hassan Ali',
                    userInitial: 'HA',
                    lastMessage: 'See you at the cafeteria',
                    time: '11:20 AM',
                    unreadCount: 0,
                    isOnline: false,
                  ),
                  ChatTile(
                    userName: 'IUB Events Team',
                    userInitial: 'ET',
                    lastMessage: 'Sports week registration is now open!',
                    time: '10:05 AM',
                    unreadCount: 1,
                    isOnline: false,
                  ),
                  ChatTile(
                    userName: 'Ayesha Malik',
                    userInitial: 'AM',
                    lastMessage: 'Did you finish the presentation?',
                    time: '9:30 AM',
                    unreadCount: 0,
                    isOnline: true,
                  ),
                  ChatTile(
                    userName: 'Project Team - Web Dev',
                    userInitial: 'PT',
                    lastMessage: 'Usman: I\'ve pushed the latest changes',
                    time: 'Yesterday',
                    unreadCount: 3,
                    isOnline: false,
                  ),
                  ChatTile(
                    userName: 'Zainab Ahmed',
                    userInitial: 'ZA',
                    lastMessage: 'That was a great lecture today!',
                    time: 'Yesterday',
                    unreadCount: 0,
                    isOnline: false,
                  ),
                  ChatTile(
                    userName: 'Bilal Khan',
                    userInitial: 'BK',
                    lastMessage: 'Can you help me with the database assignment?',
                    time: 'Yesterday',
                    unreadCount: 0,
                    isOnline: true,
                  ),
                  ChatTile(
                    userName: 'CS Department Announcements',
                    userInitial: 'CS',
                    lastMessage: 'Reminder: Faculty meeting tomorrow at 10 AM',
                    time: 'Monday',
                    unreadCount: 0,
                    isOnline: false,
                  ),
                  ChatTile(
                    userName: 'Maryam Ali',
                    userInitial: 'MA',
                    lastMessage: 'Let\'s meet at the library tomorrow',
                    time: 'Monday',
                    unreadCount: 0,
                    isOnline: false,
                  ),
                  ChatTile(
                    userName: 'Usman Tariq',
                    userInitial: 'UT',
                    lastMessage: 'Thanks for the recommendation!',
                    time: 'Sunday',
                    unreadCount: 0,
                    isOnline: true,
                  ),
                  ChatTile(
                    userName: 'Final Year Project Group',
                    userInitial: 'FY',
                    lastMessage: 'Meeting scheduled for Friday at 3 PM',
                    time: 'Sunday',
                    unreadCount: 0,
                    isOnline: false,
                  ),
                  ChatTile(
                    userName: 'Hina Siddique',
                    userInitial: 'HS',
                    lastMessage: 'Good luck with your exam!',
                    time: 'Saturday',
                    unreadCount: 0,
                    isOnline: false,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.accentNavy,
        child: const Icon(Icons.message, color: AppColors.pureWhite),
      ),
    );
  }
}

class _TabButton extends StatelessWidget {
  final String label;
  final int count;
  final bool isSelected;
  final VoidCallback onTap;

  const _TabButton({
    required this.label,
    required this.count,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.accentNavy : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Text(
              label,
              style: TextStyle(
                color: isSelected ? AppColors.pureWhite : AppColors.darkGray,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
            const SizedBox(width: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.pureWhite : AppColors.lightGray,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '$count',
                style: TextStyle(
                  color: isSelected ? AppColors.accentNavy : AppColors.darkGray,
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
