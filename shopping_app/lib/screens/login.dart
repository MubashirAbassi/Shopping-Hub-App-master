import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/main.dart';
import 'package:shopping_app/models/http_exception.dart';
import 'package:shopping_app/provider/auth.dart';
import 'package:shopping_app/provider/regex_pattern.dart';
import 'package:shopping_app/screens/allproduct_screen.dart';
import 'package:shopping_app/widget/progressdialogue.dart';
import 'package:speech_recognition/speech_recognition.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;




class LoginScreen extends StatefulWidget {
  static const routeName = '/login';
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController =TextEditingController();
  final _passwordController =TextEditingController();
  var _formkey = GlobalKey<FormState>();
  RegExp regexp = new RegExp(RegExPattern.emailRegExPattern);
  bool email=false;
  bool password=false;




  SpeechRecognition _speechRecognition;
  bool _isAvailable = false;
  bool _isListening = false;
  //String resultText = "Search input";
  stt.SpeechToText _speech;
  String _text = 'Press the button and start speaking';
  double _confidence = 1.0;

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    initSpeechRecognizer();
  }


  // @override
  // void initState() {
  //   initSpeechRecognizer();
  //   super.initState();
  //   // print('looking: $userId');
  // }


  void initSpeechRecognizer() {
    _speechRecognition = SpeechRecognition();

    _speechRecognition.setAvailabilityHandler(
          (bool result) => setState(() => _isAvailable = result),
    );

    _speechRecognition.setRecognitionStartedHandler(
          () => setState(() => _isListening = true),
    );
    void onRecognitionResult(String text) {
      setState(() {

        if(email) {
          // _emailController.text = text.replaceAll(" ", "").replaceAll("atrate", "@").replaceAll('attherate', '@').replaceAll('one', '1').replaceAll('two', '2').replaceAll('three', '3').replaceAll('four', '4').replaceAll('for', '4').replaceAll('five', '5').replaceAll('six', '6').replaceAll('sex', '6').replaceAll('seven', '7');

          _text=text;
        }
        else if(password)
          _passwordController.text=text.replaceAll(" ", "").replaceAll("space", " ");
        }
        );
    }

    void onRecognitionComplete() {
      setState(() {
        _isListening = false;
        print(_passwordController.text);
        //   _handleSubmitted(resultText);
      });
    }
    _speechRecognition.setRecognitionResultHandler(onRecognitionResult);
    _speechRecognition.setRecognitionCompleteHandler(onRecognitionComplete);

  }










  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        centerTitle: true,
        title: Text('Login'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Form(
            key: _formkey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 40,
                ),
                /*Padding(
                  padding: EdgeInsets.only(bottom: 70.0),
                  child: Center(
                    child: Text(
                      'Log In',
                      style: TextStyle(fontSize: 35.0),
                    ),
                  ),
                ),*/
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  child: TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    // ignore: missing_return
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Enter the Email';
                      }


                      if (!regexp.hasMatch(value)) {
                        return 'Email format incorrect';
                      }
                    },
                    decoration: InputDecoration(

                      icon: Icon(Icons.email),
                      labelText: 'Email',
                      hintText: 'Enter your Email',
                      contentPadding: EdgeInsets.all(10),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                    ),
                    onChanged: (value) {},
                  ),
                ),

                /*SizedBox(
                  height: ,
                ),*/

                //flat button down the Email for Voice input
                Padding(
                  padding: EdgeInsets.only(left: 20.0,right: 20.0),
                  child: FlatButton(onPressed: () {
                    password=false;
                    _listen();
                    //email=true;
                    // if (  !_isListening) {
                    //   _speechRecognition.listen(
                    //       locale: "en_US"); //.then((result) => resultText=result);
                    // }
                    //email=false;
                  },
                      child: Text("input email",
                          style: TextStyle(fontSize: 18, color: Colors.white)
                      ),
                    color: Colors.deepOrangeAccent,

                  ),
                ),



                SizedBox(
                  height: 40,
                ),

                
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  child: TextFormField(
                    controller: _passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    // ignore: missing_return
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Enter password';
                      }
                      // Use any password length of your choice here
                      if (value.length < 5) {
                        return 'Password length should be atleast 6 Character';
                      }
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                      icon: Icon(FontAwesomeIcons.key),
                      hintText: 'Enter Password',
                      contentPadding: EdgeInsets.all(10),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                    ),
                    onChanged: (value) {},
                  ),
                ),

                SizedBox(
                  height: 10,
                ),

                Padding(
                  padding: EdgeInsets.only(left: 20.0,right: 20.0),
                  child: FlatButton(
                  onPressed: () {
                    email=false;
                    password=true;
                    if (  !_isListening) {
                      _speechRecognition.listen(
                          locale: "en_US"); //.then((result) => resultText=result);
                    }

                   // password=false;
                  },
                  child: Text("input password",
                      style: TextStyle(fontSize: 18, color: Colors.white)
                  ),
                  color: Colors.deepOrangeAccent,
                ),
                ),


                SizedBox(
                  height: 40.0,
                ),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  child: FlatButton(
                    padding: EdgeInsets.all(15),
                    color: Colors.deepOrangeAccent,
                    onPressed: () {

                      _submit();
                      showDialog(context: context,barrierDismissible: false,builder: (context)=>ProgressDialog(status: 'Loading...'),);
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(color: Colors.white, fontSize: 20.0),
                    ),
                  ),
                ),
                /*Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 10.0,
                  ),
                  child: FlatButton(
                    padding: EdgeInsets.all(11),
                    color: Colors.red,
                    onPressed: () {},
                    child: Row(
                      children: [
                        SizedBox(
                          width: 15.0,
                        ),
                        Icon(FontAwesomeIcons.google, color: Colors.white),
                        SizedBox(
                          width: 55.0,
                        ),
                        Text(
                          'Sign in with Google',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ),*/
              ],
            ),
          ),
        ),
      ),
    );
  }
  void _showErrorDialog(String message){
    showDialog(
        context: context,
        builder: (ctx)=>AlertDialog(title: Text('Error Message'),
          content: Text(message),
          actions: <Widget>[
            FlatButton(onPressed: (){
              Navigator.of(context).pop();
            }, child: Text('OKAY'))
          ],)
    );

  }
  Future<void> _submit() async{


    try{
      if(_formkey.currentState.validate()){
        await Provider.of<Auth>(context,listen: false).login(_emailController.text,_passwordController.text);
        Navigator.pushNamedAndRemoveUntil(
          context,
          Allproduct.routeName,
            (route)=>false,
        );
      }
    } on HttpException catch(error){
      var errorMsg='Authentication Failed';
       if(error.toString().contains('INVALID_EMAIL')){
        errorMsg='Invalid email';
      }else if (error.toString().contains('EMAIL_NOT_FOUND')){
        errorMsg='this email dose not exists';
      }else if (error.toString().contains('INVALID_PASSWORD')){
        errorMsg='Invalid password';
      }
      _showErrorDialog(errorMsg);
    }catch(error){
      var errorMsg='Could not authenticate you. Try again later';
      _showErrorDialog(errorMsg);
    }

  }


  void _listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) => setState(() {
            _emailController.text = (val.recognizedWords).replaceAll(" ", "").replaceAll("atrate", "@").replaceAll('attherate', '@').replaceAll('one', '1').replaceAll('two', '2').replaceAll("to", '2').replaceAll('three', '3').replaceAll('four', '4').replaceAll('for', '4').replaceAll('five', '5').replaceAll('six', '6').replaceAll('sex', '6').replaceAll('seven', '7');

          }),
        );
        setState(() {
          _isListening=false;
        });
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }
}
