import 'package:flutterflow_ui_pro/flutterflow_ui_pro.dart';
import 'package:marketika_dashboard/components/notification_item/notification_item_widget.dart';
import 'package:marketika_dashboard/components/side_nav_bar/side_nav_bar_model.dart';

import 'notifications_page.dart' show NotificationsPage;
import 'package:flutter/material.dart';

class NotificationsPageModel extends FlutterFlowModel<NotificationsPage> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Model for sideBarNav component.
  late SideNavBarModel sideBarNavModel;

  final List<NotificationItemWidget> notifications = [];

  @override
  void initState(BuildContext context) {
    sideBarNavModel = createModel(context, () => SideNavBarModel());
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    sideBarNavModel.dispose();
  }
}
