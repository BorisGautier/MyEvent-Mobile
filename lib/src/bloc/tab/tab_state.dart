part of 'tab_bloc.dart';

class AppTabState {
  AppTabState();
}

class ChangeTabState extends AppTabState {
  final AppTab activeTab;
  final bool triggerAnimation;

  ChangeTabState(this.activeTab, {this.triggerAnimation});
}

enum AppTab { home, event, notifications, me }

class AppTabHelper {
  static IconBadge getIcon(AppTab appTab, bool notif) {
    switch (appTab) {
      case AppTab.home:
        return IconBadge(icon: Icons.home, active: false);
      case AppTab.event:
        return IconBadge(icon: Icons.event_available, active: false);
      case AppTab.notifications:
        return IconBadge(icon: Icons.notifications, active: notif);
      case AppTab.me:
        return IconBadge(icon: Icons.person, active: false);

      default:
        throw Exception('Invalid tab icon');
    }
  }

  static String getTitle(AppTab appTab) {
    switch (appTab) {
      case AppTab.home:
        return 'Accueil';
      case AppTab.event:
        return 'My Events';
      case AppTab.notifications:
        return 'Notifications';
      case AppTab.me:
        return 'Profil';

      default:
        throw Exception('Invalid tab title');
    }
  }
}
