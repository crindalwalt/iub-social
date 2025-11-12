# IUB Social - Social Media App for IUB Students

A modern, professional social media application designed specifically for students at Islamia University of Bahawalpur (IUB).

## Features

### � Onboarding Flow
- **Onboarding Screen**: Beautiful 3-page introduction with smooth page indicators
- **Login Screen**: Clean login interface with email/password and Google sign-in
- **Register Screen**: Comprehensive registration form with department selection
- **Email Verification**: 6-digit OTP verification with resend functionality

### �🏠 Feed Screen
- View and create posts from IUB students
- Interactive stories section
- Like, comment, and share posts
- Create new posts with text and images
- Floating action button for quick post creation

### 🔍 Browse Screen
- Discover and connect with IUB students
- Filter by department (Computer Science, Business, Engineering, Medical)
- Search students by name or department
- View suggested connections based on mutual friends
- See recently joined students
- Quick connect functionality

### 💬 Chats Screen
- Message other IUB students
- Tab-based navigation (All, Unread, Groups)
- Real-time online status indicators
- Unread message counters
- Group chat support
- Quick message composition

### 👤 Profile Screen
- Personal profile with stats (Posts, Friends, Photos)
- Edit profile functionality
- About section with student information
- Quick links (Saved Posts, Photos, Groups, Events)
- View your own posts
- Share profile

## Design

### Color Palette
The app uses a premium navy and white color scheme:
- **Primary Navy**: #001F3F
- **Dark Navy**: #001529
- **Light Navy**: #003D5C
- **Accent Navy**: #0055A5
- **Pure White**: #FFFFFF
- **Off White**: #F8F9FA
- **Light Gray**: #E9ECEF
- **Medium Gray**: #ADB5BD
- **Dark Gray**: #6C757D

### Common Components
All reusable components are located in `lib/views/common/`:
- `custom_app_bar.dart` - Consistent app bar across all screens
- `post_card.dart` - Social media post display
- `story_circle.dart` - Story viewer circles
- `chat_tile.dart` - Chat list item
- `user_card.dart` - User profile card for browsing
- `main_navigation.dart` - Bottom navigation bar

## Project Structure

```
lib/
├── main.dart                    # App entry point
├── utils/
│   └── app_colors.dart         # Color constants
└── views/
    ├── common/                 # Reusable components
    │   ├── custom_app_bar.dart
    │   ├── post_card.dart
    │   ├── story_circle.dart
    │   ├── chat_tile.dart
    │   ├── user_card.dart
    │   └── main_navigation.dart
    └── screens/                # Main app screens
        ├── auth/               # Authentication screens
        │   ├── login.dart
        │   ├── register.dart
        │   └── email_verification.dart
        ├── onboarding/
        │   └── onboarding.dart
        ├── feed_screen.dart
        ├── browse_screen.dart
        ├── chats_screen.dart
        ├── profile_screen.dart
        └── splash_screen.dart
```

## Getting Started

### Prerequisites
- Flutter SDK (>=3.0.0)
- Dart SDK (>=3.0.0)

### Installation

1. Clone the repository
```bash
git clone [repository-url]
cd iub_social
```

2. Install dependencies
```bash
flutter pub get
```

3. Run the app
```bash
flutter run
```

## UI Features

- Modern, clean design with consistent styling
- Smooth navigation with bottom navigation bar
- Responsive layouts
- Professional navy and white color scheme
- Material Design 3 principles
- Floating action buttons for quick actions
- Interactive elements with proper feedback
- Shadow effects for depth
- Rounded corners for modern look

## Static Data

Currently, the app uses static/mock data for demonstration purposes. All posts, users, chats, and profile information are hardcoded for UI demonstration.

## Future Enhancements

- Backend integration
- Real-time messaging
- User authentication
- Image upload functionality
- Push notifications
- Dark mode support
- Advanced search filters
- Story posting and viewing
- Event management
- Department-specific groups

## Developer Notes

The app is built with:
- **Flutter** for cross-platform development
- **Material Design 3** for UI components
- **StatefulWidget** for interactive screens
- **StatelessWidget** for static components
- Clean architecture with separated concerns

---

Made with ❤️ for IUB Students
