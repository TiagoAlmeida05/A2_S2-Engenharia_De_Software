import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/pages/add_new_item_copy/add_new_item_copy_widget.dart'; // Make sure this import exists
import '/pages/business_item_page/business_item_page_widget.dart'; // Make sure this import exists
import '/pages/login_page_copy/login_page_copy_widget.dart'; // Added for login page navigation
import '/auth/firebase_auth/auth_util.dart'; // Add this import to enable signOut()
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'bottom_sheet_page_copy_model.dart';
export 'bottom_sheet_page_copy_model.dart';

class BottomSheetPageCopyWidget extends StatefulWidget {
  const BottomSheetPageCopyWidget({super.key});

  @override
  State<BottomSheetPageCopyWidget> createState() =>
      _BottomSheetPageCopyWidgetState();
}

class _BottomSheetPageCopyWidgetState extends State<BottomSheetPageCopyWidget> {
  late BottomSheetPageCopyModel _model;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BottomSheetPageCopyModel());
  }

  @override
  void dispose() {
    _model.maybeDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Handle indicator
          Center(
            child: Container(
              width: 48,
              height: 4,
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),

          // Add New Clothes option
          _buildActionTile(
            icon: Icons.add_circle_outlined,
            title: 'Add New Clothes',
            onTap: () => context.pushNamed(AddNewItemCopyWidget.routeName),
          ),

          const SizedBox(height: 12),

          // Change to Food Page option
          _buildActionTile(
            icon: Icons.swap_horiz_rounded,
            title: 'Switch to Food Page',
            onTap: () => context.pushNamed(BusinessItemPageWidget.routeName),
          ),

          const SizedBox(height: 12),

          // Sign Out option
          _buildActionTile(
            icon: Icons.logout,
            title: 'Sign Out',
            iconColor: Colors.red,
            textColor: Colors.red,
            onTap: () async {
              await authManager.signOut();
              if (context.mounted) {
                context.goNamed(LoginPageCopyWidget.routeName);
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildActionTile({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color iconColor = const Color(0xFF71C0EA),
    Color textColor = Colors.black,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.symmetric(vertical: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey[200]!),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                color: iconColor,
                size: 28,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: textColor,
                  ),
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios_rounded,
                size: 16,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
