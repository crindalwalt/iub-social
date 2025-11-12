import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';

class StoryCircle extends StatelessWidget {
  final String userName;
  final String userInitial;
  final bool isOwn;

  const StoryCircle({
    super.key,
    required this.userName,
    required this.userInitial,
    this.isOwn = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [AppColors.accentNavy, AppColors.lightNavy],
                  ),
                  border: Border.all(color: AppColors.pureWhite, width: 3),
                ),
                child: Center(
                  child: Text(
                    userInitial,
                    style: const TextStyle(
                      color: AppColors.pureWhite,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              if (isOwn)
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: AppColors.accentNavy,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.pureWhite, width: 2),
                    ),
                    child: const Icon(
                      Icons.add,
                      color: AppColors.pureWhite,
                      size: 16,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 6),
          SizedBox(
            width: 72,
            child: Text(
              userName,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 12,
                color: AppColors.primaryNavy,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
