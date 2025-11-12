import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../common/custom_app_bar.dart';
import '../common/user_card.dart';

class BrowseScreen extends StatefulWidget {
  const BrowseScreen({super.key});

  @override
  State<BrowseScreen> createState() => _BrowseScreenState();
}

class _BrowseScreenState extends State<BrowseScreen> {
  String selectedFilter = 'All';
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.offWhite,
      appBar: CustomAppBar(
        title: 'Browse Students',
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list, color: AppColors.pureWhite),
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
                hintText: 'Search students by name or department...',
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
          
          // Filter Chips
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 12),
            decoration: const BoxDecoration(
              color: AppColors.pureWhite,
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  _FilterChip(
                    label: 'All',
                    isSelected: selectedFilter == 'All',
                    onTap: () => setState(() => selectedFilter = 'All'),
                  ),
                  const SizedBox(width: 8),
                  _FilterChip(
                    label: 'Computer Science',
                    isSelected: selectedFilter == 'Computer Science',
                    onTap: () => setState(() => selectedFilter = 'Computer Science'),
                  ),
                  const SizedBox(width: 8),
                  _FilterChip(
                    label: 'Business',
                    isSelected: selectedFilter == 'Business',
                    onTap: () => setState(() => selectedFilter = 'Business'),
                  ),
                  const SizedBox(width: 8),
                  _FilterChip(
                    label: 'Engineering',
                    isSelected: selectedFilter == 'Engineering',
                    onTap: () => setState(() => selectedFilter = 'Engineering'),
                  ),
                  const SizedBox(width: 8),
                  _FilterChip(
                    label: 'Medical',
                    isSelected: selectedFilter == 'Medical',
                    onTap: () => setState(() => selectedFilter = 'Medical'),
                  ),
                ],
              ),
            ),
          ),
          
          // Students List
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // Suggested Connections Header
                const Padding(
                  padding: EdgeInsets.only(bottom: 12),
                  child: Text(
                    'Suggested Connections',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryNavy,
                    ),
                  ),
                ),
                
                UserCard(
                  userName: 'Sarah Ahmed',
                  userInitial: 'SA',
                  department: 'Computer Science',
                  year: '3rd Year',
                  mutualFriends: 12,
                  onConnect: () {},
                ),
                UserCard(
                  userName: 'Ali Raza',
                  userInitial: 'AR',
                  department: 'Software Engineering',
                  year: '2nd Year',
                  mutualFriends: 8,
                  onConnect: () {},
                ),
                UserCard(
                  userName: 'Hina Malik',
                  userInitial: 'HM',
                  department: 'Business Administration',
                  year: '4th Year',
                  mutualFriends: 15,
                  onConnect: () {},
                ),
                
                const SizedBox(height: 16),
                const Padding(
                  padding: EdgeInsets.only(bottom: 12),
                  child: Text(
                    'Recently Joined',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: AppColors.primaryNavy,
                    ),
                  ),
                ),
                
                UserCard(
                  userName: 'Bilal Khan',
                  userInitial: 'BK',
                  department: 'Electrical Engineering',
                  year: '1st Year',
                  mutualFriends: 5,
                  onConnect: () {},
                ),
                UserCard(
                  userName: 'Maryam Ali',
                  userInitial: 'MA',
                  department: 'Psychology',
                  year: '2nd Year',
                  mutualFriends: 3,
                  onConnect: () {},
                ),
                UserCard(
                  userName: 'Usman Tariq',
                  userInitial: 'UT',
                  department: 'Computer Science',
                  year: '3rd Year',
                  mutualFriends: 18,
                  onConnect: () {},
                ),
                UserCard(
                  userName: 'Aisha Farooq',
                  userInitial: 'AF',
                  department: 'English Literature',
                  year: '4th Year',
                  mutualFriends: 7,
                  onConnect: () {},
                ),
                UserCard(
                  userName: 'Hamza Shahid',
                  userInitial: 'HS',
                  department: 'Civil Engineering',
                  year: '2nd Year',
                  mutualFriends: 10,
                  onConnect: () {},
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  const _FilterChip({
    required this.label,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.accentNavy : AppColors.offWhite,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected ? AppColors.accentNavy : AppColors.lightGray,
            width: 1.5,
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? AppColors.pureWhite : AppColors.darkGray,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}
