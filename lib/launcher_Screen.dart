import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:word_hurdle_project/word_hurdle_page.dart';
import 'package:lottie/lottie.dart';

class LauncherScreen extends StatefulWidget {
  static const String routeName = "/";
  const LauncherScreen({super.key});

  @override
  State<LauncherScreen> createState() => _LauncherScreenState();
}

class _LauncherScreenState extends State<LauncherScreen> {
  /*@override
  void initState() {
    Future.delayed(Duration(seconds: 4),(){
      Navigator.pushReplacementNamed(context, WordHurdlePage.routeName);
    });
    super.initState();
  }*/
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:const BoxDecoration(
          gradient: LinearGradient(
              begin:Alignment.topLeft,
              end:Alignment.bottomRight,
              colors:[
                Colors.cyan,
                Colors.white
              ]
          )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("images/splashScreen.png"),
              ElevatedButton(
                  onPressed: (){
                    //Lottie.network("https://lottie.host/32c3f3bd-58fd-4565-9d7d-94ed9ee24b37/QwidAP0MCF.json", height: 100);
                    Future.delayed(Duration(seconds: 3),(){
                      Navigator.pushReplacementNamed(context, WordHurdlePage.routeName);
                      EasyLoading.dismiss();
                    });
                    EasyLoading.show();
                  },

                  child: Text("Start"),

              ),
            ],
          ),
        ),
      ),
    );
  }
}
