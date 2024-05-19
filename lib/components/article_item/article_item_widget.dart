import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutterflow_ui_pro/flutterflow_ui_pro.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:marketika_dashboard/main.dart';
import 'package:marketika_dashboard/screens/articles_page/articles_page_model.dart';
import 'package:marketika_dashboard/screens/write_article/write_article.dart';
import 'dart:ui' as ui;

class ArticleItemWidget extends StatefulWidget {
  const ArticleItemWidget({super.key, required this.id, required this.type, required this.title, required this.created, required this.image, required this.model});

  final int id;
  final String type;
  final String title;
  final DateTime created;
  final String image;
  final ArticlesPageModel model;

  @override
  State<ArticleItemWidget> createState() => _ArticleItemWidgetState();
}

class _ArticleItemWidgetState extends State<ArticleItemWidget> {
  bool loading = false;

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
                child: Row(
                  mainAxisSize:
                  MainAxisSize
                      .max,
                  children: [
                    Column(
                      mainAxisSize:
                      MainAxisSize
                          .max,
                      crossAxisAlignment:
                      CrossAxisAlignment
                          .start,
                      children: [
                        AutoSizeText(
                          widget.type,
                          style: FlutterFlowTheme.of(context)
                              .titleMedium
                              .override(
                            fontFamily: FlutterFlowTheme.of(context).titleMediumFamily,
                            color: FlutterFlowTheme.of(context).primaryText,
                            letterSpacing: 0,
                            useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).titleMediumFamily),
                          ),
                          textDirection: ui.TextDirection.rtl,
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
                              widget.title,
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
                  child: Text(
                    widget.title,
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
                                          'Delete Article',
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
                                                await supabase.from('blogs').delete().eq('id', widget.id);
                                                loading = false;
                                                widget.model.updatePage(() {
                                                  widget.model.articles.removeWhere((element) => element.id == widget.id);
                                                });
                                                Navigator.pop(context);
                                              }

                                            },
                                            text: 'Delete Article',
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
                                          'Are you sure you want to delete this ${widget.title} article?',
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
                              Navigator.push(context, MaterialPageRoute(builder: (context) => WriteArticle(id: widget.id,model: widget.model,),));
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
