import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/backend/firebase_storage/storage.dart';
import '/flutter_flow/flutter_flow_calendar.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/upload_data.dart';
import 'dart:ui';
import '/flutter_flow/custom_functions.dart' as functions;
import '/index.dart';
import 'add_new_item_copy_widget.dart' show AddNewItemCopyWidget;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AddNewItemCopyModel extends FlutterFlowModel<AddNewItemCopyWidget> {
  ///  State fields for stateful widgets in this page.

  bool isDataUploading = false;
  FFUploadedFile uploadedLocalFile =
      FFUploadedFile(bytes: Uint8List.fromList([]));
  String uploadedFileUrl = '';

  // State field(s) for BusinessName widget.
  FocusNode? businessNameFocusNode1;
  TextEditingController? businessNameTextController1;
  String? Function(BuildContext, String?)? businessNameTextController1Validator;
  // State field(s) for BusinessName widget.
  FocusNode? businessNameFocusNode2;
  TextEditingController? businessNameTextController2;
  String? Function(BuildContext, String?)? businessNameTextController2Validator;
  // State field(s) for Calendar widget.
  DateTimeRange? calendarSelectedDay;
  // State field(s) for TextField widget.
  FocusNode? textFieldFocusNode;
  TextEditingController? textController3;
  String? Function(BuildContext, String?)? textController3Validator;
  // State field(s) for BusinessName widget.
  FocusNode? businessNameFocusNode3;
  TextEditingController? businessNameTextController3;
  String? Function(BuildContext, String?)? businessNameTextController3Validator;

  @override
  void initState(BuildContext context) {
    calendarSelectedDay = DateTimeRange(
      start: DateTime.now().startOfDay,
      end: DateTime.now().endOfDay,
    );
  }

  @override
  void dispose() {
    businessNameFocusNode1?.dispose();
    businessNameTextController1?.dispose();

    businessNameFocusNode2?.dispose();
    businessNameTextController2?.dispose();

    textFieldFocusNode?.dispose();
    textController3?.dispose();

    businessNameFocusNode3?.dispose();
    businessNameTextController3?.dispose();
  }
}
