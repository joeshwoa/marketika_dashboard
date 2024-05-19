import 'package:flutterflow_ui_pro/flutterflow_ui_pro.dart';
import 'package:marketika_dashboard/components/article_item/article_item_widget.dart';
import 'package:marketika_dashboard/components/side_nav_bar/side_nav_bar_model.dart';

import 'articles_page.dart' show ArticlesPage;
import 'package:flutter/material.dart';

class ArticlesPageModel extends FlutterFlowModel<ArticlesPage> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // Model for sideBarNav component.
  late SideNavBarModel sideBarNavModel;

  final List<ArticleItemWidget> articles = [];

  int currentPage = 1;
  int numberOfPages = 1;

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
