import 'package:flutter/material.dart';
import 'package:flutter_projects/ui/screens/lawyer_near_you.dart';
import 'package:introduction_screen/introduction_screen.dart'as my_i_s;

class IntroductionScreen extends StatefulWidget {
  const IntroductionScreen({Key? key}) : super(key: key);

  @override
  State<IntroductionScreen> createState() => _IntroductionScreenState();
}

class _IntroductionScreenState extends State<IntroductionScreen> {
  @override
  Widget build(BuildContext context) {
    List<my_i_s.PageViewModel> pageViewModels = [
      my_i_s.PageViewModel(
        title: "Know the nearest lawyer to you",
        body: "You don't have to walk in streets like you are lost, with us we will reach you to all lawyers around you",
        image: Center(child: Image.asset('assets/images/dalilvisionlogo.png')),
        decoration: const my_i_s.PageDecoration(
          titleTextStyle: TextStyle(color: Colors.orange),
          bodyTextStyle: TextStyle(fontWeight: FontWeight.w700, fontSize: 20.0),
        ),
      ),
      my_i_s.PageViewModel(
        title: "follow your case",
        body: "Follow your case step by step, keeping contact with your lawyer, you don't have to visit your lawyer to get the updates",
        image: Center(child: Image.asset('assets/images/dalilvisionlogo.png')),
        decoration: const my_i_s.PageDecoration(
          titleTextStyle: TextStyle(color: Colors.orange),
          bodyTextStyle: TextStyle(fontWeight: FontWeight.w700, fontSize: 20.0),
        ),
      ),
      my_i_s.PageViewModel(
        title: "privacy and security",
        body: "All your file are safe and your privacy is secrets, all your papers and documents are kept safe",
        image: Center(child: Image.asset('assets/images/dalilvisionlogo.png')),
        decoration: const my_i_s.PageDecoration(
          titleTextStyle: TextStyle(color: Colors.orange),
          bodyTextStyle: TextStyle(fontWeight: FontWeight.w700, fontSize: 20.0),
        ),
      )
    ];

    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          "Welcome to your lawyer advisor",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: Center(
        child: my_i_s.IntroductionScreen(
          pages: pageViewModels,
          onDone: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) => LawyersNearYou(showFAB: true)),
                  (route) => false,
            );
          },
          onSkip: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => LawyersNearYou(showFAB: true)),
                  (route) => false,
            );
          },
          showBackButton: false,
          showSkipButton: true,
          skip: const Icon(Icons.skip_next, color: Colors.amber),
          next: const Icon(Icons.navigate_next, color: Colors.amber),
          done: const Text("Done", style: TextStyle(fontWeight: FontWeight.w600, color: Colors.amber)),
          dotsDecorator: my_i_s.DotsDecorator(
              size: const Size.square(10.0),
              activeSize: const Size(20.0, 10.0),
              activeColor: Colors.amber,
              color: Colors.black26,
              spacing: const EdgeInsets.symmetric(horizontal: 3.0),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0)
              )
          ),
        ),
      ),
    );
  }
}
