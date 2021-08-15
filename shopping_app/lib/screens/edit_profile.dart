import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/provider/auth.dart';
import 'package:speech_recognition/speech_recognition.dart';


class EditProfile extends StatefulWidget {
  static const routeName = '/editprofile';
  @override
  _EditProfileState createState() => _EditProfileState();
}



class _EditProfileState extends State<EditProfile> {

  final _addressController = TextEditingController();
  final _usernameController = TextEditingController();
  final _phonenumberController = TextEditingController();
  var _formkey = GlobalKey<FormState>();
  bool phonenumber=false;
  bool address = false;
  bool username =false;



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
        if(address) {
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
        title: Text("Edit Profile"),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Column(
            children: [
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
                    address=false;
                    phonenumber=false;
                    username=true;

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
                    username=false;
                    address=false;
                    phonenumber=true;

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
                    address=true;
                    phonenumber=false;
                    username=false;
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






              SizedBox(
                height: 10.0,
              ),
              FlatButton(
                padding: EdgeInsets.only(left: 150.0, right: 150.0),

                color: Colors.deepOrangeAccent,
                onPressed: ()  {
                  _submit();
                },
                child: Text(
                  'Update Profile',
                  style: TextStyle(color: Colors.white, fontSize: 16.0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _submit() async{
    if(_formkey.currentState.validate()){
      Provider.of<Auth>(context,listen: false).update(_usernameController.text,_addressController.text,_phonenumberController.text);
      _phonenumberController.text="";
      _addressController.text="";
      _usernameController.text="";
    }
  }
}
