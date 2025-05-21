import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class ItemProfileWidget extends StatefulWidget {
  const ItemProfileWidget({
    super.key,
    required this.name,
    required this.price,
    required this.brand,
    required this.quantity,
    required this.endsBy,
    required this.shopsName,
    required this.city,
    required this.street,
    required this.zipCode,
    required this.image,
    required this.seller,
  });

  final String? name;
  final double? price;
  final String? brand;
  final int? quantity;
  final DateTime? endsBy;
  final String? shopsName;
  final String? city;
  final String? street;
  final String? zipCode;
  final String? image;
  final String? seller;

  static String routeName = 'ItemProfile';
  static String routePath = '/itemProfile';

  @override
  State<ItemProfileWidget> createState() => _ItemProfileWidgetState();
}

class _ItemProfileWidgetState extends State<ItemProfileWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
      appBar: AppBar(
        backgroundColor: const Color(0xFF71C0EA),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Colors.white, size: 30),
          onPressed: () => context.pop(),
        ),
        title: Text(
          widget.name ?? 'Item Details',
          style: GoogleFonts.inter(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
        elevation: 2,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Image Section
            Container(
              width: double.infinity,
              height: 300,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                child: Image.network(
                  widget.image!,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => const Icon(Icons.image, size: 100),
                ),
              ),
            ),

            // Details Section
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Basic Info
                  _buildInfoCard(
                    children: [
                      _buildDetailRow('Brand', widget.brand ?? 'N/A'),
                      _buildDetailRow('Price', '${widget.price?.toStringAsFixed(2)}€'),
                      _buildDetailRow('Quantity', widget.quantity?.toString() ?? 'N/A'),
                      _buildDetailRow('Expires', dateTimeFormat('MMM d, y', widget.endsBy) ?? 'N/A'),
                    ],
                  ),

                  const SizedBox(height: 20),


                  // Seller Info (from stream)
                  widget.seller != null
  ? StreamBuilder<List<BusinessesRecord>>(
      stream: queryBusinessesRecord(
        queryBuilder: (business) =>
            business.where('email', isEqualTo: widget.seller),
        singleRecord: true,
      ),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data!.isNotEmpty) {
          final business = snapshot.data!.first;
          return Padding(
            padding: const EdgeInsets.only(top: 20),
            child: _buildInfoCard(
              children: [
                _buildDetailRow('City', business.city),
                _buildDetailRow('Adress', _buildAddressString(business.streetAdress, business.zipCode)),
                _buildDetailRow('Seller', business.displayName),
                _buildDetailRow('Contact', business.email),
              ],
            ),
          );
        }
        return const SizedBox(); // still loading or not found
      },
    )
  : const SizedBox(), // ← this was missing
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _buildAddressString(String street, String zipCode) {
    return '$street, $zipCode';
  }

  Widget _buildInfoCard({required List<Widget> children}) {
    return Card(
      elevation: 3,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              '$label:',
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.grey[700],
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}