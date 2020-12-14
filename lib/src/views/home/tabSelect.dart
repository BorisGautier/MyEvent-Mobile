import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myevent/src/bloc/tab/tab_bloc.dart';
import 'package:myevent/src/utils/colors.dart';
import 'package:myevent/src/widgets/bubbleBottomBar.dart';
import 'package:myevent/src/widgets/extension.dart';

class TabSelector extends StatefulWidget {
  final AppTab activeTab;
  final Function(AppTab) onTabSelected;
  final bool notif;

  TabSelector({
    @required this.activeTab,
    @required this.onTabSelected,
    @required this.notif,
  });

  @override
  _TabSelectorState createState() => _TabSelectorState();
}

class _TabSelectorState extends State<TabSelector>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 800));
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    changeStatusColor(Colors.transparent);
    return BlocListener<TabBloc, AppTabState>(
      listener: (context, state) {
        if ((state as ChangeTabState).triggerAnimation != null) {
          _animationController.forward();
        }
      },
      child: BlocBuilder<TabBloc, AppTabState>(
        builder: (context, state) {
          return BubbleBottomBar(
            opacity: .2,
            currentIndex: AppTab.values.indexOf(widget.activeTab),
            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
            elevation: 8,
            onTap: (index) => widget.onTabSelected(AppTab.values[index]),
            //new
            hasNotch: false,
            //new
            hasInk: true,
            //new, gives a cute ink effect
            inkColor: darkPrimaryColor,
            items: AppTab.values.map((tab) {
              return BubbleBottomBarItem(
                backgroundColor: darkPrimaryColor,
                icon: AppTabHelper.getIcon(tab, widget.notif),
                activeIcon: AppTabHelper.getIcon(tab, widget.notif),
                title: Text(
                  AppTabHelper.getTitle(tab),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
