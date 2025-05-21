import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_toggle_icon.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'supermarket_screen_model.dart';

export 'supermarket_screen_model.dart';

class SupermarketScreenWidget extends StatefulWidget {
  const SupermarketScreenWidget({super.key});

  static const String routeName = 'SupermarketScreen';
  static const String routePath = '/supermarketScreen';

  @override
  State<SupermarketScreenWidget> createState() => _SupermarketScreenWidgetState();
}

Future<void> convertPricesToDoubleIfNeeded1() async {
  final foodDocs = await FirebaseFirestore.instance.collection('Food').get();
  for (final doc in foodDocs.docs) {
    final price = doc.data()['price'];
    if (price is int) {
      await doc.reference.update({'price': price.toDouble()});
    }
  }

  final allFoodDocs = await FirebaseFirestore.instance.collectionGroup('All_Food').get();
  for (final doc in allFoodDocs.docs) {
    final price = doc.data()['price'];
    if (price is int) {
      await doc.reference.update({'price': price.toDouble()});
    }
  }
}

class _SupermarketScreenWidgetState extends State<SupermarketScreenWidget> {
  late SupermarketScreenModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => SupermarketScreenModel());
    convertPricesToDoubleIfNeeded1();

    _model.priceOrder ??= 'asc';
    _model.textController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return StreamBuilder<List<UsersRecord>>(
      stream: queryUsersRecord(singleRecord: true),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final currentUser = snapshot.data!.firstOrNull;

        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            title: const Text('Supermarket Products'),
            leading: BackButton(onPressed: () => context.safePop()),
            backgroundColor: const Color(0xFF71C0EA),
            centerTitle: true,
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Search Field
                TextFormField(
                  controller: _model.textController,
                  focusNode: _model.textFieldFocusNode,
                  onChanged: (_) => EasyDebounce.debounce(
                    '_model.textController',
                    const Duration(milliseconds: 500),
                    () {
                      FFAppState().searchQuery = _model.textController.text.toLowerCase().trim();
                      FFAppState().update(() {});
                    },
                  ),
                  decoration: InputDecoration(
                    hintText: 'Search foods...',
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24.0),
                    ),
                  ),
                ),

                const SizedBox(height: 12.0),

                // Filters
                Row(
  children: [
    Expanded(
      child: DropdownButtonFormField<String>(
        value: _model.priceOrder,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          labelText: 'Sort by',
          labelStyle: FlutterFlowTheme.of(context).labelMedium,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          filled: true,
          fillColor: FlutterFlowTheme.of(context).secondaryBackground,
        ),
        icon: const Icon(Icons.arrow_drop_down),
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
        onChanged: (val) {
          setState(() {
            _model.priceOrder = val!;
          });
        },
      ),
    ),
    const SizedBox(width: 12.0),
    TextButton.icon(
      icon: const Icon(Icons.date_range),
      label: Text(
        _model.maxExpirationDate != null
            ? dateTimeFormat('yMMMd', _model.maxExpirationDate!)
            : 'Max Expiration',
      ),
      onPressed: () async {
        final picked = await showDatePicker(
          context: context,
          initialDate: _model.maxExpirationDate ?? DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime(2100),
        );
        if (picked != null) {
          setState(() => _model.maxExpirationDate = picked);
        }
      },
    ),
  ],
),


                const SizedBox(height: 12.0),

                // Product List
                Expanded(
                  child: StreamBuilder<List<FoodRecord>>(
                    stream: queryFoodRecord(
                      queryBuilder: (food) {
                        var query = food.where(
                          'expiration_date',
                          isGreaterThanOrEqualTo: getCurrentTimestamp,
                        );

                        if (_model.maxExpirationDate != null) {
                          query = query.where(
                            'expiration_date',
                            isLessThanOrEqualTo: Timestamp.fromDate(_model.maxExpirationDate!),
                          );
                        }

                        if (FFAppState().searchQuery.isNotEmpty) {
                          query = query.where(
                            'search_keywords',
                            arrayContains: FFAppState().searchQuery,
                          );
                        }

                        return query
                            .orderBy('expiration_date')
                            .orderBy('price', descending: _model.priceOrder == 'desc');
                      },
                    ),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      var items = snapshot.data!;
                      items.sort((a, b) => a.price.compareTo(b.price));
                      if (_model.priceOrder == 'desc') {
                        items = items.reversed.toList();
                      }

                      return ListView.builder(
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          final item = items[index];
                          return InkWell(
  onTap: () => context.pushNamed(
  'ItemProfileCopy',
  queryParameters: {
    'name': serializeParam(item.name, ParamType.String),
    'image': serializeParam(item.image, ParamType.String),
    'price': serializeParam(item.price, ParamType.double),
    'quantity': serializeParam(item.quantity, ParamType.int),
    'endsBy': serializeParam(item.expirationDate, ParamType.DateTime),
    'seller': serializeParam(item.createdBy, ParamType.String),
  }.withoutNulls,
),
  child: Card(
    margin: const EdgeInsets.symmetric(vertical: 8.0),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              item.image,
              width: 64,
              height: 64,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.broken_image, size: 64),
            ),
          ),
          const SizedBox(width: 12.0),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.name,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 4.0),
                Text(
                  '${item.price.toStringAsFixed(2)} € • Expires ${dateTimeFormat("d/M/y", item.expirationDate!)}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
          ToggleIcon(
            value: item.favouritesFood.contains(currentUser?.reference),
            onIcon: const Icon(Icons.star, color: Colors.yellow),
            offIcon: const Icon(Icons.star_border),
            onPressed: () async {
              final ref = currentUser?.reference;
              if (ref == null) return;

              final update = item.favouritesFood.contains(ref)
                  ? FieldValue.arrayRemove([ref])
                  : FieldValue.arrayUnion([ref]);

              await item.reference.update({'FavouritesFood': update});
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
              ],
            ),
          ),
        );
      },
    );
  }
}
