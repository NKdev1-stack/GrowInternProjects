import 'package:chit_chat/firebase_options.dart';
import 'package:chit_chat/pages/Home.dart';
import 'package:chit_chat/pages/complete_profile.dart';
import 'package:chit_chat/pages/login_page.dart';
import 'package:chit_chat/pages/signupPage.dart';
import 'package:chit_chat/services/user_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

runApp(MyApp());

}




// Not Logged In Return User to Login Page
class MyApp extends StatelessWidget {
  
   MyApp({super.key});

  // This widget is the root of your application.\
  
  @override
  
  Widget build(BuildContext context) {
  
  
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ChitChat',
        theme: ThemeData(
          // Assigning Custom Font Style to the App text this will affect all the text's in app
          textTheme: GoogleFonts.montserratTextTheme(),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
          useMaterial3: true,
        ),
        home: const usrChecking(),
       );
  }
}

