import 'package:dropdown_button2/custom_dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_projects/ui/screens/user_type.dart';
import 'package:flutter_projects/ui/widgets/profile_widget.dart';
import 'package:image_picker/image_picker.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

enum SingingCharacter { lafayette, jefferson }

class _SignUpState extends State<SignUp> {
  SingingCharacter? _character = SingingCharacter.lafayette;
  bool? _isRememberMeChecked = true;
  late Widget _animatedSwitcherChild;
  final List<String> items = [
    'Consultant',
    'Lawyer',
    'Accountant',
    'Secretary',
    'Item5',
    'Item6',
    'Item7',
    'Item8',
  ];
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          title: const Text('Sign up', style: TextStyle(color: Colors.black)),
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.transparent,
          elevation: 0
      ),
      body: AbsorbPointer(
          absorbing: false,
          child: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [Colors.amber, Colors.yellowAccent]),
            ),
            child: Center(
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  Column(
                    children: [
                      ProfileWidget(
                        imagePath: 'https://dalilvision.com/wp-content/uploads/listing-uploads/logo/2022/06/alnuami-2.jpg',
                        onClicked: () async {
                          final image = await ImagePicker()
                              .pickImage(source: ImageSource.gallery);
                        },
                      ),
                      ListTile(
                        horizontalTitleGap: 0,
                        title: const Text('Legal'),
                        leading: Radio<SingingCharacter>(
                          activeColor: Colors.black,
                          value: SingingCharacter.lafayette,
                          groupValue: _character,
                          onChanged: (SingingCharacter? value) {
                            setState(() {
                              _character = value;
                              print('radio button: ${_character!.index}');
                            });
                          },
                        ),
                      ),
                      AnimatedSwitcher(
                        duration: const Duration(milliseconds: 200),
                        child: _character!.index == 0 ?  _dropDownList(): null,
                        transitionBuilder: (child, animation) {
                          return SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(0.0, 0.2),
                              end: Offset.zero,
                            ).animate(animation),
                            child: child,
                          );
                        },
                      ),
                      ListTile(
                        horizontalTitleGap: 0,
                        title: const Text('User'),
                        leading: Radio<SingingCharacter>(
                          activeColor: Colors.black,
                          value: SingingCharacter.jefferson,
                          groupValue: _character,
                          onChanged: (SingingCharacter? value) {
                            setState(() {
                              _character = value;
                              print('radio button: ${_character!.index}');
                            });
                          },
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(right: 15, left: 15, bottom: 15),
                        child: Divider(color: Colors.black),
                      ),
                      _nameTextField(),
                      _mobileTextField(),
                      _nationalityTextField(),
                      _emailTextField(),
                      _passwordTextField(),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _rememberMeWidget(),
                            _signUpButton(),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
      ),
    );
  }

  _dropDownList() => Padding(
      padding: const EdgeInsets.only(left: 50),
      child: CustomDropdownButton2(
        buttonWidth: 300,
          dropdownWidth: 300,
          hint: 'Your position',
          dropdownItems: items,
          value: selectedValue,
          onChanged: (value) {
            setState(() {
              selectedValue = value;
            });
          },
      ),
    );

  _rememberMeWidget() => Padding(
      padding: const EdgeInsets.only(top: 30, left: 30),
      child: Container(
        alignment: Alignment.topRight,
        height: 20,
        child: Row(
          children: <Widget>[
            const Text(
              'Remember me',
              style: TextStyle(
                fontSize: 12,
                color: Colors.black,
              ),
            ),
            Checkbox(
                fillColor: MaterialStateProperty.resolveWith<Color>((states) {
                  return Colors.black;
                }),
                value: _isRememberMeChecked,
                checkColor: Colors.yellowAccent,
                onChanged: (onChanged) {
                  setState((){
                    _isRememberMeChecked = onChanged;
                  });
                }
            )
          ],
        ),
      ),
    );

  _passwordTextField() => Padding(
      padding: const EdgeInsets.only(left: 50, right: 8),
      child: SizedBox(
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: TextFormField(style: const TextStyle(color: Colors.black,),
          cursorColor: Colors.black,
          obscureText: true,
          decoration:  InputDecoration(
            border: const OutlineInputBorder(),
            labelText: 'Password',
            labelStyle: const TextStyle(color: Colors.black),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black, width: 2.0),
              borderRadius: BorderRadius.circular(25.0),
            ),
          ),
        ),
      ),
    );

  _mobileTextField() => Padding(
      padding: const EdgeInsets.only(bottom: 15, left: 50, right: 8),
      child: SizedBox(
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: TextFormField(style: const TextStyle(color: Colors.black,),
          cursorColor: Colors.black,
          obscureText: true,
          keyboardType: TextInputType.phone,
          decoration:  InputDecoration(
            border: const OutlineInputBorder(),
            labelText: 'Mobile',
            labelStyle: const TextStyle(color: Colors.black),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black, width: 2.0),
              borderRadius: BorderRadius.circular(25.0),
            ),
          ),
        ),
      ),
    );

  _emailTextField() => Padding(
      padding: const EdgeInsets.only(bottom: 15, left: 50, right: 8),
      child: SizedBox(
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: TextFormField(style: const TextStyle(color: Colors.black,),
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: 'Email',
            labelStyle: const TextStyle(color: Colors.black),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black, width: 2.0),
              borderRadius: BorderRadius.circular(25.0),
            ),
          ),
        ),
      ),
    );

  _nationalityTextField() => Padding(
      padding: const EdgeInsets.only(bottom: 15, left: 50, right: 8),
      child: SizedBox(
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: TextFormField(style: const TextStyle(color: Colors.black,),
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: 'Nationality',
            labelStyle: const TextStyle(color: Colors.black),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black, width: 2.0),
              borderRadius: BorderRadius.circular(25.0),
            ),
          ),
        ),
      ),
    );

  _signUpButton() => CircleAvatar(
      radius: 30,
      backgroundColor: Colors.black,
      child: IconButton(
        icon: const Icon(Icons.arrow_forward, color: Colors.yellowAccent,),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => UserType(title: 'title', type: 'user')),
          );
          // setState((){isNotClickAble = true;});
          // final snackBar = SnackBar(
          //   content: Row(
          //     children: const [
          //       CircularProgressIndicator(),
          //       SizedBox(width: 20,),
          //       Text('Signing in'),
          //     ],
          //   ),
          //   duration: const Duration(seconds: 20),
          //   action: SnackBarAction(
          //     label: 'Dismiss',
          //     onPressed: () {
          //       setState((){isNotClickAble = false;});
          //     },
          //   ),
          // );
          // ScaffoldMessenger.of(context).showSnackBar(snackBar);
          // CookieLawyerApiServices cookieApi = CookieLawyerApiServices();
          // cookieApi.getLawyers(email: emailController.text,
          //     password: passwordController.text).then((value) {
          //   Navigator.push(context,
          //       MaterialPageRoute(builder: (context) => CookiesList(cookiesList: value)));
          //   ScaffoldMessenger.of(context).hideCurrentSnackBar();
          // }).catchError((onError) {
          //   final snackBar = SnackBar(
          //     content: Text('$onError'),
          //     duration: const Duration(seconds: 20),
          //     action: SnackBarAction(
          //       label: 'Dismiss',
          //       onPressed: () {
          //         isNotClickAble = false;
          //       },
          //     ),
          //   );
          //   setState((){isNotClickAble = false;});
          //   // ScaffoldMessenger.of(context).showSnackBar(snackBar);
          // });
        },
      ),
    );

  _nameTextField() => Padding(
      padding: const EdgeInsets.only(bottom: 15, left: 50, right: 8),
      child: SizedBox(
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: TextFormField(
          style: const TextStyle(
              color: Colors.black
          ),
          decoration: InputDecoration(
            labelText: 'Name',
            labelStyle: const TextStyle(color: Colors.black),
            border: const OutlineInputBorder(),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black, width: 2.0),
              borderRadius: BorderRadius.circular(25.0),
            ),
          ),
        ),
      ),
    );
}