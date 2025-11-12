import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';

class ChatTile extends StatelessWidget {
  final String userName;
  final String userInitial;
  final String lastMessage;
  final String time;
  final int unreadCount;
  final bool isOnline;

  const ChatTile({
    super.key,
    required this.userName,
    required this.userInitial,
    required this.lastMessage,
    required this.time,
    this.unreadCount = 0,
    this.isOnline = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 4),
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        border: Border(
          bottom: BorderSide(
            color: AppColors.lightGray.withOpacity(0.5),
            width: 1,
          ),
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: Stack(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: AppColors.lightNavy,
              child: Text(
                userInitial,
                style: const TextStyle(
                  color: AppColors.pureWhite,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            if (isOnline)
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  width: 16,
                  height: 16,
                  decoration: BoxDecoration(
                    color: AppColors.successGreen,
                    shape: BoxShape.circle,
                    border: Border.all(color: AppColors.pureWhite, width: 2),
                  ),
                ),
              ),
          ],
        ),
        title: Text(
          userName,
          style: TextStyle(
            fontWeight: unreadCount > 0 ? FontWeight.w700 : FontWeight.w600,
            fontSize: 16,
            color: AppColors.primaryNavy,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            lastMessage,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 14,
              color: unreadCount > 0 ? AppColors.primaryNavy : AppColors.darkGray,
              fontWeight: unreadCount > 0 ? FontWeight.w500 : FontWeight.normal,
            ),
          ),
        ),
        trailing: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              time,
              style: TextStyle(
                fontSize: 12,
                color: unreadCount > 0 ? AppColors.accentNavy : AppColors.darkGray,
                fontWeight: unreadCount > 0 ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
            if (unreadCount > 0) ...[
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: const BoxDecoration(
                  color: AppColors.accentNavy,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  unreadCount > 9 ? '9+' : '$unreadCount',
                  style: const TextStyle(
                    color: AppColors.pureWhite,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
