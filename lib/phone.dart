import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sms_autofill/sms_autofill.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());

}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PhoneAuthScreen(),
    );
  }
}

class PhoneAuthScreen extends StatefulWidget {
  @override
  _PhoneAuthScreenState createState() => _PhoneAuthScreenState();
}

class _PhoneAuthScreenState extends State<PhoneAuthScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneNumberController = TextEditingController();
  String? verificationId;

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp();
  }

  Future<void> _verifyPhone() async {
    String phoneNumber = "+1${_phoneNumberController.text}"; // Modify as needed

    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (PhoneAuthCredential credential) {
        // Auto-retrieve the SMS code if possible
        _auth.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        print(e.message);
      },
      codeSent: (String? verificationId, int? resendToken) {
        setState(() {
          this.verificationId = verificationId;
        });
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        setState(() {
          this.verificationId = verificationId;
        });
      },
      timeout: Duration(seconds: 120),
      forceResendingToken: int.parse(SmsAutoFill().getAppSignature.toString()),
    );
  }

  void _signInWithPhoneNumber(String smsCode) async {
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId!,
        smsCode: smsCode,
      );
      UserCredential authResult = await _auth.signInWithCredential(credential);
      User? user = authResult.user;

      if (user != null) {
        print("Phone number verified: ${user.phoneNumber}");
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Phone Authentication'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _phoneNumberController,
                decoration: InputDecoration(labelText: 'Phone Number'),
                keyboardType: TextInputType.phone,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a valid phone number';
                  }
                  return null;
                },
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _verifyPhone();
                  }
                },
                child: Text('Send Verification Code'),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'SMS Code'),
                keyboardType: TextInputType.number,
                onChanged: (smsCode) {
                  if (smsCode.length == 6) {
                    _signInWithPhoneNumber(smsCode);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}