import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:myevent/src/widgets/badge.dart';

part 'tab_event.dart';
part 'tab_state.dart';

class TabBloc extends Bloc<TabEvent, AppTabState> {
  TabBloc() : super(ChangeTabState(AppTab.home));

  @override
  Stream<AppTabState> mapEventToState(
    TabEvent event,
  ) async* {
    if (event is UpdateTab) {
      yield ChangeTabState(event.tab);
    }
  }
}
