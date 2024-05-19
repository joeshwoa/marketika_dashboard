import 'package:flutter/material.dart';
import 'package:flutterflow_ui_pro/flutterflow_ui_pro.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marketika_dashboard/components/empty_notification_item/empty_notification_item_widget.dart';
import 'package:marketika_dashboard/components/notification_item/notification_item_widget.dart';
import 'package:marketika_dashboard/components/side_nav_bar/side_nav_bar_widget.dart';
import 'package:marketika_dashboard/main.dart';
import 'package:pager/pager.dart';
import 'package:flutter/scheduler.dart';

import 'notifications_page_model.dart';
export 'notifications_page_model.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() =>
      _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  late NotificationsPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  bool isLoading = false;
  int _currentPage = 1;
  int numberOfPages = 1;

  bool sending = false;

  FocusNode? titleFieldFocusNode;
  TextEditingController? titleController;
  String? Function(BuildContext, String?)? titleControllerValidator;
  FocusNode? bodyFieldFocusNode;
  TextEditingController? bodyController;
  String? Function(BuildContext, String?)? bodyControllerValidator;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => NotificationsPageModel());

    titleController ??= TextEditingController();
    titleFieldFocusNode ??= FocusNode();
    bodyController ??= TextEditingController();
    bodyFieldFocusNode ??= FocusNode();

    // On page load action.
    SchedulerBinding.instance.addPostFrameCallback((_) async {

      final data = await supabase.from('notifications').count();
      setState(() {
        numberOfPages = (data / 10).ceil();
        if(numberOfPages == 0) {
          numberOfPages = 1;
        }
      });
      _fetchNotificationItems();

    });

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  Future<void> _fetchNotificationItems() async {
    setState(() {
      isLoading = true;
    });

    final data = await supabase.from('notifications').select('id, title, body, created_at').range(((_currentPage-1)*10), ((_currentPage-1)*10)+9).order('created_at');

    setState(() {
      final adItems = data
          .map((notificationItemData) => NotificationItemWidget(
        id: notificationItemData['id'] as int,
        title: notificationItemData['title'] as String,
        body: notificationItemData['body'] as String,
        created: DateTime.parse(notificationItemData['created_at'] as String),
        model: _model,
      ))
          .toList();

      _model.notifications.clear();
      _model.notifications.addAll(adItems);
      isLoading = false;
    });
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _model.unfocusNode.canRequestFocus
          ? FocusScope.of(context).requestFocus(_model.unfocusNode)
          : FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        body: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (responsiveVisibility(
              context: context,
              phone: false,
              tablet: false,
            ))
              wrapWithModel(
                model: _model.sideBarNavModel,
                updateCallback: () => setState(() {}),
                child: SideNavBarWidget(
                  index: 1,
                ),
              ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    if (responsiveVisibility(
                      context: context,
                      tabletLandscape: false,
                      desktop: false,
                    ))
                      Align(
                        alignment: AlignmentDirectional(0, 0),
                        child: Container(
                          width: double.infinity,
                          height: 44,
                          decoration: BoxDecoration(
                            color:
                            FlutterFlowTheme.of(context).primaryBackground,
                            borderRadius: BorderRadius.circular(0),
                          ),
                          alignment: AlignmentDirectional(0, 0),
                        ),
                      ),
                    Align(
                      alignment: AlignmentDirectional(0, 0),
                      child: Padding(
                        padding: EdgeInsets.all(16),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 4,
                                color: Color(0x33000000),
                                offset: Offset(
                                  0,
                                  2,
                                ),
                              )
                            ],
                            borderRadius: BorderRadius.circular(16),
                          ),
                          alignment: AlignmentDirectional(0, -1),
                          child: Padding(
                            padding:
                            EdgeInsetsDirectional.fromSTEB(0, 0, 0, 16),
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisSize: MainAxisSize.max,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 1, 0, 0),
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                        boxShadow: [
                                          BoxShadow(
                                            blurRadius: 0,
                                            color: FlutterFlowTheme.of(context)
                                                .lineColor,
                                            offset: Offset(
                                              0,
                                              1,
                                            ),
                                          )
                                        ],
                                        borderRadius: BorderRadius.only(
                                          bottomLeft: Radius.circular(0),
                                          bottomRight: Radius.circular(0),
                                          topLeft: Radius.circular(16),
                                          topRight: Radius.circular(16),
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.all(16),
                                        child: Row(
                                          mainAxisSize: MainAxisSize.max,
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                mainAxisSize: MainAxisSize.max,
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Your Notifications',
                                                    style: FlutterFlowTheme.of(
                                                        context)
                                                        .headlineSmall
                                                        .override(
                                                      fontFamily:
                                                      FlutterFlowTheme.of(
                                                          context)
                                                          .headlineSmallFamily,
                                                      letterSpacing: 0,
                                                      useGoogleFonts: GoogleFonts
                                                          .asMap()
                                                          .containsKey(
                                                          FlutterFlowTheme.of(
                                                              context)
                                                              .headlineSmallFamily),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                    EdgeInsetsDirectional
                                                        .fromSTEB(
                                                        0, 4, 0, 0),
                                                    child: Text(
                                                      'Below you will find a summary of your Notifications.',
                                                      style:
                                                      FlutterFlowTheme.of(
                                                          context)
                                                          .bodySmall
                                                          .override(
                                                        fontFamily: FlutterFlowTheme.of(
                                                            context)
                                                            .bodySmallFamily,
                                                        letterSpacing:
                                                        0,
                                                        useGoogleFonts: GoogleFonts
                                                            .asMap()
                                                            .containsKey(
                                                            FlutterFlowTheme.of(context)
                                                                .bodySmallFamily),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            FFButtonWidget(
                                              onPressed:
                                                  () {
                                                showDialog(
                                                    context: context,
                                                    builder: (context) => AlertDialog(

                                                      alignment: Alignment.center,
                                                      surfaceTintColor: FlutterFlowTheme.of(context).primaryBackground,
                                                      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
                                                      title: const Text(
                                                        'Add Notification',
                                                        style: TextStyle(
                                                          fontSize: 25,
                                                        ),
                                                      ),
                                                      icon: IconButton(
                                                        onPressed: () {
                                                          titleController!.clear();
                                                          bodyController!.clear();
                                                          Navigator.of(context).pop();
                                                        },
                                                        icon: Icon(Icons.close,color: FlutterFlowTheme.of(context).error,),
                                                        hoverColor: Colors.transparent,
                                                        highlightColor: Colors.transparent,
                                                        alignment: Alignment.centerRight,
                                                      ),
                                                      actions: [
                                                        FFButtonWidget(
                                                          onPressed: () async {
                                                            if(!sending) {
                                                              setState(() {
                                                                sending = true;
                                                              });

                                                              await supabase.from('notifications').insert({
                                                                'title': titleController.text,
                                                                'body': bodyController.text,
                                                              });
                                                              final data = await supabase.from('notifications').select('id, created_at').order('created_at').limit(1);

                                                              setState(() {
                                                                _model.notifications.insert(0, NotificationItemWidget(id: data[0]['id'] as int, body: bodyController.text, title: titleController.text, created: DateTime.parse(data[0]['created_at'] as String), model: _model));
                                                                if(_model.notifications.length > 10) {
                                                                  _model.notifications.removeLast();
                                                                  numberOfPages +=1;
                                                                }
                                                                titleController!.clear();
                                                                bodyController!.clear();
                                                                sending = false;
                                                                _model.updatePage(() {});
                                                              });
                                                              Navigator.pop(context);
                                                            }
                                                          },
                                                          text: 'Add Notification',
                                                          options: FFButtonOptions(
                                                            width: MediaQuery.sizeOf(context).width * 0.20,
                                                            height: MediaQuery.sizeOf(context).height * 0.065,
                                                            padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                                            iconPadding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                                            color: FlutterFlowTheme.of(context).primary,
                                                            textStyle: FlutterFlowTheme.of(context).titleMedium.override(
                                                              fontFamily: 'Lexend Deca',
                                                              color: Colors.white,
                                                              fontSize: 18,
                                                              fontWeight: FontWeight.bold,
                                                            ),
                                                            elevation: 3,
                                                            borderSide: const BorderSide(
                                                              color: Colors.transparent,
                                                              width: 1,
                                                            ),
                                                            borderRadius: BorderRadius.circular(50),
                                                          ),
                                                        )
                                                      ],
                                                      content: Column(
                                                        mainAxisSize: MainAxisSize.min,
                                                        children: [
                                                          Padding(
                                                            padding: const EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                8,
                                                                8,
                                                                8,
                                                                8),
                                                            child:
                                                            TextFormField(
                                                              controller:
                                                              titleController,
                                                              focusNode:
                                                              titleFieldFocusNode,
                                                              autofocus:
                                                              false,
                                                              obscureText:
                                                              false,
                                                              decoration:
                                                              InputDecoration(
                                                                labelText:
                                                                'Notification Title',
                                                                labelStyle: FlutterFlowTheme.of(
                                                                    context)
                                                                    .labelMedium
                                                                    .override(
                                                                  fontFamily:
                                                                  FlutterFlowTheme.of(context).labelMediumFamily,
                                                                  letterSpacing:
                                                                  0,
                                                                  useGoogleFonts:
                                                                  GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).labelMediumFamily),
                                                                ),
                                                                hintStyle: FlutterFlowTheme.of(
                                                                    context)
                                                                    .labelMedium
                                                                    .override(
                                                                  fontFamily:
                                                                  FlutterFlowTheme.of(context).labelMediumFamily,
                                                                  letterSpacing:
                                                                  0,
                                                                  useGoogleFonts:
                                                                  GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).labelMediumFamily),
                                                                ),
                                                                enabledBorder:
                                                                OutlineInputBorder(
                                                                  borderSide:
                                                                  BorderSide(
                                                                    color:
                                                                    FlutterFlowTheme.of(context).alternate,
                                                                    width:
                                                                    2,
                                                                  ),
                                                                  borderRadius:
                                                                  BorderRadius.circular(8),
                                                                ),
                                                                focusedBorder:
                                                                OutlineInputBorder(
                                                                  borderSide:
                                                                  BorderSide(
                                                                    color:
                                                                    FlutterFlowTheme.of(context).primary,
                                                                    width:
                                                                    2,
                                                                  ),
                                                                  borderRadius:
                                                                  BorderRadius.circular(8),
                                                                ),
                                                                errorBorder:
                                                                OutlineInputBorder(
                                                                  borderSide:
                                                                  BorderSide(
                                                                    color:
                                                                    FlutterFlowTheme.of(context).error,
                                                                    width:
                                                                    2,
                                                                  ),
                                                                  borderRadius:
                                                                  BorderRadius.circular(8),
                                                                ),
                                                                focusedErrorBorder:
                                                                OutlineInputBorder(
                                                                  borderSide:
                                                                  BorderSide(
                                                                    color:
                                                                    FlutterFlowTheme.of(context).error,
                                                                    width:
                                                                    2,
                                                                  ),
                                                                  borderRadius:
                                                                  BorderRadius.circular(8),
                                                                ),
                                                              ),
                                                              style: FlutterFlowTheme.of(
                                                                  context)
                                                                  .bodyMedium
                                                                  .override(
                                                                fontFamily:
                                                                FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                letterSpacing:
                                                                0,
                                                                useGoogleFonts:
                                                                GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodyMediumFamily),
                                                              ),
                                                              validator: titleControllerValidator
                                                                  .asValidator(
                                                                  context),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding: const EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                8,
                                                                8,
                                                                8,
                                                                8),
                                                            child:
                                                            TextFormField(
                                                              controller:
                                                              bodyController,
                                                              focusNode:
                                                              bodyFieldFocusNode,
                                                              autofocus:
                                                              false,
                                                              obscureText:
                                                              false,
                                                              decoration:
                                                              InputDecoration(
                                                                labelText:
                                                                'Notification Body',
                                                                labelStyle: FlutterFlowTheme.of(
                                                                    context)
                                                                    .labelMedium
                                                                    .override(
                                                                  fontFamily:
                                                                  FlutterFlowTheme.of(context).labelMediumFamily,
                                                                  letterSpacing:
                                                                  0,
                                                                  useGoogleFonts:
                                                                  GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).labelMediumFamily),
                                                                ),
                                                                hintStyle: FlutterFlowTheme.of(
                                                                    context)
                                                                    .labelMedium
                                                                    .override(
                                                                  fontFamily:
                                                                  FlutterFlowTheme.of(context).labelMediumFamily,
                                                                  letterSpacing:
                                                                  0,
                                                                  useGoogleFonts:
                                                                  GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).labelMediumFamily),
                                                                ),
                                                                enabledBorder:
                                                                OutlineInputBorder(
                                                                  borderSide:
                                                                  BorderSide(
                                                                    color:
                                                                    FlutterFlowTheme.of(context).alternate,
                                                                    width:
                                                                    2,
                                                                  ),
                                                                  borderRadius:
                                                                  BorderRadius.circular(8),
                                                                ),
                                                                focusedBorder:
                                                                OutlineInputBorder(
                                                                  borderSide:
                                                                  BorderSide(
                                                                    color:
                                                                    FlutterFlowTheme.of(context).primary,
                                                                    width:
                                                                    2,
                                                                  ),
                                                                  borderRadius:
                                                                  BorderRadius.circular(8),
                                                                ),
                                                                errorBorder:
                                                                OutlineInputBorder(
                                                                  borderSide:
                                                                  BorderSide(
                                                                    color:
                                                                    FlutterFlowTheme.of(context).error,
                                                                    width:
                                                                    2,
                                                                  ),
                                                                  borderRadius:
                                                                  BorderRadius.circular(8),
                                                                ),
                                                                focusedErrorBorder:
                                                                OutlineInputBorder(
                                                                  borderSide:
                                                                  BorderSide(
                                                                    color:
                                                                    FlutterFlowTheme.of(context).error,
                                                                    width:
                                                                    2,
                                                                  ),
                                                                  borderRadius:
                                                                  BorderRadius.circular(8),
                                                                ),
                                                              ),
                                                              style: FlutterFlowTheme.of(
                                                                  context)
                                                                  .bodyMedium
                                                                  .override(
                                                                fontFamily:
                                                                FlutterFlowTheme.of(context).bodyMediumFamily,
                                                                letterSpacing:
                                                                0,
                                                                useGoogleFonts:
                                                                GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodyMediumFamily),
                                                              ),
                                                              validator: bodyControllerValidator
                                                                  .asValidator(
                                                                  context),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ) );
                                              },
                                              text: 'Add Notification',
                                              icon: Icon(
                                                Icons.add_rounded,
                                                size: 15,
                                              ),
                                              options: FFButtonOptions(
                                                width: 150,
                                                height: 40,
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(0, 0, 0, 0),
                                                iconPadding:
                                                EdgeInsetsDirectional
                                                    .fromSTEB(0, 0, 0, 0),
                                                color:
                                                FlutterFlowTheme.of(context)
                                                    .primary,
                                                textStyle:
                                                FlutterFlowTheme.of(context)
                                                    .titleSmall
                                                    .override(
                                                  fontFamily:
                                                  FlutterFlowTheme.of(
                                                      context)
                                                      .titleSmallFamily,
                                                  color: Colors.white,
                                                  letterSpacing: 0,
                                                  useGoogleFonts: GoogleFonts
                                                      .asMap()
                                                      .containsKey(
                                                      FlutterFlowTheme.of(
                                                          context)
                                                          .titleSmallFamily),
                                                ),
                                                elevation: 3,
                                                borderSide: BorderSide(
                                                  color: Colors.transparent,
                                                  width: 1,
                                                ),
                                                borderRadius:
                                                BorderRadius.circular(50),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        16, 0, 16, 0),
                                    child: Container(
                                      width: MediaQuery.sizeOf(context).width,
                                      decoration: BoxDecoration(
                                        color: FlutterFlowTheme.of(context)
                                            .secondaryBackground,
                                        borderRadius: BorderRadius.circular(16),
                                        border: Border.all(
                                          color: FlutterFlowTheme.of(context)
                                              .lineColor,
                                          width: 1,
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsetsDirectional.fromSTEB(
                                            0, 16, 0, 12),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.max,
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: EdgeInsetsDirectional
                                                  .fromSTEB(12, 12, 12, 0),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                children: [
                                                  Expanded(
                                                    child: Text(
                                                      'Title',
                                                      style:
                                                      FlutterFlowTheme.of(
                                                          context)
                                                          .bodySmall
                                                          .override(
                                                        fontFamily: FlutterFlowTheme.of(
                                                            context)
                                                            .bodySmallFamily,
                                                        color: FlutterFlowTheme.of(
                                                            context)
                                                            .primaryText,
                                                        letterSpacing:
                                                        0,
                                                        fontWeight:
                                                        FontWeight
                                                            .w500,
                                                        useGoogleFonts: GoogleFonts
                                                            .asMap()
                                                            .containsKey(
                                                            FlutterFlowTheme.of(context)
                                                                .bodySmallFamily),
                                                      ),
                                                    ),
                                                  ),
                                                  if (responsiveVisibility(
                                                    context: context,
                                                    phone: false,
                                                    tablet: false,
                                                  ))
                                                    Expanded(
                                                      flex: 2,
                                                      child: Text(
                                                        'Body',
                                                        style:
                                                        FlutterFlowTheme.of(
                                                            context)
                                                            .bodySmall
                                                            .override(
                                                          fontFamily: FlutterFlowTheme.of(
                                                              context)
                                                              .bodySmallFamily,
                                                          color: FlutterFlowTheme.of(
                                                              context)
                                                              .primaryText,
                                                          letterSpacing:
                                                          0,
                                                          fontWeight:
                                                          FontWeight
                                                              .w500,
                                                          useGoogleFonts: GoogleFonts
                                                              .asMap()
                                                              .containsKey(
                                                              FlutterFlowTheme.of(context)
                                                                  .bodySmallFamily),
                                                        ),
                                                      ),
                                                    ),
                                                  if (responsiveVisibility(
                                                    context: context,
                                                    phone: false,
                                                    tablet: false,
                                                  ))
                                                    Expanded(
                                                      child: Text(
                                                        'Date Created',
                                                        style:
                                                        FlutterFlowTheme.of(
                                                            context)
                                                            .bodySmall
                                                            .override(
                                                          fontFamily: FlutterFlowTheme.of(
                                                              context)
                                                              .bodySmallFamily,
                                                          color: FlutterFlowTheme.of(
                                                              context)
                                                              .primaryText,
                                                          letterSpacing:
                                                          0,
                                                          fontWeight:
                                                          FontWeight
                                                              .w500,
                                                          useGoogleFonts: GoogleFonts
                                                              .asMap()
                                                              .containsKey(
                                                              FlutterFlowTheme.of(context)
                                                                  .bodySmallFamily),
                                                        ),
                                                      ),
                                                    ),
                                                  Expanded(
                                                    child: Padding(
                                                      padding:
                                                      EdgeInsetsDirectional
                                                          .fromSTEB(
                                                          0, 0, 8, 0),
                                                      child: Text(
                                                        ' ',
                                                        textAlign:
                                                        TextAlign.end,
                                                        style:
                                                        FlutterFlowTheme.of(
                                                            context)
                                                            .bodySmall
                                                            .override(
                                                          fontFamily: FlutterFlowTheme.of(
                                                              context)
                                                              .bodySmallFamily,
                                                          color: FlutterFlowTheme.of(
                                                              context)
                                                              .primaryText,
                                                          letterSpacing:
                                                          0,
                                                          fontWeight:
                                                          FontWeight
                                                              .w500,
                                                          useGoogleFonts: GoogleFonts
                                                              .asMap()
                                                              .containsKey(
                                                              FlutterFlowTheme.of(context)
                                                                  .bodySmallFamily),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(0, 16, 0, 0),
                                                child: ListView.builder(
                                                  padding: EdgeInsets.zero,
                                                  shrinkWrap: true,
                                                  physics: NeverScrollableScrollPhysics(),
                                                  scrollDirection: Axis.vertical,
                                                  itemCount: isLoading?10:_model.notifications.length,
                                                  itemBuilder: (context, index) {
                                                    if (!isLoading) {
                                                      return _model.notifications[index];
                                                    } else {
                                                      // Render loading indicator while fetching more data
                                                      return EmptyNotificationItemWidget();
                                                    }
                                                  },
                                                ),
                                              ),
                                            ),
                                            Center(
                                              child: Pager(
                                                currentPage: _currentPage,
                                                totalPages: numberOfPages,
                                                onPageChanged: (page) {
                                                  setState(() {
                                                    _currentPage = page;
                                                    _fetchNotificationItems();
                                                  });
                                                },
                                                numberButtonSelectedColor: FlutterFlowTheme.of(context).primary,
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
