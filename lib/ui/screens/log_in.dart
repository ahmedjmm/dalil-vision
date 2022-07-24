import 'package:flutter/material.dart';
import 'package:flutter_projects/ui/screens/user_type.dart';

class LogIn extends StatefulWidget {
  const LogIn({Key? key}) : super(key: key);

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  bool? _isRememberMeChecked = true;
  final _emailTextFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          title: const Text('Log in', style: TextStyle(color: Colors.black)),
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
                  children: <Widget>[
                    _emailTextField(),
                    _passwordTextField(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _rememberMeWidget(),
                          _logInButton(),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


  @override
  void dispose() {
    _emailTextFieldController.dispose();
    super.dispose();
  }

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
      padding: const EdgeInsets.only(left: 8, right: 8),
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

  _emailTextField() => Padding(
      padding: const EdgeInsets.only(bottom: 15, left: 8, right: 8),
      child: SizedBox(
        height: 60,
        width: MediaQuery.of(context).size.width,
        child: TextFormField(style: const TextStyle(color: Colors.black,),
          controller: _emailTextFieldController,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: 'Your email',
            labelStyle: const TextStyle(color: Colors.black),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.black, width: 2.0),
              borderRadius: BorderRadius.circular(25.0),
            ),
          ),
        ),
      ),
    );

  _logInButton() =>  CircleAvatar(
      radius: 30,
      backgroundColor: Colors.black,
      child: IconButton(
        color: Colors.yellowAccent,
        icon: const Icon(Icons.arrow_forward),
        onPressed: () {
          if(_emailTextFieldController.text == 'user'){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => UserType(title: 'title', type: _emailTextFieldController.text)),
            );
            return;
          }
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => UserType(title: 'title', type: _emailTextFieldController.text)),
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
}
