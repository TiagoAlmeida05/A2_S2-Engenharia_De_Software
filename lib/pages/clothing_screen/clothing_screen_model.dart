import '/flutter_flow/flutter_flow_util.dart';
import 'clothing_screen_widget.dart' show ClothingScreenWidget;
import 'package:flutter/material.dart';

class ClothingScreenModel extends FlutterFlowModel<ClothingScreenWidget> {
  ///  State fields for stateful widgets in this page.

  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;

  @override
  void initState(BuildContext context) {}

  @override
  void dispose() {
    textFieldFocusNode?.dispose();
    textController?.dispose();
  }
}
