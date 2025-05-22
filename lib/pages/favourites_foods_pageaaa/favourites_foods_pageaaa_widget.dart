import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_toggle_icon.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'favourites_foods_pageaaa_model.dart';
export 'favourites_foods_pageaaa_model.dart';

class FavouritesFoodsPageaaaWidget extends StatefulWidget {
  const FavouritesFoodsPageaaaWidget({super.key});

  static String routeName = 'FavouritesFoodsPageaaa';
  static String routePath = '/favouritesFoodsPageaaa';

  @override
  State<FavouritesFoodsPageaaaWidget> createState() =>
      _FavouritesFoodsPageaaaWidgetState();
}

class _FavouritesFoodsPageaaaWidgetState
    extends State<FavouritesFoodsPageaaaWidget> {
  late FavouritesFoodsPageaaaModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => FavouritesFoodsPageaaaModel());
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<UsersRecord>>(
      stream: queryUsersRecord(
        singleRecord: true,
      ),
      builder: (context, snapshot) {
        // Customize what your widget looks like when it's loading.
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            body: Center(
              child: SizedBox(
                width: 50.0,
                height: 50.0,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    FlutterFlowTheme.of(context).primary,
                  ),
                ),
              ),
            ),
          );
        }
        List<UsersRecord> favouritesFoodsPageaaaUsersRecordList =
            snapshot.data!;
        // Return an empty Container when the item does not exist.
        if (snapshot.data!.isEmpty) {
          return Container();
        }
        final favouritesFoodsPageaaaUsersRecord =
            favouritesFoodsPageaaaUsersRecordList.isNotEmpty
                ? favouritesFoodsPageaaaUsersRecordList.first
                : null;

        return GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
            appBar: AppBar(
              backgroundColor: Color(0xFF71C0EA),
              automaticallyImplyLeading: false,
              leading: FlutterFlowIconButton(
                borderRadius: 8.0,
                buttonSize: 40.0,
                fillColor: Color(0xFF71C0EA),
                icon: Icon(
                  Icons.arrow_back,
                  color: FlutterFlowTheme.of(context).info,
                  size: 24.0,
                ),
                onPressed: () async {
                  context.safePop();
                },
              ),
              title: Align(
                alignment: AlignmentDirectional(0.0, 0.0),
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 45.0, 0.0),
                  child: Text(
                    'My Favorites Foods',
                    textAlign: TextAlign.center,
                    style: FlutterFlowTheme.of(context).headlineMedium.override(
                          font: GoogleFonts.interTight(
                            fontWeight: FontWeight.w600,
                            fontStyle: FlutterFlowTheme.of(context)
                                .headlineMedium
                                .fontStyle,
                          ),
                          color: FlutterFlowTheme.of(context).info,
                          fontSize: 22.0,
                          letterSpacing: 0.0,
                          fontWeight: FontWeight.w600,
                          fontStyle: FlutterFlowTheme.of(context)
                              .headlineMedium
                              .fontStyle,
                        ),
                  ),
                ),
              ),
              actions: [],
              centerTitle: false,
              elevation: 0.0,
            ),
            body: SafeArea(
              top: true,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(16.0, 0.0, 16.0, 0.0),
                    child: StreamBuilder<List<FoodRecord>>(
                      stream: queryFoodRecord(
                        queryBuilder: (foodRecord) => foodRecord.where(
                          'FavouritesFood',
                          arrayContains:
                              favouritesFoodsPageaaaUsersRecord?.reference,
                        ),
                      ),
                      builder: (context, snapshot) {
                        // Customize what your widget looks like when it's loading.
                        if (!snapshot.hasData) {
                          return Center(
                            child: SizedBox(
                              width: 50.0,
                              height: 50.0,
                              child: CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  FlutterFlowTheme.of(context).primary,
                                ),
                              ),
                            ),
                          );
                        }
                        List<FoodRecord> listViewFoodRecordList =
                            snapshot.data!;

                        return ListView.builder(
                          padding: EdgeInsets.zero,
                          shrinkWrap: true,
                          scrollDirection: Axis.vertical,
                          itemCount: listViewFoodRecordList.length,
                          itemBuilder: (context, listViewIndex) {
                            final listViewFoodRecord =
                                listViewFoodRecordList[listViewIndex];
                            return Column(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                ToggleIcon(
                                  onPressed: () async {
                                    final favouritesFoodElement =
                                        favouritesFoodsPageaaaUsersRecord
                                            ?.reference;
                                    final favouritesFoodUpdate =
                                        listViewFoodRecord.favouritesFood
                                                .contains(favouritesFoodElement)
                                            ? FieldValue.arrayRemove(
                                                [favouritesFoodElement])
                                            : FieldValue.arrayUnion(
                                                [favouritesFoodElement]);
                                    await listViewFoodRecord.reference.update({
                                      ...mapToFirestore(
                                        {
                                          'FavouritesFood':
                                              favouritesFoodUpdate,
                                        },
                                      ),
                                    });
                                    if (listViewFoodRecord.favouritesFood
                                            .contains(
                                                favouritesFoodsPageaaaUsersRecord
                                                    ?.reference) ==
                                        true) {
                                      await listViewFoodRecord.reference
                                          .update({
                                        ...mapToFirestore(
                                          {
                                            'FavouritesFood':
                                                FieldValue.arrayRemove([
                                              favouritesFoodsPageaaaUsersRecord
                                                  ?.reference
                                            ]),
                                          },
                                        ),
                                      });
                                    } else {
                                      await listViewFoodRecord.reference
                                          .update({
                                        ...mapToFirestore(
                                          {
                                            'FavouritesFood':
                                                FieldValue.arrayUnion([
                                              favouritesFoodsPageaaaUsersRecord
                                                  ?.reference
                                            ]),
                                          },
                                        ),
                                      });
                                    }
                                  },
                                  value: listViewFoodRecord.favouritesFood
                                      .contains(
                                          favouritesFoodsPageaaaUsersRecord
                                              ?.reference),
                                  onIcon: Icon(
                                    Icons.star,
                                    color: Color(0xFFEAEA1F),
                                    size: 30.0,
                                  ),
                                  offIcon: Icon(
                                    Icons.star,
                                    color: Color(0xFFCFCFCF),
                                    size: 30.0,
                                  ),
                                ),
                                ClipRRect(
  borderRadius: BorderRadius.circular(8.0),
  child: Image.network(
    listViewFoodRecord.image,
    width: 200.0,
    height: 200.0,
    fit: BoxFit.cover, // Changed from fitWidth to cover for better display
    loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
      if (loadingProgress == null) return child;
      return Center(
        child: CircularProgressIndicator(
          value: loadingProgress.expectedTotalBytes != null
              ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
              : null,
        ),
      );
    },
    errorBuilder: (context, error, stackTrace) {
      return Container(
        width: 200.0,
        height: 200.0,
        color: Colors.grey[200],
        child: Icon(Icons.fastfood, size: 50, color: Colors.grey[400]),
      );
    },
  ),
),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 16.0, 0.0, 0.0),
                                  child: Text(
                                    listViewFoodRecord.name,
                                    style: FlutterFlowTheme.of(context)
                                        .headlineMedium
                                        .override(
                                          font: GoogleFonts.outfit(
                                            fontWeight: FontWeight.w500,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .headlineMedium
                                                    .fontStyle,
                                          ),
                                          color: Color(0xFF15161E),
                                          fontSize: 24.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w500,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .headlineMedium
                                                  .fontStyle,
                                        ),
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      0.0, 4.0, 0.0, 0.0),
                                  child: Text(
                                    listViewFoodRecord.price.toString(),
                                    style: FlutterFlowTheme.of(context)
                                        .labelMedium
                                        .override(
                                          font: GoogleFonts.plusJakartaSans(
                                            fontWeight: FontWeight.w500,
                                            fontStyle:
                                                FlutterFlowTheme.of(context)
                                                    .labelMedium
                                                    .fontStyle,
                                          ),
                                          color: Color(0xFF606A85),
                                          fontSize: 14.0,
                                          letterSpacing: 0.0,
                                          fontWeight: FontWeight.w500,
                                          fontStyle:
                                              FlutterFlowTheme.of(context)
                                                  .labelMedium
                                                  .fontStyle,
                                        ),
                                  ),
                                ),
                                Align(
                                  alignment: AlignmentDirectional(0.0, 0.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.max,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Align(
                                        alignment:
                                            AlignmentDirectional(0.0, 0.0),
                                        child: Text(
                                          valueOrDefault<String>(
                                            listViewFoodRecord.expirationDate
                                                ?.toString(),
                                            '0',
                                          ),
                                          textAlign: TextAlign.start,
                                          style: FlutterFlowTheme.of(context)
                                              .bodyMedium
                                              .override(
                                                font: GoogleFonts.inter(
                                                  fontWeight:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontWeight,
                                                  fontStyle:
                                                      FlutterFlowTheme.of(
                                                              context)
                                                          .bodyMedium
                                                          .fontStyle,
                                                ),
                                                letterSpacing: 0.0,
                                                fontWeight:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontWeight,
                                                fontStyle:
                                                    FlutterFlowTheme.of(context)
                                                        .bodyMedium
                                                        .fontStyle,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
