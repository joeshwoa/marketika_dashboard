import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:flutterflow_ui_pro/flutterflow_ui_pro.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:marketika_dashboard/components/article_item/article_item_widget.dart';
import 'package:marketika_dashboard/main.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:marketika_dashboard/screens/articles_page/articles_page_model.dart';

import 'write_article_model.dart';
export 'write_article_model.dart';

class WriteArticle extends StatefulWidget {
  const WriteArticle({
    super.key,
    this.id = -1,
    required this.model
  });

  final int id;
  final ArticlesPageModel model;

  @override
  State<WriteArticle> createState() => _WriteArticleState();
}

class _WriteArticleState extends State<WriteArticle>
    with TickerProviderStateMixin {
  late WriteArticleModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  final animationsMap = {
    'rowOnPageLoadAnimation': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        VisibilityEffect(duration: 1.ms),
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: 0,
          end: 1,
        ),
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: const Offset(0, -70),
          end: const Offset(0, 0),
        ),
      ],
    ),
    'columnOnPageLoadAnimation1': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        VisibilityEffect(duration: 1.ms),
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: 0,
          end: 1,
        ),
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: const Offset(0, 50),
          end: const Offset(0, 0),
        ),
      ],
    ),
    'columnOnPageLoadAnimation2': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        VisibilityEffect(duration: 1.ms),
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: 0,
          end: 1,
        ),
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 0.ms,
          duration: 600.ms,
          begin: const Offset(0, 50),
          end: const Offset(0, 0),
        ),
      ],
    ),
    'containerOnPageLoadAnimation1': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        VisibilityEffect(duration: 175.ms),
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 175.ms,
          duration: 600.ms,
          begin: 0,
          end: 1,
        ),
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 175.ms,
          duration: 600.ms,
          begin: const Offset(0, 20),
          end: const Offset(0, 0),
        ),
      ],
    ),
    'containerOnPageLoadAnimation2': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        VisibilityEffect(duration: 175.ms),
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 175.ms,
          duration: 600.ms,
          begin: 0,
          end: 1,
        ),
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 175.ms,
          duration: 600.ms,
          begin: const Offset(0, 20),
          end: const Offset(0, 0),
        ),
      ],
    ),
    'containerOnPageLoadAnimation3': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        VisibilityEffect(duration: 175.ms),
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 175.ms,
          duration: 600.ms,
          begin: 0,
          end: 1,
        ),
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 175.ms,
          duration: 600.ms,
          begin: const Offset(0, 20),
          end: const Offset(0, 0),
        ),
      ],
    ),
    'containerOnPageLoadAnimation4': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        VisibilityEffect(duration: 175.ms),
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 175.ms,
          duration: 600.ms,
          begin: 0,
          end: 1,
        ),
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 175.ms,
          duration: 600.ms,
          begin: const Offset(0, 20),
          end: const Offset(0, 0),
        ),
      ],
    ),
    'containerOnPageLoadAnimation5': AnimationInfo(
      trigger: AnimationTrigger.onPageLoad,
      effects: [
        VisibilityEffect(duration: 250.ms),
        FadeEffect(
          curve: Curves.easeInOut,
          delay: 250.ms,
          duration: 600.ms,
          begin: 0,
          end: 1,
        ),
        MoveEffect(
          curve: Curves.easeInOut,
          delay: 250.ms,
          duration: 600.ms,
          begin: const Offset(0, 50),
          end: const Offset(0, 0),
        ),
      ],
    ),
  };

  QuillController _controller = QuillController.basic();

  int stars = 0;
  int reviews = 0;
  int views = 0;
  List<String> reviews_text = [];
  List<String> types = <String>['tips', 'talk', 'tools', 'personal', 'case', 'social'];
  var typeController = TextEditingController(text: 'tips');

  bool isLoading = false;
  bool isSubmitting = false;

  Future<void> _insert() async {
    setState(() {
      isSubmitting = true;
    });

    await supabase
        .from('blogs')
        .insert({
      'title': _model.titleController.text,
      'description': _model.descriptionController.text,
      'imageUrl': _model.imageController.text,
      'author_imageUrl': _model.authorImageController.text,
      'author_name': _model.authorNameController.text,
      'author_location': _model.authorLocationController.text,
      'videoUrl': _model.videoController.text,
      'content': jsonEncode(_controller.document.toDelta().toJson()),
      'type': typeController.text,
      'author_meta': _model.authorMetaController.text,
      'description_meta': _model.descriptionMetaController.text,
      'keywords_meta': _model.keywordsMetaController.text,
      'ogTitle_meta': _model.ogTitleMetaController.text,
      'ogDescription_meta': _model.descriptionMetaController.text,
      'ogImage_meta': _model.imageController.text
    });
    final data = await supabase.from('blogs').select('id, created_at').order('created_at').limit(1);

    widget.model.articles.insert(0, ArticleItemWidget(
      id: data[0]['id'] as int,
      image: _model.imageController.text,
      title: _model.titleController.text,
      created: DateTime.parse(data[0]['created_at'] as String),
      type: typeController.text,
      model: widget.model,
    ));
    setState(() {
      widget.model.updatePage(() {
        if(widget.model.articles.length > 10) {
          widget.model.articles.removeLast();
          widget.model.numberOfPages += 1;
        }
      });
      isSubmitting = false;
      Navigator.pop(context);
    });

    final subscribers = await supabase.from('subscribers').select('name, email');
    List<String> names = [];
    List<String> emails = [];

    for (int i=0; i<subscribers.length; i++) {
        names.add(subscribers[i]['name']);
        emails.add(subscribers[i]['email']);
    }


    await supabase.functions.invoke('send-emails',body: {'names': names, 'emails': emails});
  }
  Future<void> _update() async {
    setState(() {
      isSubmitting = true;
    });

    await supabase
        .from('blogs')
        .update({
      'title': _model.titleController.text,
      'description': _model.descriptionController.text,
      'imageUrl': _model.imageController.text,
      'author_imageUrl': _model.authorImageController.text,
      'author_name': _model.authorNameController.text,
      'author_location': _model.authorLocationController.text,
      'videoUrl': _model.videoController.text,
      'content': jsonEncode(_controller.document.toDelta().toJson()),
      'type': typeController.text,
      'author_meta': _model.authorMetaController.text,
      'description_meta': _model.descriptionMetaController.text,
      'keywords_meta': _model.keywordsMetaController.text,
      'ogTitle_meta': _model.ogTitleMetaController.text,
      'ogDescription_meta': _model.descriptionMetaController.text,
      'ogImage_meta': _model.imageController.text
    }).
    eq('id', widget.id);

    setState(() {
      isSubmitting = false;

      widget.model.updatePage(() {
        int index = widget.model.articles.indexWhere((element) => element.id == widget.id);
        widget.model.articles[index] = ArticleItemWidget(id: widget.id, image: _model.imageController.text, title: _model.titleController.text, created: widget.model.articles[index].created, type: typeController.text, model: widget.model);
      });
    });
    Navigator.pop(context);
  }

  String getThumbnailUrl(String youtubeUrl) {
    // Regular expression to extract the video ID from the YouTube URL
    final RegExp regExp = RegExp(
      r'(?<=v=|v\/|vi=|vi\/|youtu\.be\/|\/v\/|\/vi\/|\/embed\/|watch\?v=|watch\?vi=|watch\?vi\/|\/shorts\/|watch\?.*&v=|&v=)([^#&?\/\s]{11})',
      caseSensitive: false,
      multiLine: false,
    );

    // Match the regular expression with the YouTube URL
    final Match? match = regExp.firstMatch(youtubeUrl);

    // Check if a match is found
    if (match != null && match.groupCount > 0) {
      final String videoId = match.group(0)!;
      // Construct the thumbnail URL
      final String thumbnailUrl = 'https://img.youtube.com/vi/$videoId/hqdefault.jpg';
      return thumbnailUrl;
    } else {
      // Handle cases where the URL does not contain a valid YouTube video ID
      throw FormatException('Invalid YouTube URL');
    }
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => WriteArticleModel());

    _model.titleController ??= TextEditingController();
    _model.titleFieldFocusNode ??= FocusNode();
    _model.descriptionController ??= TextEditingController();
    _model.descriptionFieldFocusNode ??= FocusNode();
    _model.imageController ??= TextEditingController();
    _model.imageFieldFocusNode ??= FocusNode();
    _model.authorImageController ??= TextEditingController();
    _model.authorImageFieldFocusNode ??= FocusNode();
    _model.authorNameController ??= TextEditingController();
    _model.authorNameFieldFocusNode ??= FocusNode();
    _model.authorLocationController ??= TextEditingController();
    _model.authorLocationFieldFocusNode ??= FocusNode();
    _model.videoController ??= TextEditingController();
    _model.videoFieldFocusNode ??= FocusNode();
    _model.authorMetaController ??= TextEditingController();
    _model.authorMetaFieldFocusNode ??= FocusNode();
    _model.descriptionMetaController ??= TextEditingController();
    _model.descriptionMetaFieldFocusNode ??= FocusNode();
    _model.keywordsMetaController ??= TextEditingController();
    _model.keywordsMetaFieldFocusNode ??= FocusNode();
    _model.ogTitleMetaController ??= TextEditingController();
    _model.ogTitleMetaFieldFocusNode ??= FocusNode();

    if(widget.id != -1) {
      setState(() {
        isLoading = true;
      });

      // On page load action.
      SchedulerBinding.instance.addPostFrameCallback((_) async {
        final data = await supabase.from('blogs').select().eq('id', widget.id);
        setState(() {
          _model.imageController = TextEditingController(text: data[0]['imageUrl']);
          _model.titleController = TextEditingController(text: data[0]['title']);
          _model.descriptionController = TextEditingController(text: data[0]['description']);
          stars = data[0]['stars'];
          reviews = data[0]['reviews'];
          views = data[0]['views'];
          reviews_text =
              (data[0]['reviews_text'] as List<dynamic>).cast<String>();
          _model.videoController = TextEditingController(text: data[0]['videoUrl']);
          _controller.document = Document.fromJson(jsonDecode(data[0]['content']));
          _model.authorImageController = TextEditingController(text: data[0]['author_imageUrl']);
          _model.authorNameController = TextEditingController(text: data[0]['author_name']);
          _model.authorLocationController = TextEditingController(text: data[0]['author_location']);
          typeController = TextEditingController(text: data[0]['type']);
          _model.authorMetaController = TextEditingController(text: data[0]['author_meta']);
          _model.descriptionMetaController = TextEditingController(text: data[0]['description_meta']);
          _model.keywordsMetaController = TextEditingController(text: data[0]['keywords_meta']);
          _model.ogTitleMetaController = TextEditingController(text: data[0]['ogTitle_meta']);

          isLoading = false;
        });
      });
    }



    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
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
        body: SafeArea(
          top: true,
          child: isLoading? 
          const Center(child: CircularProgressIndicator()) :
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Align(
                        alignment: const AlignmentDirectional(0, 0),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.fromSTEB(4, 0, 4, 0),
                          child: Container(
                            width: double.infinity,
                            constraints: const BoxConstraints(
                              maxWidth: 1170,
                            ),
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .primaryBackground,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: FlutterFlowTheme.of(context)
                                    .primaryBackground,
                                width: 2,
                              ),
                            ),
                            child: SizedBox(
                              width: double.infinity,
                              child: Stack(
                                children: [
                                  SingleChildScrollView(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Padding(
                                          padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              4, 12, 0, 12),
                                          child: Container(
                                            width: double.infinity,
                                            height: 44,
                                            decoration: BoxDecoration(
                                              color:
                                              FlutterFlowTheme.of(context)
                                                  .primaryBackground,
                                            ),
                                            child: SingleChildScrollView(
                                              scrollDirection:
                                              Axis.horizontal,
                                              child: Row(
                                                mainAxisSize:
                                                MainAxisSize.max,
                                                children: [
                                                  Padding(
                                                    padding:
                                                    EdgeInsets.all(0),
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
                                                        Icons.arrow_back_ios_rounded,
                                                        color:
                                                        FlutterFlowTheme.of(context).primaryText,
                                                        size:
                                                        24,
                                                      ),
                                                      onPressed:
                                                          () {
                                                        Navigator.pop(context);
                                                      },
                                                    ),
                                                  ),
                                                  if(widget.id != -1)Padding(
                                                    padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(
                                                        12, 0, 12, 0),
                                                    child: Icon(
                                                      Icons
                                                          .chevron_right_rounded,
                                                      color:
                                                      FlutterFlowTheme.of(
                                                          context)
                                                          .secondaryText,
                                                      size: 16,
                                                    ),
                                                  ),
                                                  if(widget.id != -1)Padding(
                                                    padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(
                                                        0, 0, 16, 0),
                                                    child: Container(
                                                      height: 32,
                                                      decoration:
                                                      BoxDecoration(
                                                        color: FlutterFlowTheme
                                                            .of(context)
                                                            .accent1,
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(12),
                                                        border: Border.all(
                                                          color: FlutterFlowTheme
                                                              .of(context)
                                                              .primary,
                                                          width: 2,
                                                        ),
                                                      ),
                                                      alignment:
                                                      const AlignmentDirectional(
                                                          0, 0),
                                                      child: Padding(
                                                        padding:
                                                        const EdgeInsetsDirectional
                                                            .fromSTEB(16,
                                                            0, 16, 0),
                                                        child: Column(
                                                          children: [
                                                            AutoSizeText(
                                                              _model.titleController.text,
                                                              style: FlutterFlowTheme
                                                                  .of(context)
                                                                  .bodyMedium
                                                                  .override(
                                                                fontFamily: FlutterFlowTheme.of(
                                                                    context)
                                                                    .bodyMediumFamily,
                                                                letterSpacing:
                                                                0,
                                                                useGoogleFonts: GoogleFonts
                                                                    .asMap()
                                                                    .containsKey(
                                                                    FlutterFlowTheme.of(context)
                                                                        .bodyMediumFamily),
                                                              ),
                                                              minFontSize: 8,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ).animateOnPageLoad(animationsMap[
                                            'rowOnPageLoadAnimation']!),
                                          ),
                                        ),
                                        Padding(
                                          padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              4, 0, 4, 70),
                                          child: Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              color:
                                              FlutterFlowTheme.of(context)
                                                  .secondaryBackground,
                                              boxShadow: const [
                                                BoxShadow(
                                                  blurRadius: 2,
                                                  color: Color(0x520E151B),
                                                  offset: Offset(
                                                    0.0,
                                                    1,
                                                  ),
                                                )
                                              ],
                                              borderRadius:
                                              BorderRadius.circular(12),
                                            ),
                                            child: SingleChildScrollView(
                                              child: Column(
                                                mainAxisSize:
                                                MainAxisSize.max,
                                                children: [
                                                  Padding(
                                                    padding:
                                                    const EdgeInsets.all(16),
                                                    child: Column(
                                                      mainAxisSize:
                                                      MainAxisSize.max,
                                                      crossAxisAlignment:
                                                      CrossAxisAlignment
                                                          .start,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                          const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                              0,
                                                              0,
                                                              0,
                                                              16),
                                                          child: Row(
                                                            mainAxisSize:
                                                            MainAxisSize
                                                                .max,
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                            children: [
                                                              Expanded(
                                                                child: ClipRRect(
                                                                  borderRadius:
                                                                  BorderRadius.circular(
                                                                      10),
                                                                  child:
                                                                  CachedNetworkImage(
                                                                    fadeInDuration:
                                                                    const Duration(milliseconds: 500),
                                                                    fadeOutDuration:
                                                                    const Duration(milliseconds: 500),
                                                                    imageUrl:
                                                                    _model.imageController!.text,
                                                                    width:
                                                                    400,
                                                                    height:
                                                                    400,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                    errorWidget: (context, url, error) => Center(child: Icon(Icons.broken_image_rounded, size: 50, color: FlutterFlowTheme.of(context).primaryText,),),
                                                                  ),
                                                                ),
                                                              ),
                                                              if (responsiveVisibility(
                                                                context:
                                                                context,
                                                                phone: false,
                                                                tablet: false,
                                                              ))
                                                                Expanded(
                                                                  child:
                                                                  Padding(
                                                                    padding: const EdgeInsetsDirectional
                                                                        .fromSTEB(
                                                                        24,
                                                                        12,
                                                                        0,
                                                                        0),
                                                                    child:
                                                                    Column(
                                                                      mainAxisSize:
                                                                      MainAxisSize.max,
                                                                      crossAxisAlignment:
                                                                      CrossAxisAlignment.start,
                                                                      children: [
                                                                        Padding(
                                                                          padding: const EdgeInsetsDirectional
                                                                              .fromSTEB(
                                                                              8,
                                                                              0,
                                                                              8,
                                                                              8),
                                                                          child: DropdownMenu<String>(
                                                                            initialSelection: types.first,
                                                                            enableSearch: true,
                                                                            label: Text('Article Type'),
                                                                            inputDecorationTheme: InputDecorationTheme(
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
                                                                            onSelected: (String? value) {
                                                                              setState(() {
                                                                                typeController.text = value!;
                                                                              });
                                                                            },
                                                                            dropdownMenuEntries: types.map<DropdownMenuEntry<String>>((String value) {
                                                                              return DropdownMenuEntry<String>(value: value, label: value);
                                                                            }).toList(),
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding: const EdgeInsetsDirectional
                                                                              .fromSTEB(
                                                                              8,
                                                                              0,
                                                                              8,
                                                                              0),
                                                                          child:
                                                                          TextFormField(
                                                                            controller:
                                                                            _model
                                                                                .titleController,
                                                                            focusNode:
                                                                            _model
                                                                                .titleFieldFocusNode,
                                                                            autofocus:
                                                                            false,
                                                                            obscureText:
                                                                            false,
                                                                            decoration:
                                                                            InputDecoration(
                                                                              labelText:
                                                                              'Article Title',
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
                                                                            validator: _model
                                                                                .titleControllerValidator
                                                                                .asValidator(
                                                                                context),
                                                                          ),
                                                                        ),
                                                                        if(widget.id != -1)Padding(
                                                                          padding: const EdgeInsetsDirectional.fromSTEB(
                                                                              8,
                                                                              4,
                                                                              8,
                                                                              4),
                                                                          child:
                                                                          Text(
                                                                            '$stars stars',
                                                                            style: FlutterFlowTheme.of(context).titleLarge.override(
                                                                              fontFamily: FlutterFlowTheme.of(context).titleLargeFamily,
                                                                              color: FlutterFlowTheme.of(context).primary,
                                                                              letterSpacing: 0,
                                                                              useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).titleLargeFamily),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        if(widget.id != -1)Padding(
                                                                          padding: const EdgeInsetsDirectional.fromSTEB(
                                                                              8,
                                                                              4,
                                                                              8,
                                                                              4),
                                                                          child:
                                                                          Text(
                                                                            '$reviews reviews',
                                                                            style: FlutterFlowTheme.of(context).labelLarge.override(
                                                                              fontFamily: FlutterFlowTheme.of(context).labelLargeFamily,
                                                                              letterSpacing: 0,
                                                                              useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).labelLargeFamily),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        if(widget.id != -1)Padding(
                                                                          padding: const EdgeInsetsDirectional.fromSTEB(
                                                                              8,
                                                                              4,
                                                                              8,
                                                                              0),
                                                                          child:
                                                                          Text(
                                                                            '$views views',
                                                                            style: FlutterFlowTheme.of(context).labelLarge.override(
                                                                              fontFamily: FlutterFlowTheme.of(context).labelLargeFamily,
                                                                              letterSpacing: 0,
                                                                              useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).labelLargeFamily),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                        Divider(
                                                                          height:
                                                                          36,
                                                                          thickness:
                                                                          1,
                                                                          color:
                                                                          FlutterFlowTheme.of(context).alternate,
                                                                        ),
                                                                        Padding(
                                                                          padding: const EdgeInsetsDirectional
                                                                              .fromSTEB(
                                                                              8,
                                                                              0,
                                                                              8,
                                                                              8),
                                                                          child:
                                                                          TextFormField(
                                                                            controller:
                                                                            _model
                                                                                .descriptionController,
                                                                            focusNode:
                                                                            _model
                                                                                .descriptionFieldFocusNode,
                                                                            autofocus:
                                                                            false,
                                                                            obscureText:
                                                                            false,
                                                                            decoration:
                                                                            InputDecoration(
                                                                              labelText:
                                                                              'Article Description',
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
                                                                            validator: _model
                                                                                .descriptionControllerValidator
                                                                                .asValidator(
                                                                                context),
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding: const EdgeInsetsDirectional
                                                                              .fromSTEB(
                                                                              8,
                                                                              0,
                                                                              8,
                                                                              8),
                                                                          child:
                                                                          TextFormField(
                                                                            controller:
                                                                            _model
                                                                                .imageController,
                                                                            focusNode:
                                                                            _model
                                                                                .imageFieldFocusNode,
                                                                            autofocus:
                                                                            false,
                                                                            obscureText:
                                                                            false,
                                                                            decoration:
                                                                            InputDecoration(
                                                                              labelText:
                                                                              'Article Image',
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
                                                                            validator: _model
                                                                                .imageControllerValidator
                                                                                .asValidator(
                                                                                context),
                                                                            onChanged: (value) {
                                                                                  setState(() {
                                                                                    _model.imageController?.text = value;
                                                                                  });
                                                                                },
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ).animateOnPageLoad(
                                                                        animationsMap['columnOnPageLoadAnimation1']!),
                                                                  ),
                                                                ),
                                                            ],
                                                          ),
                                                        ),
                                                        if (responsiveVisibility(
                                                          context: context,
                                                          tabletLandscape:
                                                          false,
                                                          desktop: false,
                                                        ))
                                                          Padding(
                                                            padding:
                                                            const EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                0,
                                                                0,
                                                                0,
                                                                12),
                                                            child: Column(
                                                              mainAxisSize:
                                                              MainAxisSize
                                                                  .max,
                                                              crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                              children: [
                                                                Padding(
                                                                  padding: const EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                      8,
                                                                      0,
                                                                      8,
                                                                      8),
                                                                  child: DropdownMenu<String>(
                                                                    initialSelection: types.first,
                                                                    enableSearch: true,
                                                                    label: Text('Article Type'),
                                                                    inputDecorationTheme: InputDecorationTheme(
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
                                                                    onSelected: (String? value) {
                                                                      setState(() {
                                                                        typeController.text = value!;
                                                                      });
                                                                    },
                                                                    dropdownMenuEntries: types.map<DropdownMenuEntry<String>>((String value) {
                                                                      return DropdownMenuEntry<String>(value: value, label: value);
                                                                    }).toList(),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                      8,
                                                                      0,
                                                                      8,
                                                                      0),
                                                                  child:
                                                                  TextFormField(
                                                                    controller:
                                                                    _model
                                                                        .titleController,
                                                                    focusNode:
                                                                    _model
                                                                        .titleFieldFocusNode,
                                                                    autofocus:
                                                                    false,
                                                                    obscureText:
                                                                    false,
                                                                    decoration:
                                                                    InputDecoration(
                                                                      labelText:
                                                                      'Article Title',
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
                                                                    validator: _model
                                                                        .titleControllerValidator
                                                                        .asValidator(
                                                                        context),
                                                                  ),
                                                                ),
                                                                if(widget.id != -1)Padding(
                                                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                                                      8,
                                                                      4,
                                                                      8,
                                                                      4),
                                                                  child:
                                                                  Text(
                                                                    '$stars stars',
                                                                    style: FlutterFlowTheme.of(context).titleLarge.override(
                                                                      fontFamily: FlutterFlowTheme.of(context).titleLargeFamily,
                                                                      color: FlutterFlowTheme.of(context).primary,
                                                                      letterSpacing: 0,
                                                                      useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).titleLargeFamily),
                                                                    ),
                                                                  ),
                                                                ),
                                                                if(widget.id != -1)Padding(
                                                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                                                      8,
                                                                      4,
                                                                      8,
                                                                      4),
                                                                  child:
                                                                  Text(
                                                                    '$reviews reviews',
                                                                    style: FlutterFlowTheme.of(context).labelLarge.override(
                                                                      fontFamily: FlutterFlowTheme.of(context).labelLargeFamily,
                                                                      letterSpacing: 0,
                                                                      useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).labelLargeFamily),
                                                                    ),
                                                                  ),
                                                                ),
                                                                if(widget.id != -1)Padding(
                                                                  padding: const EdgeInsetsDirectional.fromSTEB(
                                                                      8,
                                                                      4,
                                                                      8,
                                                                      0),
                                                                  child:
                                                                  Text(
                                                                    '$views views',
                                                                    style: FlutterFlowTheme.of(context).labelLarge.override(
                                                                      fontFamily: FlutterFlowTheme.of(context).labelLargeFamily,
                                                                      letterSpacing: 0,
                                                                      useGoogleFonts: GoogleFonts.asMap().containsKey(FlutterFlowTheme.of(context).labelLargeFamily),
                                                                    ),
                                                                  ),
                                                                ),
                                                                Divider(
                                                                  height:
                                                                  36,
                                                                  thickness:
                                                                  1,
                                                                  color:
                                                                  FlutterFlowTheme.of(context).alternate,
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                      8,
                                                                      0,
                                                                      8,
                                                                      8),
                                                                  child:
                                                                  TextFormField(
                                                                    controller:
                                                                    _model
                                                                        .descriptionController,
                                                                    focusNode:
                                                                    _model
                                                                        .descriptionFieldFocusNode,
                                                                    autofocus:
                                                                    false,
                                                                    obscureText:
                                                                    false,
                                                                    decoration:
                                                                    InputDecoration(
                                                                      labelText:
                                                                      'Article Description',
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
                                                                    validator: _model
                                                                        .descriptionControllerValidator
                                                                        .asValidator(
                                                                        context),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsetsDirectional
                                                                      .fromSTEB(
                                                                      8,
                                                                      0,
                                                                      8,
                                                                      8),
                                                                  child:
                                                                  TextFormField(
                                                                    controller:
                                                                    _model
                                                                        .imageController,
                                                                    focusNode:
                                                                    _model
                                                                        .imageFieldFocusNode,
                                                                    autofocus:
                                                                    false,
                                                                    obscureText:
                                                                    false,
                                                                    decoration:
                                                                    InputDecoration(
                                                                      labelText:
                                                                      'Article Image',
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
                                                                    validator: _model
                                                                        .imageControllerValidator
                                                                        .asValidator(
                                                                        context),
                                                                    onChanged: (value) {
                                                                      setState(() {
                                                                        _model.imageController?.text = value;
                                                                      });
                                                                    },
                                                                  ),
                                                                ),
                                                              ],
                                                            ).animateOnPageLoad(
                                                                animationsMap[
                                                                'columnOnPageLoadAnimation2']!),
                                                          ),
                                                        Text(
                                                          'Meta Data',
                                                          style: FlutterFlowTheme.of(context)
                                                              .titleLarge
                                                              .override(
                                                            fontFamily:
                                                            FlutterFlowTheme.of(
                                                                context)
                                                                .titleLargeFamily,
                                                            letterSpacing: 0,
                                                            useGoogleFonts: GoogleFonts
                                                                .asMap()
                                                                .containsKey(
                                                                FlutterFlowTheme.of(
                                                                    context)
                                                                    .titleLargeFamily),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                          const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                              0,
                                                              8,
                                                              0,
                                                              16),
                                                          child: Container(
                                                            width: double
                                                                .infinity,
                                                            decoration:
                                                            BoxDecoration(
                                                              color: FlutterFlowTheme.of(
                                                                  context)
                                                                  .primaryBackground,
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  blurRadius:
                                                                  0,
                                                                  color: FlutterFlowTheme.of(
                                                                      context)
                                                                      .primaryBackground,
                                                                  offset:
                                                                  const Offset(
                                                                    0.0,
                                                                    1,
                                                                  ),
                                                                )
                                                              ],
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                  8),
                                                              border: Border
                                                                  .all(
                                                                color: FlutterFlowTheme.of(
                                                                    context)
                                                                    .alternate,
                                                                width: 2,
                                                              ),
                                                            ),
                                                            child: Padding(
                                                              padding: const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                  8,
                                                                  8,
                                                                  12,
                                                                  8),
                                                              child: Row(
                                                                mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                                crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                                children: [
                                                                  Expanded(
                                                                    child:
                                                                    Column(
                                                                      mainAxisSize:
                                                                      MainAxisSize.max,
                                                                      crossAxisAlignment:
                                                                      CrossAxisAlignment.start,
                                                                      children: [
                                                                        Padding(
                                                                          padding: const EdgeInsetsDirectional
                                                                              .fromSTEB(
                                                                              8,
                                                                              0,
                                                                              8,
                                                                              8),
                                                                          child:
                                                                          TextFormField(
                                                                            controller:
                                                                            _model
                                                                                .authorMetaController,
                                                                            focusNode:
                                                                            _model
                                                                                .authorMetaFieldFocusNode,
                                                                            autofocus:
                                                                            false,
                                                                            obscureText:
                                                                            false,
                                                                            decoration:
                                                                            InputDecoration(
                                                                              labelText:
                                                                              'Author Meta',
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
                                                                            validator: _model
                                                                                .authorMetaControllerValidator
                                                                                .asValidator(
                                                                                context),
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding: const EdgeInsetsDirectional
                                                                              .fromSTEB(
                                                                              8,
                                                                              0,
                                                                              8,
                                                                              8),
                                                                          child:
                                                                          TextFormField(
                                                                            controller:
                                                                            _model
                                                                                .descriptionMetaController,
                                                                            focusNode:
                                                                            _model
                                                                                .descriptionMetaFieldFocusNode,
                                                                            autofocus:
                                                                            false,
                                                                            obscureText:
                                                                            false,
                                                                            decoration:
                                                                            InputDecoration(
                                                                              labelText:
                                                                              'Description Meta',
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
                                                                            validator: _model
                                                                                .descriptionMetaControllerValidator
                                                                                .asValidator(
                                                                                context),
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding: const EdgeInsetsDirectional
                                                                              .fromSTEB(
                                                                              8,
                                                                              0,
                                                                              8,
                                                                              8),
                                                                          child:
                                                                          TextFormField(
                                                                            controller:
                                                                            _model
                                                                                .keywordsMetaController,
                                                                            focusNode:
                                                                            _model
                                                                                .keywordsMetaFieldFocusNode,
                                                                            autofocus:
                                                                            false,
                                                                            obscureText:
                                                                            false,
                                                                            decoration:
                                                                            InputDecoration(
                                                                              labelText:
                                                                              'Keywords Meta',
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
                                                                            validator: _model
                                                                                .keywordsMetaControllerValidator
                                                                                .asValidator(
                                                                                context),
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding: const EdgeInsetsDirectional
                                                                              .fromSTEB(
                                                                              8,
                                                                              0,
                                                                              8,
                                                                              0),
                                                                          child:
                                                                          TextFormField(
                                                                            controller:
                                                                            _model
                                                                                .ogTitleMetaController,
                                                                            focusNode:
                                                                            _model
                                                                                .ogTitleMetaFieldFocusNode,
                                                                            autofocus:
                                                                            false,
                                                                            obscureText:
                                                                            false,
                                                                            decoration:
                                                                            InputDecoration(
                                                                              labelText:
                                                                              'Title Meta',
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
                                                                            validator: _model
                                                                                .ogTitleMetaControllerValidator
                                                                                .asValidator(
                                                                                context),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ).animateOnPageLoad(
                                                              animationsMap[
                                                              'containerOnPageLoadAnimation1']!),
                                                        ),
                                                        Text(
                                                          'Author Data',
                                                          style: FlutterFlowTheme.of(context)
                                                              .titleLarge
                                                              .override(
                                                            fontFamily:
                                                            FlutterFlowTheme.of(
                                                                context)
                                                                .titleLargeFamily,
                                                            letterSpacing: 0,
                                                            useGoogleFonts: GoogleFonts
                                                                .asMap()
                                                                .containsKey(
                                                                FlutterFlowTheme.of(
                                                                    context)
                                                                    .titleLargeFamily),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                          const EdgeInsetsDirectional
                                                              .fromSTEB(
                                                              0,
                                                              8,
                                                              0,
                                                              16),
                                                          child: Container(
                                                            width: double
                                                                .infinity,
                                                            decoration:
                                                            BoxDecoration(
                                                              color: FlutterFlowTheme.of(
                                                                  context)
                                                                  .primaryBackground,
                                                              boxShadow: [
                                                                BoxShadow(
                                                                  blurRadius:
                                                                  0,
                                                                  color: FlutterFlowTheme.of(
                                                                      context)
                                                                      .primaryBackground,
                                                                  offset:
                                                                  const Offset(
                                                                    0.0,
                                                                    1,
                                                                  ),
                                                                )
                                                              ],
                                                              borderRadius:
                                                              BorderRadius
                                                                  .circular(
                                                                  8),
                                                              border: Border
                                                                  .all(
                                                                color: FlutterFlowTheme.of(
                                                                    context)
                                                                    .alternate,
                                                                width: 2,
                                                              ),
                                                            ),
                                                            child: Padding(
                                                              padding: const EdgeInsetsDirectional
                                                                  .fromSTEB(
                                                                  8,
                                                                  8,
                                                                  12,
                                                                  8),
                                                              child: Row(
                                                                mainAxisSize:
                                                                MainAxisSize
                                                                    .max,
                                                                crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .center,
                                                                children: [
                                                                  ClipRRect(
                                                                    borderRadius:
                                                                    BorderRadius.circular(8),
                                                                    child: CachedNetworkImage(
                                                                      fadeInDuration:
                                                                      const Duration(milliseconds: 500),
                                                                      fadeOutDuration:
                                                                      const Duration(milliseconds: 500),
                                                                      imageUrl: _model.authorImageController!.text,
                                                                      width:
                                                                      70,
                                                                      height:
                                                                      70,
                                                                      fit: BoxFit
                                                                          .cover,
                                                                      errorWidget: (context, url, error) => Center(child: Icon(Icons.broken_image_rounded, size: 40, color: FlutterFlowTheme.of(context).primaryText,),),
                                                                    ),
                                                                  ),
                                                                  Expanded(
                                                                    child:
                                                                    Column(
                                                                      mainAxisSize:
                                                                      MainAxisSize.max,
                                                                      crossAxisAlignment:
                                                                      CrossAxisAlignment.start,
                                                                      children: [
                                                                        Padding(
                                                                          padding: const EdgeInsetsDirectional
                                                                              .fromSTEB(
                                                                              8,
                                                                              0,
                                                                              8,
                                                                              8),
                                                                          child:
                                                                          TextFormField(
                                                                            controller:
                                                                            _model
                                                                                .authorNameController,
                                                                            focusNode:
                                                                            _model
                                                                                .authorNameFieldFocusNode,
                                                                            autofocus:
                                                                            false,
                                                                            obscureText:
                                                                            false,
                                                                            decoration:
                                                                            InputDecoration(
                                                                              labelText:
                                                                              'Author Name',
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
                                                                            validator: _model
                                                                                .authorNameControllerValidator
                                                                                .asValidator(
                                                                                context),
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding: const EdgeInsetsDirectional
                                                                              .fromSTEB(
                                                                              8,
                                                                              0,
                                                                              8,
                                                                              8),
                                                                          child:
                                                                          TextFormField(
                                                                            controller:
                                                                            _model
                                                                                .authorLocationController,
                                                                            focusNode:
                                                                            _model
                                                                                .authorLocationFieldFocusNode,
                                                                            autofocus:
                                                                            false,
                                                                            obscureText:
                                                                            false,
                                                                            decoration:
                                                                            InputDecoration(
                                                                              labelText:
                                                                              'Author Location',
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
                                                                            validator: _model
                                                                                .authorLocationControllerValidator
                                                                                .asValidator(
                                                                                context),
                                                                          ),
                                                                        ),
                                                                        Padding(
                                                                          padding: const EdgeInsetsDirectional
                                                                              .fromSTEB(
                                                                              8,
                                                                              0,
                                                                              8,
                                                                              0),
                                                                          child:
                                                                          TextFormField(
                                                                            controller:
                                                                            _model
                                                                                .authorImageController,
                                                                            focusNode:
                                                                            _model
                                                                                .authorImageFieldFocusNode,
                                                                            autofocus:
                                                                            false,
                                                                            obscureText:
                                                                            false,
                                                                            decoration:
                                                                            InputDecoration(
                                                                              labelText:
                                                                              'Author Image',
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
                                                                            validator: _model
                                                                                .authorImageControllerValidator
                                                                                .asValidator(
                                                                                context),
                                                                            onChanged: (value) {
                                                                              setState(() {
                                                                                _model.authorImageController?.text = value;
                                                                              });
                                                                            },
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ).animateOnPageLoad(
                                                              animationsMap[
                                                              'containerOnPageLoadAnimation1']!),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsetsDirectional
                                                        .fromSTEB(
                                                        8, 0, 8, 0),
                                                    child: Divider(
                                                      height:
                                                      36,
                                                      thickness:
                                                      1,
                                                      color:
                                                      FlutterFlowTheme.of(context).alternate,
                                                    ),
                                                  ),
                                                  QuillToolbar.simple(
                                                    configurations: QuillSimpleToolbarConfigurations(
                                                      controller: _controller,
                                                      showAlignmentButtons: true,
                                                      multiRowsDisplay: true,
                                                      sharedConfigurations: const QuillSharedConfigurations(
                                                        locale: Locale('ar'),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                    const EdgeInsetsDirectional
                                                        .fromSTEB(
                                                        12, 12, 12, 12),
                                                    child: QuillEditor.basic(
                                                      configurations: QuillEditorConfigurations(
                                                        controller: _controller,
                                                        placeholder: 'Write your article here...',
                                                        dialogTheme: QuillDialogTheme(
                                                            shape: OutlineInputBorder(
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
                                                          labelTextStyle: FlutterFlowTheme.of(
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
                                                        ),
                                                        sharedConfigurations: const QuillSharedConfigurations(
                                                          locale: Locale('ar'),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsetsDirectional
                                                        .fromSTEB(
                                                        8, 0, 8, 0),
                                                    child: Divider(
                                                      height:
                                                      36,
                                                      thickness:
                                                      1,
                                                      color:
                                                      FlutterFlowTheme.of(context).alternate,
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsetsDirectional
                                                        .fromSTEB(
                                                        8,
                                                        0,
                                                        8,
                                                        8),
                                                    child:
                                                    TextFormField(
                                                      controller:
                                                      _model
                                                          .videoController,
                                                      focusNode:
                                                      _model
                                                          .videoFieldFocusNode,
                                                      autofocus:
                                                      false,
                                                      obscureText:
                                                      false,
                                                      decoration:
                                                      InputDecoration(
                                                        labelText:
                                                        'Video',
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
                                                      validator: _model
                                                          .videoControllerValidator
                                                          .asValidator(
                                                          context),
                                                      onChanged: (value) {
                                                        setState(() {
                                                          _model.videoController?.text = value;
                                                        });
                                                      },
                                                    ),
                                                  ),
                                                  if (responsiveVisibility(
                                                    context: context,
                                                    phone: false,
                                                  ) && _model.videoController!.text.isNotEmpty)
                                                    Padding(
                                                      padding:
                                                      const EdgeInsetsDirectional
                                                          .fromSTEB(0, 12,
                                                          0, 12),
                                                      child: Container(
                                                        width: 450,
                                                        height: 300,
                                                        decoration:
                                                        BoxDecoration(
                                                          color: FlutterFlowTheme
                                                              .of(context)
                                                              .secondaryBackground,
                                                          borderRadius:
                                                          BorderRadius
                                                              .circular(
                                                              8),
                                                        ),
                                                        child: Align(
                                                          alignment:
                                                          AlignmentDirectional(
                                                              0, 0),
                                                          child:
                                                          CachedNetworkImage(
                                                            fadeInDuration:
                                                            const Duration(milliseconds: 500),
                                                            fadeOutDuration:
                                                            const Duration(milliseconds: 500),
                                                            imageUrl:
                                                            getThumbnailUrl(_model.videoController!.text),
                                                            width:
                                                            450,
                                                            height:
                                                            300,
                                                            fit: BoxFit
                                                                .cover,
                                                            errorWidget: (context, url, error) => Center(child: Icon(Icons.broken_image_rounded, size: 50, color: FlutterFlowTheme.of(context).primaryText,),),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  if (responsiveVisibility(
                                                    context: context,
                                                    tablet: false,
                                                    tabletLandscape: false,
                                                    desktop: false,
                                                  ) && _model.videoController!.text.isNotEmpty)
                                                    Padding(
                                                      padding:
                                                      const EdgeInsetsDirectional
                                                          .fromSTEB(0, 12,
                                                          0, 12),
                                                      child: Container(
                                                        width: 300,
                                                        height: 200,
                                                        decoration:
                                                        BoxDecoration(
                                                          color: FlutterFlowTheme
                                                              .of(context)
                                                              .secondaryBackground,
                                                          borderRadius:
                                                          BorderRadius
                                                              .circular(
                                                              8),
                                                        ),
                                                        child: Align(
                                                          alignment:
                                                          AlignmentDirectional(
                                                              0, 0),
                                                          child:
                                                          FlutterFlowYoutubePlayer(
                                                            url:
                                                            _model.videoController!.text,
                                                            width: 300,
                                                            height: 200,
                                                            autoPlay: false,
                                                            looping: true,
                                                            mute: false,
                                                            showControls:
                                                            true,
                                                            showFullScreen:
                                                            true,
                                                            strictRelatedVideos:
                                                            false,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        if(widget.id != -1)Text(
                                          'All Reviews',
                                          style: FlutterFlowTheme.of(context)
                                              .titleLarge
                                              .override(
                                            fontFamily:
                                            FlutterFlowTheme.of(
                                                context)
                                                .titleLargeFamily,
                                            letterSpacing: 0,
                                            useGoogleFonts: GoogleFonts
                                                .asMap()
                                                .containsKey(
                                                FlutterFlowTheme.of(
                                                    context)
                                                    .titleLargeFamily),
                                          ),
                                        ),
                                        if(widget.id != -1)for(int i=reviews_text.length-1; i>=0; i--)...[
                                          Padding(
                                            padding:
                                            const EdgeInsetsDirectional.fromSTEB(
                                                4, 8, 4, 8),
                                            child: Container(
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                color: FlutterFlowTheme.of(
                                                    context)
                                                    .secondaryBackground,
                                                boxShadow: [
                                                  BoxShadow(
                                                    blurRadius: 0,
                                                    color: FlutterFlowTheme
                                                        .of(context)
                                                        .primaryBackground,
                                                    offset: const Offset(
                                                      0.0,
                                                      1,
                                                    ),
                                                  )
                                                ],
                                                borderRadius:
                                                BorderRadius.circular(8),
                                                border: Border.all(
                                                  color: FlutterFlowTheme.of(
                                                      context)
                                                      .alternate,
                                                  width: 2,
                                                ),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsetsDirectional
                                                    .fromSTEB(8, 8, 12, 8),
                                                child: Row(
                                                  mainAxisSize:
                                                  MainAxisSize.max,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment
                                                      .center,
                                                  children: [
                                                    Container(
                                                      width: 70,
                                                      height: 70,
                                                      decoration:
                                                      BoxDecoration(
                                                        color: FlutterFlowTheme
                                                            .of(context)
                                                            .secondaryBackground,
                                                        boxShadow: const [
                                                          BoxShadow(
                                                            blurRadius: 4,
                                                            color: Color(
                                                                0x33000000),
                                                            offset: Offset(
                                                              0,
                                                              2,
                                                            ),
                                                          )
                                                        ],
                                                        borderRadius:
                                                        BorderRadius
                                                            .circular(8),
                                                        border: Border.all(
                                                          color: FlutterFlowTheme
                                                              .of(context)
                                                              .primary,
                                                          width: 2,
                                                        ),
                                                      ),
                                                      child: Icon(
                                                        Icons.reviews_rounded,
                                                        color: FlutterFlowTheme
                                                            .of(context)
                                                            .secondaryText,
                                                        size: 32,
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                        mainAxisSize:
                                                        MainAxisSize.max,
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                        children: [
                                                          Padding(
                                                            padding:
                                                            const EdgeInsetsDirectional
                                                                .fromSTEB(
                                                                16,
                                                                2,
                                                                0,
                                                                2),
                                                            child: Text(
                                                              reviews_text[i],
                                                              style: FlutterFlowTheme.of(
                                                                  context)
                                                                  .labelMedium
                                                                  .override(
                                                                fontFamily:
                                                                FlutterFlowTheme.of(context)
                                                                    .labelMediumFamily,
                                                                letterSpacing:
                                                                0,
                                                                useGoogleFonts: GoogleFonts
                                                                    .asMap()
                                                                    .containsKey(
                                                                    FlutterFlowTheme.of(context).labelMediumFamily),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: InkWell(
                                                        splashColor: Colors.transparent,
                                                        focusColor: Colors.transparent,
                                                        hoverColor: Colors.transparent,
                                                        highlightColor:
                                                        Colors.transparent,
                                                        onTap: () async {
                                                          setState(() {
                                                            reviews_text.removeAt(i);
                                                          });
                                                        },
                                                        child: Container(
                                                          width: 60,
                                                          height: 60,
                                                          decoration:
                                                          BoxDecoration(
                                                            color: FlutterFlowTheme
                                                                .of(context)
                                                                .secondaryBackground,
                                                            boxShadow: const [
                                                              BoxShadow(
                                                                blurRadius: 4,
                                                                color: Color(
                                                                    0x33000000),
                                                                offset: Offset(
                                                                  0,
                                                                  2,
                                                                ),
                                                              )
                                                            ],
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                            border: Border.all(
                                                              color: FlutterFlowTheme
                                                                  .of(context)
                                                                  .error,
                                                              width: 2,
                                                            ),
                                                          ),
                                                          child: Icon(
                                                            Icons.close_rounded,
                                                            color: FlutterFlowTheme
                                                                .of(context)
                                                                .error,
                                                            size: 32,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ).animateOnPageLoad(animationsMap[
                                            'containerOnPageLoadAnimation2']!),
                                          ),
                                        ],
                                        if(reviews_text.length == 0 && widget.id != -1)Padding(
                                          padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              4, 8, 4, 8),
                                          child: Text(
                                            'No Reviews yet',
                                            style: FlutterFlowTheme.of(context)
                                                .titleMedium
                                                .override(
                                              fontFamily:
                                              FlutterFlowTheme.of(
                                                  context)
                                                  .titleMediumFamily,
                                              letterSpacing: 0,
                                              useGoogleFonts: GoogleFonts
                                                  .asMap()
                                                  .containsKey(
                                                  FlutterFlowTheme.of(
                                                      context)
                                                      .titleMediumFamily),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: 60,),

                                      ],
                                    ),
                                  ),
                                  Align(
                                    alignment: const AlignmentDirectional(1, 1),
                                    child: Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(
                                          0, 0, 12, 32),
                                      child: InkWell(
                                        splashColor: Colors
                                            .transparent,
                                        focusColor: Colors
                                            .transparent,
                                        hoverColor: Colors
                                            .transparent,
                                        highlightColor:
                                        Colors
                                            .transparent,
                                        onTap: () async {
                                          if(!isSubmitting) {
                                            if(widget.id == -1) {
                                              await _insert();
                                            } else {
                                              await _update();
                                            }
                                          }
                                        },
                                        child: Container(
                                          width: 60,
                                          height: 60,
                                          decoration: BoxDecoration(
                                            boxShadow: const [
                                              BoxShadow(
                                                blurRadius: 4,
                                                color: Color(0x33000000),
                                                offset: Offset(
                                                  0,
                                                  2,
                                                ),
                                              )
                                            ],
                                            borderRadius:
                                            BorderRadius.circular(12),
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                            BorderRadius.circular(12),
                                            child: BackdropFilter(
                                              filter: ImageFilter.blur(
                                                sigmaX: 5,
                                                sigmaY: 2,
                                              ),
                                              child: Container(
                                                width: 60,
                                                height: 60,
                                                decoration: BoxDecoration(
                                                  color: FlutterFlowTheme.of(
                                                      context)
                                                      .accent4,
                                                  borderRadius:
                                                  BorderRadius.circular(12),
                                                ),
                                                child: isSubmitting? Center(child: CircularProgressIndicator(),): Icon(
                                                  widget.id != -1? Icons.edit_rounded: Icons.add_rounded,
                                                  color: FlutterFlowTheme.of(
                                                      context)
                                                      .primary,
                                                  size: 32,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ).animateOnPageLoad(animationsMap[
                                        'containerOnPageLoadAnimation5']!),
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
            ],
          ),
        ),
      ),
    );
  }
}
