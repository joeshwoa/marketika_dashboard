import 'package:flutter/material.dart';
import 'package:flutterflow_ui_pro/flutterflow_ui_pro.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:marketika_dashboard/main.dart';
import 'package:marketika_dashboard/screens/ads_page/ads_page_model.dart';
import 'dart:ui' as ui;

class AdItemWidget extends StatefulWidget {
  const AdItemWidget({super.key, required this.id, required this.subTitle, required this.title, required this.created, required this.image, required this.page, required this.model});

  final int id;
  final String title;
  final String subTitle;
  final DateTime created;
  final String image;
  final String page;
  final AdsPageModel model;

  @override
  State<AdItemWidget> createState() => _AdItemWidgetState();
}

class _AdItemWidgetState extends State<AdItemWidget> {
  bool loading = false;

  FocusNode? titleFieldFocusNode;
  TextEditingController? titleController;
  String? Function(BuildContext, String?)? titleControllerValidator;
  FocusNode? subTitleFieldFocusNode;
  TextEditingController? subTitleController;
  String? Function(BuildContext, String?)? subTitleControllerValidator;
  FocusNode? imageFieldFocusNode;
  TextEditingController? imageController;
  String? Function(BuildContext, String?)? imageControllerValidator;
  FocusNode? pageFieldFocusNode;
  TextEditingController? pageController;
  String? Function(BuildContext, String?)? pageControllerValidator;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    titleController = TextEditingController(text: widget.title);
    subTitleController = TextEditingController(text: widget.subTitle);
    imageController = TextEditingController(text: widget.image);
    pageController = TextEditingController(text: widget.page);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
      EdgeInsetsDirectional
          .fromSTEB(
          0, 0, 0, 2),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: FlutterFlowTheme
              .of(context)
              .secondaryBackground,
          boxShadow: [
            BoxShadow(
              blurRadius: 0,
              color: FlutterFlowTheme
                  .of(context)
                  .lineColor,
              offset: Offset(
                0,
                1,
              ),
            )
          ],
        ),
        child: Padding(
          padding:
          EdgeInsets.all(12),
          child: Row(
            mainAxisSize:
            MainAxisSize.max,
            children: [
              Expanded(
                child: Column(
                  mainAxisSize:
                  MainAxisSize
                      .max,
                  crossAxisAlignment:
                  CrossAxisAlignment
                      .start,
                  children: [
                    AutoSizeText(
                      widget.title,
                      textDirection: ui.TextDirection.rtl,
                      style: FlutterFlowTheme.of(context)
                          .titleMedium
                          .override(
                        fontFamily: FlutterFlowTheme.of(context).titleMediumFamily,
                        color: FlutterFlowTheme.of(context).primaryText,
                        letterSpacing: 0,
                        useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).titleMediumFamily),
                      ),
                    ),
                    if (responsiveVisibility(
                      context:
                      context,
                      tabletLandscape:
                      false,
                      desktop:
                      false,
                    ))
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            0,
                            2,
                            0,
                            0),
                        child:
                        Text(
                          widget.subTitle,
                          textDirection: ui.TextDirection.rtl,
                          style: FlutterFlowTheme.of(context).bodySmall.override(
                            fontFamily: FlutterFlowTheme.of(context).bodySmallFamily,
                            letterSpacing: 0,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodySmallFamily),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              if (responsiveVisibility(
                context: context,
                phone: false,
                tablet: false,
              ))
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Text(
                        widget.subTitle,
                        textDirection: ui.TextDirection.rtl,
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
                      ),
                    ],
                  ),
                ),
              if (responsiveVisibility(
                context: context,
                phone: false,
                tablet: false,
              ))
                Expanded(
                  child: Center(
                    child: Text(
                      dateTimeFormat(
                          'relative',
                          widget.created),
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
                    ),
                  ),
                ),
              if (responsiveVisibility(
                context: context,
                phone: false,
              ))
                Expanded(
                  child:
                  Container(
                    height: 70,
                    decoration:
                    BoxDecoration(
                      color: FlutterFlowTheme.of(
                          context)
                          .secondaryBackground,
                      borderRadius:
                      BorderRadius
                          .circular(6),
                    ),
                    child:
                    ClipRRect(
                      borderRadius:
                      BorderRadius
                          .circular(8),
                      child:
                      CachedNetworkImage(
                        fadeInDuration:
                        Duration(
                            milliseconds: 500),
                        fadeOutDuration:
                        Duration(
                            milliseconds: 500),
                        imageUrl:
                        widget.image,
                        width:
                        300,
                        height:
                        200,
                        fit: BoxFit
                            .cover,
                        errorWidget: (context, url, error) => Center(child: Icon(Icons.broken_image_rounded, size: 50, color: FlutterFlowTheme.of(context).primaryText,),),
                      ),
                    ),
                  ),
                ),
              Expanded(
                child: Column(
                  mainAxisSize:
                  MainAxisSize
                      .max,
                  crossAxisAlignment:
                  CrossAxisAlignment
                      .end,
                  children: [
                    Row(
                      mainAxisSize:
                      MainAxisSize
                          .max,
                      mainAxisAlignment:
                      MainAxisAlignment
                          .end,
                      children: [
                        Padding(
                          padding:
                          EdgeInsets.all(5),
                          child:
                          FlutterFlowIconButton(
                            borderColor:
                            FlutterFlowTheme.of(context).secondaryText,
                            borderRadius:
                            5,
                            borderWidth:
                            1,
                            buttonSize:
                            40,
                            fillColor:
                            FlutterFlowTheme.of(context).primaryBackground,
                            icon:
                            Icon(
                              Icons.delete_forever,
                              color:
                              FlutterFlowTheme.of(context).primaryText,
                              size:
                              24,
                            ),
                            onPressed:
                                () {
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    alignment: Alignment.center,
                                    surfaceTintColor: FlutterFlowTheme.of(context).primaryBackground,
                                    backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
                                    title: const Text(
                                      'Delete Ad',
                                      style: TextStyle(
                                        fontSize: 25,
                                      ),
                                    ),
                                    icon: IconButton(
                                      onPressed: () {
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
                                          if(!loading) {
                                            loading = true;
                                            await supabase.from('ads').delete().eq('id', widget.id);
                                            loading = false;
                                            widget.model.updatePage(() {
                                              widget.model.ads.removeWhere((element) => element.id == widget.id);
                                            });
                                            Navigator.pop(context);
                                          }
                                        },
                                        text: 'Delete Ad',
                                        options: FFButtonOptions(
                                          width: MediaQuery.sizeOf(context).width * 0.20,
                                          height: MediaQuery.sizeOf(context).height * 0.065,
                                          padding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                          iconPadding: const EdgeInsetsDirectional.fromSTEB(0, 0, 0, 0),
                                          color: FlutterFlowTheme.of(context).error,
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
                                    content: Text(
                                      'Are you sure you want to delete this ${widget.title} ad?',
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                  ) );
                            },
                          ),
                        ),
                        Padding(
                          padding:
                          EdgeInsets.all(5),
                          child:
                          FlutterFlowIconButton(
                            borderColor:
                            FlutterFlowTheme.of(context).secondaryText,
                            borderRadius:
                            5,
                            borderWidth:
                            1,
                            buttonSize:
                            40,
                            fillColor:
                            FlutterFlowTheme.of(context).primaryBackground,
                            icon:
                            Icon(
                              Icons.edit_rounded,
                              color:
                              FlutterFlowTheme.of(context).primaryText,
                              size:
                              24,
                            ),
                            onPressed:
                                () {
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    alignment: Alignment.center,
                                    surfaceTintColor: FlutterFlowTheme.of(context).primaryBackground,
                                    backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
                                    title: const Text(
                                      'Edit Ad',
                                      style: TextStyle(
                                        fontSize: 25,
                                      ),
                                    ),
                                    icon: IconButton(
                                      onPressed: () {
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
                                          if(!loading) {
                                            loading = true;
                                            await supabase.from('ads').update({
                                              'title': titleController.text,
                                              'subTitle': subTitleController.text,
                                              'imageUrl': imageController.text,
                                              'pageUrl': pageController.text
                                            }).eq('id', widget.id);
                                            loading = false;
                                            widget.model.updatePage(() {
                                              int index = widget.model.ads.indexWhere((element) => element.id == widget.id);
                                              widget.model.ads[index] = AdItemWidget(id: widget.id, subTitle: subTitleController.text, title: titleController.text, created: widget.created, image: imageController.text, page: pageController.text, model: widget.model);
                                            });
                                            Navigator.pop(context);
                                          }
                                        },
                                        text: 'Edit Ad',
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
                                              'Ad Title',
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
                                            subTitleController,
                                            focusNode:
                                            subTitleFieldFocusNode,
                                            autofocus:
                                            false,
                                            obscureText:
                                            false,
                                            decoration:
                                            InputDecoration(
                                              labelText:
                                              'Ad Sub Title',
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
                                            validator: subTitleControllerValidator
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
                                            imageController,
                                            focusNode:
                                            imageFieldFocusNode,
                                            autofocus:
                                            false,
                                            obscureText:
                                            false,
                                            decoration:
                                            InputDecoration(
                                              labelText:
                                              'Ad Image URL',
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
                                            validator: imageControllerValidator
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
                                            pageController,
                                            focusNode:
                                            pageFieldFocusNode,
                                            autofocus:
                                            false,
                                            obscureText:
                                            false,
                                            decoration:
                                            InputDecoration(
                                              labelText:
                                              'Ad Page URL',
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
                                            validator: pageControllerValidator
                                                .asValidator(
                                                context),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ) );
                            },
                          ),
                        ),
                      ],
                    ),
                    if (responsiveVisibility(
                      context:
                      context,
                      tablet:
                      false,
                      tabletLandscape:
                      false,
                      desktop:
                      false,
                    ))
                      Padding(
                        padding: EdgeInsetsDirectional
                            .fromSTEB(
                            0,
                            2,
                            0,
                            0),
                        child:
                        Text(
                          dateTimeFormat(
                              'relative',
                              widget.created),
                          style: FlutterFlowTheme.of(context)
                              .bodySmall
                              .override(
                            fontFamily: FlutterFlowTheme.of(context).bodySmallFamily,
                            color: FlutterFlowTheme.of(context).secondaryText,
                            letterSpacing: 0,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodySmallFamily),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
