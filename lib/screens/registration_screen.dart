
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../components/round_button.dart';
import '../constants.dart';
import 'chat_screen.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';

  const RegistrationScreen({super.key});

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {

  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  late String email;
  late String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Hero(
                        tag: 'logo',
                        child: SizedBox(
                          height: 200.0,
                          child: Image.asset('images/logo.png'),
                        ),
                      ),
                      const SizedBox(
                        height: 48.0,
                      ),
                      TextField(
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (value) {
                            email = value;
                            print(email);
                          },
                          decoration: kTextFieldDecoration.copyWith(
                            hintText: 'Enter your email',
                          )),
                      const SizedBox(
                        height: 8.0,
                      ),
                      TextField(
                          obscureText: true,
                          textAlign: TextAlign.center,
                          onChanged: (value) {
                            password = value;
                            print(password);
                          },
                          decoration: kTextFieldDecoration.copyWith(
                            hintText: 'Enter your password',
                          )),
                      const SizedBox(
                        height: 24.0,
                      ),
                      RoundButton(
                        text: 'Register',
                        color: Colors.blueAccent, onPressed: () async{

                          setState(() {
                            showSpinner = true;
                          });

                        try{
                          final newUser = await _auth.createUserWithEmailAndPassword(
                              email: email, password: password);
                          print(newUser);
                          print(email);
                          print(password);
                          if(newUser != null)
                          {
                            Navigator.pushNamed(context, ChatScreen.id);
                          }
                          else{
                            print('getting nulllllll value');
                          }
                          setState(() {
                            showSpinner = false;
                          });
                        }
                        catch(e){
                          print(e);
                          print('getting exceptionnnnnnnnnnn');
                        }
                      },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
