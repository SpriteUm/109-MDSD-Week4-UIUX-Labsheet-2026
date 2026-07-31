import 'package:flutter/material.dart';

class UserProfileCard extends StatelessWidget {
  final String name;
  final String email;
  final String? avatarUrl;
  final int postsCount;
  final int followersCount;
  final int followingCount;

  const UserProfileCard({
    super.key,
    required this.name,
    required this.email,
    this.avatarUrl,
    required this.postsCount,
    required this.followersCount,
    required this.followingCount,
  });

  // Helper to generate initials from the name
  String get _initials {
    if (name.isEmpty) return '';
    final parts = name.trim().split(' ');
    if (parts.length > 1) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return parts[0][0].toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    // 6. Card widget with Material 3 elevation
    return Card(
      elevation: 1, // Standard M3 Card elevation
      clipBehavior: Clip.antiAlias,
      child: Padding(
        // 8. Proper padding (16px)
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // 1. Circular user avatar with initials fallback
            CircleAvatar(
              radius: 32,
              backgroundColor: colorScheme.primaryContainer,
              foregroundImage: avatarUrl != null ? NetworkImage(avatarUrl!) : null,
              child: Text(
                _initials,
                style: TextStyle(color: colorScheme.onPrimaryContainer),
              ),
            ),
            const SizedBox(height: 8),

            // 2. Username
            Text(
              name,
              style: textTheme.titleLarge?.copyWith(
                color: colorScheme.onSurface,
              ),
            ),

            // 3. Email in onSurfaceVariant color
            Text(
              email,
              style: textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 16),

            // 5. Row of 3 stats: Posts, Followers, Following
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildStatColumn(context, "Posts", postsCount),
                _buildStatColumn(context, "Followers", followersCount),
                _buildStatColumn(context, "Following", followingCount),
              ],
            ),
            const SizedBox(height: 16),

            // 4. Follow (Filled) and Message (Outlined) buttons
            Row(
              children: [
                Expanded(
                  child: FilledButton(
                    onPressed: () {},
                    child: const Text('Follow'),
                  ),
                ),
                const SizedBox(width: 8), // 8px spacing
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {},
                    child: const Text('Message'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // Helper widget for the statistics column
  Widget _buildStatColumn(BuildContext context, String label, int count) {
    final theme = Theme.of(context);
    return Column(
      children: [
        Text(
          count.toString(),
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onSurface,
          ),
        ),
        Text(
          label,
          style: theme.textTheme.labelMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}