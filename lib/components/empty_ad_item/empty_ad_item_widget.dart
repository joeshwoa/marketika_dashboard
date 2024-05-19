import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutterflow_ui_pro/flutterflow_ui_pro.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:marketika_dashboard/main.dart';
import 'package:marketika_dashboard/screens/ads_page/ads_page_model.dart';
import 'package:shimmer/shimmer.dart';

class EmptyAdItemWidget extends StatelessWidget {
  const EmptyAdItemWidget({super.key});

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
                        Shimmer(
                          gradient: LinearGradient(
                            begin: Alignment(-1.0, 0.0),
                            end: Alignment(1.0, 0.0),
                            colors: [
                              Color(0xFFE0E0E0),
                              Color(0xFFE0E0E0),
                              Color(0xFFF5F5F5),
                            ],

                          ),
                          child: AutoSizeText(
                            'Title',
                            style: FlutterFlowTheme.of(context)
                                .titleMedium
                                .override(
                              fontFamily: FlutterFlowTheme.of(context).titleMediumFamily,
                              letterSpacing: 0,
                              useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).titleMediumFamily),
                            ),
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
                            Shimmer(
                              gradient: LinearGradient(
                                begin: Alignment(-1.0, 0.0),
                                end: Alignment(1.0, 0.0),
                                colors: [
                                  Color(0xFFE0E0E0),
                                  Color(0xFFE0E0E0),
                                  Color(0xFFF5F5F5),
                                ],

                              ),
                              child: Text(
                                'Sub Title',
                                style: FlutterFlowTheme.of(context).bodySmall.override(
                                  fontFamily: FlutterFlowTheme.of(context).bodySmallFamily,
                                  letterSpacing: 0,
                                  useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).bodySmallFamily),
                                ),
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
                  child: Shimmer(
                    gradient: LinearGradient(
                      begin: Alignment(-1.0, 0.0),
                      end: Alignment(1.0, 0.0),
                      colors: [
                        Color(0xFFE0E0E0),
                        Color(0xFFE0E0E0),
                        Color(0xFFF5F5F5),
                      ],

                    ),
                    child: Text(
                      'Sub Title',
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
                tablet: false,
              ))
                Expanded(
                  child: Shimmer(
                    gradient: LinearGradient(
                      begin: Alignment(-1.0, 0.0),
                      end: Alignment(1.0, 0.0),
                      colors: [
                        Color(0xFFE0E0E0),
                        Color(0xFFE0E0E0),
                        Color(0xFFF5F5F5),
                      ],

                    ),
                    child: Text(
                      dateTimeFormat(
                          'relative',
                          getCurrentTimestamp),
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
                      Shimmer(
                        gradient: LinearGradient(
                          begin: Alignment(-1.0, 0.0),
                          end: Alignment(1.0, 0.0),
                          colors: [
                            Color(0xFFE0E0E0),
                            Color(0xFFE0E0E0),
                            Color(0xFFF5F5F5),
                          ],

                        ),
                        child: Container(
                          width:
                          300,
                          height:
                          200,
                          color: Colors.grey,
                        ),
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
                          Shimmer(
                            gradient: LinearGradient(
                              begin: Alignment(-1.0, 0.0),
                              end: Alignment(1.0, 0.0),
                              colors: [
                                Color(0xFFE0E0E0),
                                Color(0xFFE0E0E0),
                                Color(0xFFF5F5F5),
                              ],

                            ),
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).primaryBackground,
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding:
                          EdgeInsets.all(5),
                          child:
                          Shimmer(
                            gradient: LinearGradient(
                              begin: Alignment(-1.0, 0.0),
                              end: Alignment(1.0, 0.0),
                              colors: [
                                Color(0xFFE0E0E0),
                                Color(0xFFE0E0E0),
                                Color(0xFFF5F5F5),
                              ],

                            ),
                            child: Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: FlutterFlowTheme.of(context).primaryBackground,
                                borderRadius: BorderRadius.circular(5),
                              ),
                            ),
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
                        Shimmer(
                          gradient: LinearGradient(
                            begin: Alignment(-1.0, 0.0),
                            end: Alignment(1.0, 0.0),
                            colors: [
                              Color(0xFFE0E0E0),
                              Color(0xFFE0E0E0),
                              Color(0xFFF5F5F5),
                            ],

                          ),
                          child: Text(
                            dateTimeFormat(
                                'relative',
                                getCurrentTimestamp),
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
