import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/components/bottom_sheet_page_widget.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'business_item_page_model.dart';
export 'business_item_page_model.dart';

class BusinessItemPageWidget extends StatefulWidget {
  const BusinessItemPageWidget({super.key});

  // Add these static route definitions
  static const String routeName = 'BusinessItemPage';
  static const String routePath = '/businessItemPage';

  @override
  State<BusinessItemPageWidget> createState() => _BusinessItemPageWidgetState();
}
class _BusinessItemPageWidgetState extends State<BusinessItemPageWidget> {
  late BusinessItemPageModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BusinessItemPageModel());
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        key: scaffoldKey,
        backgroundColor: FlutterFlowTheme.of(context).primaryBackground,
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await showModalBottomSheet(
              isScrollControlled: true,
              backgroundColor: Color(0xFF71C0EA),
              enableDrag: false,
              context: context,
              builder: (context) {
                return GestureDetector(
                  onTap: () => FocusScope.of(context).unfocus(),
                  child: Padding(
                    padding: MediaQuery.viewInsetsOf(context),
                    child: Container(
                      height: 150.0,
                      child: BottomSheetPageWidget(),
                    ),
                  ),
                );
              },
            ).then((value) => safeSetState(() {}));
          },
          backgroundColor: Color(0xFF71C0EA),
          elevation: 8.0,
          child: Icon(
            Icons.keyboard_control_sharp,
            color: Colors.white,
            size: 28.0,
          ),
        ),
        appBar: AppBar(
          backgroundColor: Color(0xFF71C0EA),
          automaticallyImplyLeading: false,
          leading: FlutterFlowIconButton(
            borderRadius: 20.0,
            buttonSize: 40.0,
            icon: Icon(
              Icons.arrow_back_rounded,
              color: Colors.white,
              size: 24.0,
            ),
            onPressed: () async {
              context.pushNamed(LoginPageCopyWidget.routeName);
            },
          ),
          title: Text(
            'Listed Foods',
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 22.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
          elevation: 0,
        ),
        body: SafeArea(
          top: true,
          child: StreamBuilder<List<FoodRecord>>(
            stream: queryFoodRecord(),
            builder: (context, snapshot) {
              // Customize what your widget looks like when it's loading.
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Color(0xFF71C0EA),
                    ),
                  ),
                );
              }
              List<FoodRecord> listViewFoodRecordList = snapshot.data!;

              return Padding(
                padding: EdgeInsets.all(12.0),
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemCount: listViewFoodRecordList.length,
                  itemBuilder: (context, listViewIndex) {
                    final listViewFoodRecord = listViewFoodRecordList[listViewIndex];
                    return StreamBuilder<List<FoodRecord>>(
                      stream: queryFoodRecord(
                        queryBuilder: (foodRecord) => foodRecord
                            .where(
                              'created_by',
                              isEqualTo: currentUserEmail,
                            )
                            .where(
                              'expiration_date',
                              isGreaterThanOrEqualTo: getCurrentTimestamp,
                            ),
                      ),
                      builder: (context, snapshot) {
                        // Customize what your widget looks like when it's loading.
                        if (!snapshot.hasData) {
                          return SizedBox.shrink();
                        }
                        List<FoodRecord> cardFoodRecordList = snapshot.data!;

                        return Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.0),
                          child: Card(
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            color: Colors.white,
                            elevation: 4.0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(12.0),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Image
                                  Container(
                                    width: 120.0,
                                    height: 120.0,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.0),
                                      color: Colors.grey[100],
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10.0),
                                      child: Image.network(
                                        listViewFoodRecord.image,
                                        width: 120.0,
                                        height: 120.0,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 12.0),
                                  // Details
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        // Food Name
                                        Text(
                                          listViewFoodRecord.name,
                                          style: GoogleFonts.inter(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black87,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        SizedBox(height: 8.0),
                                        
                                        // Price
                                        RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: 'Price: ',
                                                style: GoogleFonts.inter(
                                                  fontSize: 14.0,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.grey[700],
                                                ),
                                              ),
                                              TextSpan(
                                                text: '${listViewFoodRecord.price.toString()}€',
                                                style: GoogleFonts.inter(
                                                  fontSize: 14.0,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black87,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 4.0),
                                        
                                        // Quantity
                                        RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: 'Quantity: ',
                                                style: GoogleFonts.inter(
                                                  fontSize: 14.0,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.grey[700],
                                                ),
                                              ),
                                              TextSpan(
                                                text: listViewFoodRecord.quantity.toString(),
                                                style: GoogleFonts.inter(
                                                  fontSize: 14.0,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black87,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 4.0),
                                        
                                        // Expiration Date
                                        RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: 'Expires: ',
                                                style: GoogleFonts.inter(
                                                  fontSize: 14.0,
                                                  fontWeight: FontWeight.w500,
                                                  color: Colors.grey[700],
                                                ),
                                              ),
                                              TextSpan(
                                                text: dateTimeFormat("d MMM y", listViewFoodRecord.expirationDate!),
                                                style: GoogleFonts.inter(
                                                  fontSize: 14.0,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black87,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 8.0),
                                        
                                        // Rating and Delete Button
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.star_rounded,
                                              color: Color(0xFFFFD700),
                                              size: 24.0,
                                            ),
                                            SizedBox(width: 4.0),
                                            Text(
                                              '4.5', // Replace with actual rating if available
                                              style: GoogleFonts.inter(
                                                fontSize: 14.0,
                                                color: Colors.grey[700],
                                              ),
                                            ),
                                            Spacer(),
                                            FlutterFlowIconButton(
                                              borderRadius: 8.0,
                                              buttonSize: 40.0,
                                              icon: FaIcon(
                                                FontAwesomeIcons.trash,
                                                color: Colors.red,
                                                size: 18.0,
                                              ),
                                              onPressed: () async {
                                                var confirmDialogResponse = await showDialog<bool>(
                                                      context: context,
                                                      builder: (alertDialogContext) {
                                                        return AlertDialog(
                                                          title: Text('Are you sure?'),
                                                          content: Text('After deleting this item, there is no going back'),
                                                          actions: [
                                                            TextButton(
                                                              onPressed: () => Navigator.pop(alertDialogContext, false),
                                                              child: Text('Cancel'),
                                                            ),
                                                            TextButton(
                                                              onPressed: () => Navigator.pop(alertDialogContext, true),
                                                              child: Text('Delete'),
                                                            ),
                                                          ],
                                                        );
                                                      },
                                                    ) ?? false;
                                                if (confirmDialogResponse) {
                                                  await listViewFoodRecord.reference.delete();
                                                }
                                              },
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
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
              );
            },
          ),
        ),
      ),
    );
  }
}