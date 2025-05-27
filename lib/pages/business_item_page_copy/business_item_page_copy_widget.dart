import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/bottom_sheet_page_copy_widget.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'business_item_page_copy_model.dart';
import '/pages/login_page_copy/login_page_copy_widget.dart';

class BusinessItemPageCopyWidget extends StatefulWidget {
  const BusinessItemPageCopyWidget({super.key});

  static const String routeName = 'BusinessItemPageCopy';
  static const String routePath = '/businessItemPageCopy';

  @override
  State<BusinessItemPageCopyWidget> createState() =>
      _BusinessItemPageCopyWidgetState();
}

class _BusinessItemPageCopyWidgetState
    extends State<BusinessItemPageCopyWidget> {
  late BusinessItemPageCopyModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BusinessItemPageCopyModel());
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: theme.primaryBackground,
      floatingActionButton: FloatingActionButton(
        onPressed: () => showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          backgroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          builder: (context) => const BottomSheetPageCopyWidget(),
        ),
        backgroundColor: const Color(0xFF71C0EA),
        child: const Icon(Icons.menu, color: Colors.white),
      ),
      appBar: AppBar(
        backgroundColor: const Color(0xFF71C0EA),
        automaticallyImplyLeading: false, // no back arrow
        title: Text(
          'Listed Clothes',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<List<ClothesRecord>>(
        stream: queryClothesRecord(
          queryBuilder: (clothes) => clothes
              .where('created_by', isEqualTo: currentUserEmail)
              .where('expiration_date',
                  isGreaterThanOrEqualTo: getCurrentTimestamp)
              .orderBy('expiration_date'),
        ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Color(0xFF71C0EA),
              ),
            );
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text(
                'No clothes items found',
                style: theme.bodyMedium.override(color: Colors.white),
              ),
            );
          }

          final clothesList = snapshot.data!;

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: clothesList.length,
            separatorBuilder: (_, __) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              final clothes = clothesList[index];
              return _ClothesItemCard(clothes: clothes);
            },
          );
        },
      ),
    );
  }
}

class _ClothesItemCard extends StatelessWidget {
  final ClothesRecord clothes;

  const _ClothesItemCard({required this.clothes});

  @override
  Widget build(BuildContext context) {
    final theme = FlutterFlowTheme.of(context);

    return Card(
      color: theme.secondaryBackground, // Use secondaryBackground color
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: theme.secondaryBackground,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      clothes.image,
                      width: 120,
                      height: 120,
                      fit: BoxFit.cover,
                      errorBuilder: (ctx, err, stack) => Container(
                        color: Colors.grey.shade200,
                        child: const Icon(Icons.broken_image, size: 48),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                // Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Name
                      Text(
                        clothes.name,
                        style: theme.titleLarge.override(
                          color: theme.primaryText,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      // Brand
                      _buildDetailRow(context, 'Brand', clothes.brand),
                      const SizedBox(height: 8),
                      // Price and Quantity
                      Row(
                        children: [
                          _buildDetailRow(
                              context, 'Price', '${clothes.price}€'),
                          const SizedBox(width: 16),
                          _buildDetailRow(
                              context, 'Quantity', clothes.quantity.toString()),
                        ],
                      ),
                      const SizedBox(height: 8),
                      // Expiration
                      _buildDetailRow(
                        context,
                        'Ends by',
                        dateTimeFormat('d MMM y', clothes.expirationDate!),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 20),
                const SizedBox(width: 4),
                Text(
                  clothes.favouriteClothes.length.toString(),
                  style: theme.bodyMedium.override(color: theme.primaryText),
                ),
                const Spacer(),
                IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => _confirmDelete(context, clothes),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(BuildContext context, String label, String value) {
    final theme = FlutterFlowTheme.of(context);
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: '$label: ',
            style: theme.bodyMedium.override(
              fontWeight: FontWeight.w600,
              color: theme.primaryText,
            ),
          ),
          TextSpan(
            text: value,
            style: theme.bodyMedium.override(
              fontWeight: FontWeight.w500,
              color: theme.primaryText,
            ),
          ),
        ],
      ),
    );
  }

  void _confirmDelete(BuildContext context, ClothesRecord clothes) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Delete'),
        content: Text('Delete ${clothes.name}? This cannot be undone.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel',
                style: TextStyle(color: Color(0xFF71C0EA))),
          ),
          TextButton(
            onPressed: () {
              clothes.reference.delete();
              Navigator.pop(context);
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
