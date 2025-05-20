import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'supermarket_screen_widget.dart' show SupermarketScreenWidget;
import 'package:flutter/material.dart';

class SupermarketScreenModel extends FlutterFlowModel<SupermarketScreenWidget> {
  /// State fields for stateful widgets in this page.

  // Search bar
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;

  // Price order: 'asc' or 'desc'
  String? priceOrder;

  // Expiration date filter
  DateTime? maxExpirationDate;

  @override
  void initState(BuildContext context) {
    priceOrder = 'asc'; // default sort
  }

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
