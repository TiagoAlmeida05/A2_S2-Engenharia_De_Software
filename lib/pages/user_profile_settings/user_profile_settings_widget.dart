import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_icon_button.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'user_profile_settings_model.dart';
export 'user_profile_settings_model.dart';

class UserProfileSettingsWidget extends StatefulWidget {
  const UserProfileSettingsWidget({super.key});

  static String routeName = 'UserProfileSettings';
  static String routePath = '/userProfileSettings';

  @override
  State<UserProfileSettingsWidget> createState() =>
      _UserProfileSettingsWidgetState();
}

class _UserProfileSettingsWidgetState
    extends State<UserProfileSettingsWidget> {
  late UserProfileSettingsModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => UserProfileSettingsModel());
    _model.newPasswordTextController ??= TextEditingController();
    _model.newPasswordFocusNode ??= FocusNode();
    _model.confirmNewPasswordTextController ??= TextEditingController();
    _model.confirmNewPasswordFocusNode ??= FocusNode();
  }

  @override
  void dispose() {
    _model.dispose();
    super.dispose();
  }

  OutlineInputBorder _fieldBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8.0),
      borderSide: BorderSide(color: Colors.grey.shade400, width: 1.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return StreamBuilder<List<UsersRecord>>(
      stream: queryUsersRecord(singleRecord: true),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Scaffold(
            backgroundColor: const Color(0xFFF1F4F8),
            body: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  FlutterFlowTheme.of(context).primary,
                ),
              ),
            ),
          );
        }
        final userRecord = snapshot.data!.firstOrNull;
        if (userRecord == null) return const SizedBox();

        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            key: scaffoldKey,
            backgroundColor: const Color(0xFFF1F4F8),
            appBar: AppBar(
              backgroundColor: const Color(0xFF71C0EA),
              automaticallyImplyLeading: false,
              leading: FlutterFlowIconButton(
                borderRadius: 40.0,
                buttonSize: 40.0,
                icon: const Icon(Icons.arrow_back_rounded,
                    color: Colors.white, size: 24.0),
                onPressed: () => context.safePop(),
              ),
              title: Text(
                'Profile Settings',
                style: FlutterFlowTheme.of(context).headlineMedium.override(
                      fontFamily: 'Plus Jakarta Sans',
                      color: Colors.white,
                      fontSize: 22.0,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              centerTitle: false,
              elevation: 0.0,
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    // —— PROFILE CARD —— 
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      elevation: 2,
                      color: Colors.white,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ListTile(
                            leading: const Icon(
                              Icons.email_outlined,
                              color: Colors.black54,
                            ),
                            title: const Text(
                              'Email',
                              style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            subtitle: Text(
                currentUserEmail,
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black87,
                ),
              ),
                          ),
                          const Divider(height: 1),
                          ListTile(
                            leading: const Icon(
                              Icons.checkroom_outlined,
                              color: Colors.black54,
                            ),
                            title: const Text(
                              'Favourites: Clothes',
                              style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            trailing: FlutterFlowIconButton(
                              borderRadius: 20.0,
                              buttonSize: 44.0,
                              fillColor: Colors.grey.shade100,
                              icon: const Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.black54,
                                size: 20.0,
                              ),
                              onPressed: () {
                                context.pushNamed(
                                  FavouritesClothesPageWidget.routeName,
                                );
                              },
                            ),
                          ),
                          const Divider(height: 1),
                          ListTile(
                            leading: const Icon(
                              Icons.fastfood_outlined,
                              color: Colors.black54,
                            ),
                            title: const Text(
                              'Favourites: Foods',
                              style: TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            trailing: FlutterFlowIconButton(
                              borderRadius: 20.0,
                              buttonSize: 44.0,
                              fillColor: Colors.grey.shade100,
                              icon: const Icon(
                                Icons.arrow_forward_ios,
                                color: Colors.black54,
                                size: 20.0,
                              ),
                              onPressed: () {
                                context.pushNamed(
                                  FavouritesFoodsPageaaaWidget.routeName,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24.0),

                    // — Account Settings —
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Account Settings',
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                            ),
                          ),
                          const Divider(height: 24.0),

                          // Password Change Section
                          FFButtonWidget(
                            onPressed: () => setState(() {
                              FFAppState().VisibilidadeNewPassword =
                                  !FFAppState().VisibilidadeNewPassword;
                            }),
                            text: 'Change your Password',
                            options: FFButtonOptions(
                              width: double.infinity,
                              height: 44.0,
                              color: Colors.white,
                              textStyle: const TextStyle(
                                color: Colors.blue,
                                fontSize: 16.0,
                              ),
                              borderSide: BorderSide(
                                color: Colors.grey.shade300,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),

                          if (FFAppState().VisibilidadeNewPassword) ...[
                            const SizedBox(height: 16.0),
                            TextFormField(
                              controller: _model.newPasswordTextController,
                              focusNode: _model.newPasswordFocusNode,
                              obscureText: !_model.newPasswordVisibility,
                              decoration: InputDecoration(
                                labelText: 'New Password',
                                labelStyle:
                                    const TextStyle(color: Colors.black54),
                                border: _fieldBorder(),
                                enabledBorder: _fieldBorder(),
                                focusedBorder: _fieldBorder().copyWith(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context).primary,
                                    width: 2.0,
                                  ),
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _model.newPasswordVisibility
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.black54,
                                  ),
                                  onPressed: () => setState(() {
                                    _model.newPasswordVisibility =
                                        !_model.newPasswordVisibility;
                                  }),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16.0),
                            TextFormField(
                              controller:
                                  _model.confirmNewPasswordTextController,
                              focusNode: _model.confirmNewPasswordFocusNode,
                              obscureText: !_model.confirmNewPasswordVisibility,
                              decoration: InputDecoration(
                                labelText: 'Confirm New Password',
                                labelStyle:
                                    const TextStyle(color: Colors.black54),
                                border: _fieldBorder(),
                                enabledBorder: _fieldBorder(),
                                focusedBorder: _fieldBorder().copyWith(
                                  borderSide: BorderSide(
                                    color: FlutterFlowTheme.of(context).primary,
                                    width: 2.0,
                                  ),
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    _model.confirmNewPasswordVisibility
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Colors.black54,
                                  ),
                                  onPressed: () => setState(() {
                                    _model.confirmNewPasswordVisibility =
                                        !_model.confirmNewPasswordVisibility;
                                  }),
                                ),
                              ),
                            ),
                            const SizedBox(height: 16.0),
                            FFButtonWidget(
                              onPressed: () async {
                                if (_model.confirmNewPasswordTextController
                                        .text ==
                                    _model.newPasswordTextController.text) {
                                  await authManager.updatePassword(
                                    newPassword:
                                        _model.newPasswordTextController.text,
                                    context: context,
                                  );
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          'Password changed successfully!'),
                                      duration: Duration(seconds: 4),
                                    ),
                                  );
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Passwords do not match!'),
                                      duration: Duration(seconds: 4),
                                    ),
                                  );
                                }
                              },
                              text: 'Change!',
                              options: FFButtonOptions(
                                width: double.infinity,
                                height: 44.0,
                                color: const Color(0xFF71C0EA),
                                textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                ),
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),

                    const SizedBox(height: 24.0),

                    // — Sign Out —
                    FFButtonWidget(
                      onPressed: () async {
                        GoRouter.of(context).prepareAuthEvent();
                        await authManager.signOut();
                        GoRouter.of(context).clearRedirectLocation();
                        context.pushNamedAuth(
                          LoginPageWidget.routeName,
                          context.mounted,
                        );
                      },
                      text: 'Sign Out',
                      options: FFButtonOptions(
                        width: double.infinity,
                        height: 44.0,
                        color: Colors.white,
                        textStyle: const TextStyle(
                          color: Color(0xFFE65454),
                          fontSize: 16.0,
                        ),
                        borderSide: BorderSide(
                          color: Colors.grey.shade300,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
