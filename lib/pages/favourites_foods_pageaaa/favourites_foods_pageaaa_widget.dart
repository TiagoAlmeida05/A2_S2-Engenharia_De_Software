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
    // No more fetching user record, use currentUserReference directly
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      appBar: AppBar(
        backgroundColor: const Color(0xFF71C0EA),
        automaticallyImplyLeading: false,
        leading: FlutterFlowIconButton(
          borderRadius: 8.0,
          buttonSize: 40.0,
          fillColor: const Color(0xFF71C0EA),
          icon: Icon(
            Icons.arrow_back,
            color: FlutterFlowTheme.of(context).info,
            size: 24.0,
          ),
          onPressed: () => context.safePop(),
        ),
        title: Align(
          alignment: AlignmentDirectional(0.0, 0.0),
          child: Padding(
            padding: const EdgeInsets.only(right: 45.0),
            child: Text(
              'My Favorites Foods',
              textAlign: TextAlign.center,
              style: FlutterFlowTheme.of(context).headlineMedium.override(
                    font: GoogleFonts.interTight(
                      fontWeight: FontWeight.w600,
                      fontStyle:
                          FlutterFlowTheme.of(context).headlineMedium.fontStyle,
                    ),
                    color: FlutterFlowTheme.of(context).info,
                    fontSize: 22.0,
                    letterSpacing: 0.0,
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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: StreamBuilder<List<FoodRecord>>(
            stream: queryFoodRecord(
              queryBuilder: (foodRecord) => foodRecord.where(
                'FavouritesFood',
                arrayContains: currentUserReference,
              ),
            ),
            builder: (context, snapshot) {
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
              final foodList = snapshot.data!;
              if (foodList.isEmpty) {
                return Center(
                  child: Text(
                    'No favorite foods found',
                    style: FlutterFlowTheme.of(context).bodyMedium,
                  ),
                );
              }
              return ListView.builder(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                itemCount: foodList.length,
                itemBuilder: (context, index) {
                  final item = foodList[index];
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ToggleIcon(
                        value: item.favouritesFood.contains(currentUserReference),
                        onIcon: const Icon(
                          Icons.star,
                          color: Color(0xFFEAEA1F),
                          size: 30.0,
                        ),
                        offIcon: const Icon(
                          Icons.star,
                          color: Color(0xFFCFCFCF),
                          size: 30.0,
                        ),
                        onPressed: () async {
                          final favRef = currentUserReference;
                          if (favRef == null) return;
                          final isFav = item.favouritesFood.contains(favRef);
                          final update = isFav
                              ? FieldValue.arrayRemove([favRef])
                              : FieldValue.arrayUnion([favRef]);
                          await item.reference.update({
                            'FavouritesFood': update,
                          });
                        },
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: (item.hasImage() && item.image.isNotEmpty)
                            ? Image.network(
                                item.image,
                                width: 200,
                                height: 200,
                                fit: BoxFit.cover,
                                loadingBuilder: (context, child, progress) {
                                  if (progress == null) return child;
                                  return Center(
                                    child: CircularProgressIndicator(
                                      value: progress.expectedTotalBytes != null
                                          ? progress.cumulativeBytesLoaded /
                                              progress.expectedTotalBytes!
                                          : null,
                                    ),
                                  );
                                },
                                errorBuilder: (context, error, stackTrace) =>
                                    Container(
                                  width: 200,
                                  height: 200,
                                  color: Colors.grey[200],
                                  child: const Icon(
                                    Icons.broken_image,
                                    size: 48,
                                    color: Colors.grey,
                                  ),
                                ),
                              )
                            : Container(
                                width: 200,
                                height: 200,
                                color: Colors.grey[200],
                                child: const Icon(
                                  Icons.fastfood,
                                  size: 48,
                                  color: Colors.grey,
                                ),
                              ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: Text(
                          item.name,
                          style: FlutterFlowTheme.of(context)
                              .headlineMedium
                              .override(
                                font: GoogleFonts.outfit(
                                  fontWeight: FontWeight.w500,
                                ),
                                color: const Color(0xFF15161E),
                                fontSize: 24.0,
                              ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0),
                        child: Text(
                          item.price.toString(),
                          style: FlutterFlowTheme.of(context)
                              .labelMedium
                              .override(
                                font: GoogleFonts.plusJakartaSans(
                                  fontWeight: FontWeight.w500,
                                ),
                                color: const Color(0xFF606A85),
                                fontSize: 14.0,
                              ),
                        ),
                      ),
                      Align(
                        alignment: AlignmentDirectional.center,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            item.expirationDate != null
                                ? dateTimeFormat('d MMM y', item.expirationDate!)
                                : 'No expiration',
                            style: FlutterFlowTheme.of(context).bodyMedium,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
