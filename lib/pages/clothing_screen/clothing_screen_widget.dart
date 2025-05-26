import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '/index.dart';
import '/auth/firebase_auth/auth_util.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/flutter_flow_toggle_icon.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/backend/backend.dart';
import 'dart:ui';
import 'package:provider/provider.dart';

class ClothingScreenWidget extends StatefulWidget {
  const ClothingScreenWidget({super.key});

  static String routeName = 'ClothingScreen';
  static String routePath = '/clothingScreen';

  @override
  State<ClothingScreenWidget> createState() => _ClothingScreenWidgetState();
}

class _ClothingScreenWidgetState extends State<ClothingScreenWidget> {
  late TextEditingController _searchController;
  late FocusNode _searchFocusNode;
  DateTime? _maxExpirationDate;
  String _priceOrder = 'asc';

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _searchFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _searchFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<UsersRecord>>(
      stream: queryUsersRecord(singleRecord: true),
      builder: (context, userSnap) {
        if (!userSnap.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        final currentUser = userSnap.data!.firstOrNull;

        return Scaffold(
          backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
          appBar: AppBar(
            backgroundColor: const Color(0xFF71C0EA),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => context.pop(),
            ),
            title: Text(
              'Clothing',
              style: FlutterFlowTheme.of(context).headlineMedium.override(
                    fontFamily: 'Inter',
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
            ),
            centerTitle: true,
            elevation: 0,
          ),
          body: SafeArea(
            child: Column(
              children: [
                // --- Search Bar ---
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    controller: _searchController,
                    focusNode: _searchFocusNode,
                    decoration: InputDecoration(
                      hintText: 'Search clothing...',
                      prefixIcon: const Icon(Icons.search),
                      filled: true,
                      fillColor:
                          FlutterFlowTheme.of(context).secondaryBackground,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding:
                          const EdgeInsets.symmetric(vertical: 12),
                    ),
                    onChanged: (value) => EasyDebounce.debounce(
                      '_searchController',
                      const Duration(milliseconds: 500),
                      () => setState(() {}),
                    ),
                  ),
                ),

                // --- Filters ---
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: DropdownButtonFormField<String>(
                          value: _priceOrder,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: FlutterFlowTheme.of(context)
                                .secondaryBackground,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 12),
                          ),
                          items: const [
                            DropdownMenuItem(
                              value: 'asc',
                              child: Text('Price: Low to High'),
                            ),
                            DropdownMenuItem(
                              value: 'desc',
                              child: Text('Price: High to Low'),
                            ),
                          ],
                          onChanged: (value) =>
                              setState(() => _priceOrder = value!),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: InkWell(
                          onTap: () async {
                            final picked = await showDatePicker(
                              context: context,
                              initialDate:
                                  _maxExpirationDate ?? DateTime.now(),
                              firstDate: DateTime.now(),
                              lastDate: DateTime(2100),
                            );
                            if (picked != null) {
                              setState(() => _maxExpirationDate = picked);
                            }
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 16),
                            decoration: BoxDecoration(
                              color: FlutterFlowTheme.of(context)
                                  .secondaryBackground,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  _maxExpirationDate != null
                                      ? dateTimeFormat(
                                          'MMM d', _maxExpirationDate!)
                                      : 'Max date',
                                  style: FlutterFlowTheme.of(context)
                                      .bodyMedium,
                                ),
                                const Icon(Icons.calendar_today, size: 18),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // --- Clothing List ---
                Expanded(
                  child: StreamBuilder<List<ClothesRecord>>(
                    stream: queryClothesRecord(
                      queryBuilder: (clothesRecord) {
                        var query = clothesRecord.where(
                          'expiration_date',
                          isGreaterThanOrEqualTo: getCurrentTimestamp,
                        );
                        if (_maxExpirationDate != null) {
                          query = query.where(
                            'expiration_date',
                            isLessThanOrEqualTo:
                                Timestamp.fromDate(_maxExpirationDate!),
                          );
                        }
                        if (_searchController.text.isNotEmpty) {
                          query = query.where(
                            'search_keywords',
                            arrayContains:
                                _searchController.text.toLowerCase(),
                          );
                        }
                        return query.orderBy(
                          'price',
                          descending: _priceOrder == 'desc',
                        );
                      },
                    ),
                    builder: (context, snap) {
                      if (!snap.hasData) {
                        return const Center(
                            child: CircularProgressIndicator());
                      }
                      final clothes = snap.data!;
                      return ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: clothes.length,
                        itemBuilder: (context, index) {
                          final item = clothes[index];
                          return Card(
                            margin: const EdgeInsets.only(bottom: 16),
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(12),
                              onTap: () => context.pushNamed(
                                'ItemProfile',
                                queryParameters: {
                                  'name': serializeParam(
                                      item.name, ParamType.String),
                                  'image': serializeParam(
                                      item.image, ParamType.String),
                                  'price': serializeParam(
                                      item.price, ParamType.double),
                                  'brand': serializeParam(
                                      item.brand, ParamType.String),
                                  'quantity': serializeParam(
                                      item.quantity, ParamType.int),
                                  'endsBy': serializeParam(
                                      item.expirationDate,
                                      ParamType.DateTime),
                                  'seller': serializeParam(
                                      item.createdBy, ParamType.String),
                                }.withoutNulls,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Row(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    // Image
                                    ClipRRect(
                                      borderRadius:
                                          BorderRadius.circular(8),
                                      child: Container(
                                        width: 100,
                                        height: 100,
                                        color: Colors.grey[200],
                                        child: item.image.isNotEmpty
                                            ? CachedNetworkImage(
                                                imageUrl: item.image,
                                                width: 100,
                                                height: 100,
                                                fit: BoxFit.cover,
                                                placeholder:
                                                    (ctx, url) =>
                                                        const Center(
                                                            child:
                                                                CircularProgressIndicator()),
                                                errorWidget:
                                                    (ctx, url, err) =>
                                                        const Icon(
                                                            Icons
                                                                .image_not_supported,
                                                            size: 40),
                                              )
                                            : const Icon(
                                                Icons
                                                    .image_not_supported,
                                                size: 40),
                                      ),
                                    ),
                                    const SizedBox(width: 12),

                                    // Details
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            item.name,
                                            style: FlutterFlowTheme.of(
                                                    context)
                                                .titleLarge,
                                            maxLines: 2,
                                            overflow:
                                                TextOverflow.ellipsis,
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            item.brand,
                                            style: FlutterFlowTheme.of(
                                                    context)
                                                .bodyMedium,
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            '${item.price.toStringAsFixed(2)}€',
                                            style: FlutterFlowTheme.of(
                                                    context)
                                                .titleMedium
                                                .override(
                                                    color:
                                                        const Color(0xFF71C0EA)),
                                          ),

                                          const SizedBox(height: 4),
                                          Row(
                                            children: [
                                              const Icon(Icons.timer,
                                                  size: 16),
                                              const SizedBox(width: 4),
                                              Text(
                                                'Expires ${dateTimeFormat('MMM d', item.expirationDate)}',
                                                style: FlutterFlowTheme
                                                        .of(context)
                                                    .bodySmall,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    ToggleIcon(
                                      value: item.favouriteClothes.contains(currentUser?.reference),
                                      onIcon: const Icon(Icons.star, color: Colors.yellow),
                                      offIcon: const Icon(Icons.star_border),
                                      onPressed: () async {
                                        final ref = currentUser?.reference;
                                        if (ref == null) return;
                                        
                                        final update = item.favouriteClothes.contains(ref)
                                          ? FieldValue.arrayRemove([ref])
                                          : FieldValue.arrayUnion([ref]);
                                        await item.reference.update({'FavouriteClothes': update});
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),

                // Profile Button
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 12.0),
                  child: FFButtonWidget(
                    onPressed: () async {
                      context.pushNamed(
                          UserProfileSettingsWidget.routeName);
                    },
                    text: 'Profile',
                    options: FFButtonOptions(
                      height: 40.0,
                      padding:
                          const EdgeInsetsDirectional.fromSTEB(
                              16, 0, 16, 0),
                      color:
                          FlutterFlowTheme.of(context).primary,
                      textStyle: FlutterFlowTheme.of(context)
                          .titleSmall
                          .override(color: Colors.white),
                      elevation: 0.0,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
