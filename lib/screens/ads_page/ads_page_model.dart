import 'package:flutterflow_ui_pro/flutterflow_ui_pro.dart';
import 'package:marketika_dashboard/components/ad_item/ad_item_widget.dart';
import 'package:marketika_dashboard/components/side_nav_bar/side_nav_bar_model.dart';

import 'ads_page.dart' show AdsPage;
import 'package:flutter/material.dart';

class AdsPageModel extends FlutterFlowModel<AdsPage> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Model for sideBarNav component.
  late SideNavBarModel sideBarNavModel;

  final List<AdItemWidget> ads = [];

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
