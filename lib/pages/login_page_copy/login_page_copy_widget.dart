import '/auth/firebase_auth/auth_util.dart';
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'dart:ui';
import '/index.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'login_page_copy_model.dart';
export 'login_page_copy_model.dart';

class LoginPageCopyWidget extends StatefulWidget {
  const LoginPageCopyWidget({super.key});

  static String routeName = 'LoginPageCopy';
  static String routePath = '/loginPageCopy';

  @override
  State<LoginPageCopyWidget> createState() => _LoginPageCopyWidgetState();
}

class _LoginPageCopyWidgetState extends State<LoginPageCopyWidget> {
  late LoginPageCopyModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => LoginPageCopyModel());

    _model.usernameTextController ??= TextEditingController();
    _model.usernameFocusNode ??= FocusNode();
    _model.passwordTextController ??= TextEditingController();
    _model.textFieldFocusNode ??= FocusNode();
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
        backgroundColor: const Color(0xFF71C0EA),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  // Background waves decoration
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: ClipPath(
                      clipper: WaveClipper(),
                      child: Container(
                        height: 150,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              const Color(0xFF52A8DF),
                              const Color(0xFF71C0EA).withOpacity(0.8),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                        ),
                      ),
                    ),
                  ),
                  
                  // Main content
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Hero(
                          tag: 'business-logo',
                          child: Image.asset(
                            'assets/images/Adobe_Express_-_file.png',
                            height: 150,
                            fit: BoxFit.contain,
                          ),
                        ),
                        const SizedBox(height: 40),
                        
                        Material(
                          elevation: 8,
                          borderRadius: BorderRadius.circular(16),
                          child: Container(
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  'Business Login',
                                  style: GoogleFonts.inter(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: const Color(0xFF052A7C),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  'Please enter your business credentials',
                                  style: GoogleFonts.inter(
                                    color: Colors.grey[600],
                                  ),
                                ),
                                const SizedBox(height: 24),
                                
                                TextFormField(
                                  controller: _model.usernameTextController,
                                  focusNode: _model.usernameFocusNode,
                                  style: const TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                    labelText: 'Business Email',
                                    labelStyle: const TextStyle(color: Color(0xFF052A7C)),
                                    prefixIcon: const Icon(Icons.business, color: Color(0xFF71C0EA)),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(color: Colors.grey[300]!),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: const BorderSide(color: Color(0xFF71C0EA), width: 2),
                                    ),
                                    filled: true,
                                    fillColor: Colors.grey[50],
                                  ),
                                ),
                                const SizedBox(height: 16),
                                
                                TextFormField(
                                  controller: _model.passwordTextController,
                                  focusNode: _model.textFieldFocusNode,
                                  obscureText: !_model.passwordVisibility,
                                  style: const TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                    labelText: 'Password',
                                    labelStyle: const TextStyle(color: Color(0xFF052A7C)),
                                    prefixIcon: const Icon(Icons.lock_outline, color: Color(0xFF71C0EA)),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _model.passwordVisibility 
                                          ? Icons.visibility 
                                          : Icons.visibility_off,
                                        color: Colors.grey[500],
                                      ),
                                      onPressed: () => setState(() {
                                        _model.passwordVisibility = !_model.passwordVisibility;
                                      }),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: BorderSide(color: Colors.grey[300]!),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                      borderSide: const BorderSide(color: Color(0xFF71C0EA), width: 2),
                                    ),
                                    filled: true,
                                    fillColor: Colors.grey[50],
                                  ),
                                ),
                                const SizedBox(height: 8),
                                
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: TextButton(
                                    onPressed: () => context.pushNamed('ResetPasswordWidget'),
                                    child: Text(
                                      'Forgot Password?',
                                      style: GoogleFonts.inter(
                                        color: const Color(0xFF052A7C),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                
                                FFButtonWidget(
                                  onPressed: () async {
                                    GoRouter.of(context).prepareAuthEvent();
                                    final user = await authManager.signInWithEmail(
                                      context,
                                      _model.usernameTextController.text,
                                      _model.passwordTextController.text,
                                    );
                                    if (user == null) {
                                      return;
                                    }
                                    
                                    _model.businessOutput = await queryBusinessesRecordOnce(
                                      queryBuilder: (businessesRecord) => businessesRecord.where(
                                        'email',
                                        isEqualTo: _model.usernameTextController.text,
                                      ),
                                      singleRecord: true,
                                    ).then((s) => s.firstOrNull);
                                    
                                    if (_model.businessOutput?.email != null && 
                                        _model.businessOutput?.email != '') {
                                      context.pushNamedAuth(
                                        BusinessItemPageWidget.routeName, 
                                        context.mounted);
                                    } else {
                                      if (mounted) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(
                                            content: Text('No business account found with this email'),
                                          ),
                                        );
                                      }
                                    }
                                  },
                                  text: 'Login',
                                  options: FFButtonOptions(
                                    width: double.infinity,
                                    height: 50,
                                    color: const Color(0xFF71C0EA),
                                    textStyle: GoogleFonts.inter(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account? ",
                              style: GoogleFonts.inter(
                                color: Colors.grey[700],
                              ),
                            ),
                            GestureDetector(
                              onTap: () => context.pushNamed(BusinessRegisterWidget.routeName),
                              child: Text(
                                'Register',
                                style: GoogleFonts.inter(
                                  color: const Color(0xFF052A7C),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        
                        Text(
                          'Are you a Client?',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            color: Colors.grey[700],
                          ),
                        ),
                        const SizedBox(height: 8),
                        TextButton(
                          onPressed: () async {
                            if (mounted) {
                              await context.pushNamed(LoginPageWidget.routeName);
                            }
                          },
                          child: Text(
                            'Login as Client',
                            style: GoogleFonts.inter(
                              color: const Color(0xFF052A7C),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height * 0.7);
    
    var firstControlPoint = Offset(size.width * 0.25, size.height * 0.85);
    var firstEndPoint = Offset(size.width * 0.5, size.height * 0.7);
    path.quadraticBezierTo(
      firstControlPoint.dx, firstControlPoint.dy,
      firstEndPoint.dx, firstEndPoint.dy,
    );
    
    var secondControlPoint = Offset(size.width * 0.75, size.height * 0.55);
    var secondEndPoint = Offset(size.width, size.height * 0.7);
    path.quadraticBezierTo(
      secondControlPoint.dx, secondControlPoint.dy,
      secondEndPoint.dx, secondEndPoint.dy,
    );
    
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}