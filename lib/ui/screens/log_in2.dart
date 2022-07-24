// import 'package:flutter/material.dart';
// import 'package:flutter_projects/ui/screens/cookie_list.dart';
// import 'package:flutter_projects/ui/screens/user_type.dart';
// import 'package:flutter_projects/viewModels/cookie_lawyer_viewModel.dart';
//
// import 'lawyer_near_you.dart';
//
// class LogIn2 extends StatefulWidget {
//   const LogIn2({Key? key}) : super(key: key);
//
//   @override
//   State<LogIn2> createState() => _LogIn2State();
// }
//
// class _LogIn2State extends State<LogIn2> {
//
//   TextEditingController emailController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//
//   bool isNotClickAble = false;
//
//   @override
//   void initState() {
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: const BoxDecoration(
//         image: DecorationImage(
//             image: AssetImage('assets/images/dalilvisionlogo.png'), fit: BoxFit.contain),
//       ),
//       child: Scaffold(
//         backgroundColor: Colors.transparent,
//         body: AbsorbPointer(
//           absorbing: isNotClickAble,
//           child: Stack(
//               children: [
//                 Container(
//                   padding: const EdgeInsets.only(left: 35, top: 80),
//                   child: const Text(
//                     "Welcome\nBack",
//                     style: TextStyle(color: Colors.white, fontSize: 33),
//                   ),
//                 ),
//                 SingleChildScrollView(
//                   child: Container(
//                     padding: EdgeInsets.only(
//                         right: 35,
//                         left: 35,
//                         top: MediaQuery.of(context).size.height * 0.5),
//                     child: Column(
//                         children: [
//                           TextField(
//                             controller: emailController,
//                             decoration: InputDecoration(
//                               fillColor: Colors.grey.shade100,
//                               filled: true,
//                               hintText: 'Email',
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                             ),
//                           ),
//                           const SizedBox(height: 30),
//                           TextField(
//                             obscureText: true,
//                             controller: passwordController,
//                             decoration: InputDecoration(
//                               fillColor: Colors.grey.shade100,
//                               filled: true,
//                               hintText: 'Password',
//                               border: OutlineInputBorder(
//                                 borderRadius: BorderRadius.circular(10),
//                               ),
//                             ),
//                           ),
//                           const SizedBox(height: 40),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               TextButton(
//                                 onPressed: () {
//
//                                 },
//                                 child: const Text(
//                                   'Forgot Password',
//                                   style: TextStyle(
//                                     fontSize: 18,
//                                     color: Colors.white,
//                                   ),
//                                 ),
//                               ),
//                               CircleAvatar(
//                                 radius: 30,
//                                 backgroundColor: const Color(0xff4c505b),
//                                 child: IconButton(
//                                   color: Colors.white,
//                                   onPressed: () {
//                                     Navigator.push(
//                                       context,
//                                       MaterialPageRoute(builder: (context) => UserType(title: 'title')),
//                                     );
//                                     setState((){isNotClickAble = true;});
//                                     // final snackBar = SnackBar(
//                                     //   content: Row(
//                                     //     children: const [
//                                     //       CircularProgressIndicator(),
//                                     //       SizedBox(width: 20,),
//                                     //       Text('Signing in'),
//                                     //     ],
//                                     //   ),
//                                     //   duration: const Duration(seconds: 20),
//                                     //   action: SnackBarAction(
//                                     //     label: 'Dismiss',
//                                     //     onPressed: () {
//                                     //       setState((){isNotClickAble = false;});
//                                     //     },
//                                     //   ),
//                                     // );
//                                     // ScaffoldMessenger.of(context).showSnackBar(snackBar);
//                                     CookieLawyerApiServices cookieApi = CookieLawyerApiServices();
//                                     cookieApi.getLawyers(email: emailController.text,
//                                         password: passwordController.text).then((value) {
//                                       Navigator.push(context,
//                                           MaterialPageRoute(builder: (context) => CookiesList(cookiesList: value)));
//                                       ScaffoldMessenger.of(context).hideCurrentSnackBar();
//                                     }).catchError((onError) {
//                                       final snackBar = SnackBar(
//                                         content: Text('$onError'),
//                                         duration: const Duration(seconds: 20),
//                                         action: SnackBarAction(
//                                           label: 'Dismiss',
//                                           onPressed: () {
//                                             isNotClickAble = false;
//                                           },
//                                         ),
//                                       );
//                                       setState((){isNotClickAble = false;});
//                                       // ScaffoldMessenger.of(context).showSnackBar(snackBar);
//                                     });
//                                   },
//                                   icon: const Icon(Icons.arrow_forward),
//                                 ),
//                               ),
//                             ],
//                           ),
//                           const SizedBox(
//                             height: 10,
//                           ),
//                           Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 TextButton(
//                                   onPressed: () {
//
//                                   },
//                                   child: const Text(
//                                     'Sign Up',
//                                     style: TextStyle(
//                                       fontSize: 18,
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                                 ),
//                                 TextButton(
//                                   onPressed: () {
//                                     Navigator.of(context).push(_lawyersNearYouRoute());
//                                   },
//                                   child: const Text(
//                                     'Log in as guest',
//                                     style: TextStyle(
//                                       fontSize: 18,
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                                 )
//                               ]),
//                         ]),
//                   ),
//                 ),
//               ]),
//         ),
//       ),
//     );
//   }
//
//   Route _lawyersNearYouRoute() {
//     return PageRouteBuilder(
//       pageBuilder: (context, animation, secondaryAnimation) => LawyersNearYou(showFAB: true),
//       transitionsBuilder: (context, animation, secondaryAnimation, child) {
//         const begin = Offset(0.0, 1.0);
//         const end = Offset.zero;
//         const curve = Curves.ease;
//         var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
//         return SlideTransition(
//           position: animation.drive(tween),
//           child: child,
//         );
//       },
//     );
//   }
// }