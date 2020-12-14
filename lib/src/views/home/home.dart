import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myevent/src/bloc/tab/tab_bloc.dart';
import 'package:myevent/src/views/accueil/accueil.dart';
import 'package:myevent/src/views/home/tabSelect.dart';
import 'package:myevent/src/views/myevent/myevent.dart';
import 'package:myevent/src/views/notification/notification.dart';
import 'package:myevent/src/views/profile/profile.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _newNotification = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TabBloc, AppTabState>(
      builder: (context, state) {
        final activeTab = (state as ChangeTabState).activeTab;

        if (activeTab == null) throw Exception('Active tab is null');

        //  if(_newNotification) saveNotif();

        return Scaffold(
          body: Center(
            child: _tabContent(activeTab),
          ),
          bottomNavigationBar: TabSelector(
            activeTab: activeTab,
            onTabSelected: (tab) {
              BlocProvider.of<TabBloc>(context).add(UpdateTab(tab));
            },
            notif: _newNotification,
          ),
          /*  floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: FloatingActionButton(
            backgroundColor: Theme.of(context).accentColor,
            elevation: 10.0,
            child: Icon(
              Icons.add,
            ),
            onPressed: () {},
          ),*/
        );
      },
    );
  }

  _tabContent(AppTab activeTab) {
    switch (activeTab) {
      case AppTab.home:
        /* return BlocProvider<HouseBloc>(
          create: (context) => getIt<HouseBloc>(),
          child: House(),
        );*/
        return Accueil();
      case AppTab.event:
        /* return BlocProvider<FavoriteBloc>(
          create: (context) => getIt<FavoriteBloc>(),
          child: FavoritePage(),
        );*/
        return MyEvent();
      case AppTab.notifications:
        /* return BlocProvider<ProfileBloc>(
          create: (context) => getIt<ProfileBloc>(),
          child: Profile(),
        );*/
        return NotificationPage();
      case AppTab.me:
        /* return BlocProvider<NotificationBloc>(
          create: (context) => getIt<NotificationBloc>(),
          child: NotificationPage(),
        );*/
        return Profile();
    }
  }
}
