import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shopping_app/provider/regex_pattern.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/provider/auth.dart';
import 'package:shopping_app/models/http_exception.dart';
import 'package:shopping_app/screens/allproduct_screen.dart';
import 'package:speech_recognition/speech_recognition.dart';

class SignUpScreen extends StatefulWidget  {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();

}

class _SignUpScreenState extends State<SignUpScreen> {
  final _emailController =TextEditingController();
  final _passwordController =TextEditingController();
  final _confirmpasswordController =TextEditingController();
  final _usernameController =TextEditingController();
  final _addressController =TextEditingController();
  final _phonenumberController =TextEditingController();
  var _formkey = GlobalKey<FormState>();
  RegExp regexp = new RegExp(RegExPattern.emailRegExPattern);
  bool email=false;
  bool password=false;
  bool phonenumber=false;
  bool address = false;
  bool username =false;
  bool repassword =false;




  SpeechRecognition _speechRecognition;
  bool _isAvailable = false;
  bool _isListening = false;
  //String resultText = "Search input";




  @override
  void initState() {
    initSpeechRecognizer();
    super.initState();

  }


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
          _emailController.text = text.replaceAll(" ", "").replaceAll("atrate", "@").replaceAll('attherate', '@').replaceAll('one', '1').replaceAll('two', '2').replaceAll('three', '3').replaceAll('four', '4').replaceAll('for', '4').replaceAll('five', '5').replaceAll('six', '6').replaceAll('sex', '6').replaceAll('seven', '7');

        }
        else if(password) {
          _passwordController.text=text.replaceAll(" ", "").replaceAll("space", " ");
        }
        else if(address) {
          _addressController.text=text;
        }
        else if(username) {
          _usernameController.text=text;
        }
        else if(phonenumber) {
          _phonenumberController.text=text;
        }
      }
      );
    }

    void onRecognitionComplete() {
      setState(() {
        _isListening = false;
       // print(_passwordController.text);
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
        title: Text('Sign Up'),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Form(
            key: _formkey,
            child: Column (
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 40,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  child: TextFormField(
                    controller: _usernameController,
                    keyboardType: TextInputType.emailAddress,
                    // ignore: missing_return
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Enter your UserName';
                      }

                    },
                    decoration: InputDecoration(
                      icon: Icon(Icons.perm_identity_rounded),
                      hintText: 'UserName',
                      contentPadding: EdgeInsets.all(10),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                    ),
                    // onChanged: (value) {},
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.0,right: 20.0),
                  child: FlatButton(
                    onPressed: () {
                      email=false;
                      password=false;
                      address=false;
                      phonenumber=false;
                      username=true;
                      repassword =false;
                      if (  !_isListening) {
                        _speechRecognition.listen(
                            locale: "en_US"); //.then((result) => resultText=result);
                      }
                      // password=false;
                    },
                    child: Text("input Username",
                        style: TextStyle(fontSize: 18, color: Colors.white)
                    ),
                    color: Colors.deepOrangeAccent,
                  ),
                ),








                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  child: TextFormField(
                    controller: _phonenumberController,
                    keyboardType: TextInputType.phone,
                    // ignore: missing_return
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Enter your PhoneNumber';
                      }

                    },
                    decoration: InputDecoration(
                      icon: Icon(Icons.local_phone_outlined),
                      hintText: 'PhoneNumber',
                      contentPadding: EdgeInsets.all(10),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                    ),
                    // onChanged: (value) {},
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.0,right: 20.0),
                  child: FlatButton(
                    onPressed: () {
                      email=false;
                      username=false;
                      password=false;
                      address=false;
                      phonenumber=true;
                      repassword =false;
                      if (  !_isListening) {
                        _speechRecognition.listen(
                            locale: "en_US"); //.then((result) => resultText=result);
                      }
                      // password=false;
                    },
                    child: Text("Enter Contact",
                        style: TextStyle(fontSize: 18, color: Colors.white)
                    ),
                    color: Colors.deepOrangeAccent,
                  ),
                ),









                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  child: TextFormField(
                    controller: _addressController,
                    keyboardType: TextInputType.streetAddress,
                    // ignore: missing_return
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Enter your Address';
                      }

                    },
                    decoration: InputDecoration(
                      icon: Icon(Icons.location_city_outlined),
                      hintText: 'Address',
                      contentPadding: EdgeInsets.all(10),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                    ),
                    // onChanged: (value) {},
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.0,right: 20.0),
                  child: FlatButton(
                    onPressed: () {
                      email=false;
                      password=false;
                      address=true;
                      phonenumber=false;
                      username=false;
                      repassword =false;
                      if (  !_isListening) {
                        _speechRecognition.listen(
                            locale: "en_US"); //.then((result) => resultText=result);
                      }
                      // password=false;
                    },
                    child: Text("Enter address",
                        style: TextStyle(fontSize: 18, color: Colors.white)
                    ),
                    color: Colors.deepOrangeAccent,
                  ),
                ),









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
                        hintText: 'Enter Email',
                        contentPadding: EdgeInsets.all(10),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                      ),
                     // onChanged: (value) {},
                    ),
                  ),
                Padding(
                  padding: EdgeInsets.only(left: 20.0,right: 20.0),
                  child: FlatButton(onPressed: () {
                    email=true;
                    password=false;
                    address=false;
                    phonenumber=false;
                    username=false;
                    repassword =false;
                    if (  !_isListening) {
                      _speechRecognition.listen(
                          locale: "en_US"); //.then((result) => resultText=result);
                    }
                    //email=false;
                  },
                    child: Text("input email",
                        style: TextStyle(fontSize: 18, color: Colors.white)
                    ),
                    color: Colors.deepOrangeAccent,

                  ),
                ),





//password
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
                    //onChanged: (value) {},
                  ),
                ),
//voice input password
                Padding(
                  padding: EdgeInsets.only(left: 20.0,right: 20.0),
                  child: FlatButton(
                    onPressed: () {
                      email=false;
                      password=false;
                      address=false;
                      phonenumber=true;
                      username=false;
                      repassword =false;
                      if (  !_isListening) {
                        _speechRecognition.listen(
                            locale: "en_US"); //.then((result) => resultText=result);
                      }
                      // password=false;
                    },
                    child: Text("Enter password",
                        style: TextStyle(fontSize: 18, color: Colors.white)
                    ),
                    color: Colors.deepOrangeAccent,
                  ),
                ),






//ReEnter password
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  child: TextFormField(
                    controller: _confirmpasswordController,
                    keyboardType: TextInputType.visiblePassword,
                    // ignore: missing_return
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Re-Enter password';
                      }
                      // Use any password length of your choice here
                      if (value.length < 5) {
                        return 'Password length should be atleast 6 Character';
                      }
                      if(value!=_passwordController.text){
                        return "Password not matched";
                      }
                    },
                    obscureText: true,
                    decoration: InputDecoration(
                      icon: Icon(FontAwesomeIcons.key),
                      hintText: 'Re-Enter Password',
                      contentPadding: EdgeInsets.all(10),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                      ),
                    ),
                    //onChanged: (value) {},
                  ),
                ),
                //voice input
                Padding(
                  padding: EdgeInsets.only(left: 20.0,right: 20.0),
                  child: FlatButton(
                    onPressed: () {
                      email=false;
                      password=false;
                      address=false;
                      phonenumber=false;
                      username=false;
                      repassword =true;
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
                  height: 25.0,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  child: FlatButton(
                    padding: EdgeInsets.all(15),
                    color: Colors.deepOrangeAccent,
                    onPressed: ()  {
                      _submit();
                    },
                    child: Text(
                      'Register',
                      style: TextStyle(color: Colors.white, fontSize: 18.0),
                    ),
                  ),
                ),




               // Center(child: Text('or')),
               //  Padding(
               //    padding: EdgeInsets.symmetric(
               //      horizontal: 20.0,
               //      vertical: 10.0,
               //    ),
               //    child: FlatButton(
               //      padding: EdgeInsets.all(11),
               //      color: Colors.red,
               //      onPressed: () {
               //        Authentication.signInWithGoogle(context: context);
               //      },
               //      child: Row(
               //        children: [
               //          SizedBox(
               //            width: 15.0,
               //          ),
               //          Icon(FontAwesomeIcons.google, color: Colors.white),
               //          SizedBox(
               //            width: 55.0,
               //          ),
               //          Text(
               //            'Sign Up with Google',
               //            style: TextStyle(color: Colors.white),
               //          ),
               //        ],
               //      ),
               //    ),
               //  ),
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
        await Provider.of<Auth>(context,listen: false).signup(_emailController.text,_passwordController.text);
        await Provider.of<Auth>(context,listen: false).Upload_data(_usernameController.text, _addressController.text, _phonenumberController.text);
        Navigator.popAndPushNamed(context, Allproduct.routeName);
      }
    } on HttpException catch(error){
      var errorMsg='Authentication Failed';
      if(error.toString().contains('EMAIL_EXISTS')){
        errorMsg='This email address already in use';
      }else if(error.toString().contains('INVALID_EMAIL')){
        errorMsg='Invalid email';
      }else if (error.toString().contains('EMAIL_NOT_FOUND')){
        errorMsg='this email dose not exists';
      }else if(error.toString().contains('WEAK_PASSWORD')){
        errorMsg='weak password';
      }else if (error.toString().contains('INVALID_PASSWORD')){
        errorMsg='Invalid password';
      }
      _showErrorDialog(errorMsg);
    }catch(error){
      var errorMsg='Could not authenticate you. Try again later';
      _showErrorDialog(errorMsg);
    }

  }
}
