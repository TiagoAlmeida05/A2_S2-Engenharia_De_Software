import '/flutter_flow/flutter_flow_calendar.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/form_field_controller.dart';
import '/index.dart';
import 'add_new_item_widget.dart' show AddNewItemWidget;
import 'package:flutter/material.dart';

class AddNewItemModel extends FlutterFlowModel<AddNewItemWidget> {
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
  // State field(s) for DropDown widget.
  String? dropDownValue;
  FormFieldController<String>? dropDownValueController;
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
