import 'package:flutterflow_ui_pro/flutterflow_ui_pro.dart';

import 'write_article.dart' show WriteArticle;
import 'package:flutter/material.dart';

class WriteArticleModel extends FlutterFlowModel<WriteArticle> {
  ///  State fields for stateful widgets in this page.

  final unfocusNode = FocusNode();
  // State field(s) for TextField widget.
  FocusNode? titleFieldFocusNode;
  TextEditingController? titleController;
  String? Function(BuildContext, String?)? titleControllerValidator;
  FocusNode? descriptionFieldFocusNode;
  TextEditingController? descriptionController;
  String? Function(BuildContext, String?)? descriptionControllerValidator;
  FocusNode? imageFieldFocusNode;
  TextEditingController? imageController;
  String? Function(BuildContext, String?)? imageControllerValidator;
  FocusNode? authorImageFieldFocusNode;
  TextEditingController? authorImageController;
  String? Function(BuildContext, String?)? authorImageControllerValidator;
  FocusNode? authorNameFieldFocusNode;
  TextEditingController? authorNameController;
  String? Function(BuildContext, String?)? authorNameControllerValidator;
  FocusNode? authorLocationFieldFocusNode;
  TextEditingController? authorLocationController;
  String? Function(BuildContext, String?)? authorLocationControllerValidator;
  FocusNode? videoFieldFocusNode;
  TextEditingController? videoController;
  String? Function(BuildContext, String?)? videoControllerValidator;
  FocusNode? authorMetaFieldFocusNode;
  TextEditingController? authorMetaController;
  String? Function(BuildContext, String?)? authorMetaControllerValidator;
  FocusNode? descriptionMetaFieldFocusNode;
  TextEditingController? descriptionMetaController;
  String? Function(BuildContext, String?)? descriptionMetaControllerValidator;
  FocusNode? keywordsMetaFieldFocusNode;
  TextEditingController? keywordsMetaController;
  String? Function(BuildContext, String?)? keywordsMetaControllerValidator;
  FocusNode? ogTitleMetaFieldFocusNode;
  TextEditingController? ogTitleMetaController;
  String? Function(BuildContext, String?)? ogTitleMetaControllerValidator;


  @override
  void initState(BuildContext context) {
  }

  @override
  void dispose() {
    unfocusNode.dispose();
    titleFieldFocusNode?.dispose();
    titleController?.dispose();
    descriptionFieldFocusNode?.dispose();
    descriptionController?.dispose();
    imageFieldFocusNode?.dispose();
    imageController?.dispose();
    authorImageFieldFocusNode?.dispose();
    authorImageController?.dispose();
    authorNameFieldFocusNode?.dispose();
    authorNameController?.dispose();
    authorLocationFieldFocusNode?.dispose();
    authorLocationController?.dispose();
    videoFieldFocusNode?.dispose();
    videoController?.dispose();
    authorMetaFieldFocusNode?.dispose();
    authorMetaController?.dispose();
    descriptionMetaFieldFocusNode?.dispose();
    descriptionMetaController?.dispose();
    keywordsMetaFieldFocusNode?.dispose();
    keywordsMetaController?.dispose();
    ogTitleMetaFieldFocusNode?.dispose();
    ogTitleMetaController?.dispose();
  }
}
