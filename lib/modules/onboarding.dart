import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:makeprice/components/components.dart';
import 'package:makeprice/layout/layout.dart';
import 'package:makeprice/models/borading.dart';
import 'package:makeprice/modules/splash.dart';
import 'package:makeprice/shared/local.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  PageController page = PageController();
  bool last = false;
  List<Boarding> board = [
    Boarding(
        icon: Icons.upload_file,
        title: "Export & Share",
        text:
            "Easily share single item or\nexport the whole list in XLSX or PDF file "),
    Boarding(
        icon: Icons.qr_code,
        title: "Built-in Scanner",
        text:
            "uUse Barcode Scanner while making list\nhelps in search items quickly"),
    Boarding(
        icon: Icons.wifi_off,
        title: "Works Offline",
        text:
            "Make your list offline\nno matter if internet is available or not"),
    Boarding(
        icon: Icons.list,
        title: "Make Price List",
        text:
            "A simple and free solution to maintain list\nfor product sales and marketing")
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
            child: PageView.builder(
              onPageChanged: (i) {
                if (i == 3) {
                  setState(() {
                    last = true;
                  });
                }
              },
              controller: page,
              itemBuilder: (context, index) => onBoarding(
                  icon: board[index].icon,
                  title: board[index].title,
                  text: board[index].text),
              itemCount: board.length,
            ),
          ),
          Container(
            color: Colors.grey,
            width: double.infinity,
            height: 60,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: () {
                        if (last) {
                          CacheHelper.setBool(key: "onBoard", value: true);
                          pushReplacement(context: context, widget: Splash());
                          print(last);
                        }
                        page.nextPage(
                            duration: const Duration(milliseconds: 600),
                            curve: Curves.fastLinearToSlowEaseIn);
                      },
                      child: const Text(
                        "Next",
                        style: TextStyle(color: Colors.black),
                      )),
                  SmoothPageIndicator(
                    effect: const WormEffect(
                        dotColor: Color.fromARGB(255, 105, 105, 105),
                        dotHeight: 7,
                        dotWidth: 7,
                        radius: 20,
                        type: WormType.normal,
                        activeDotColor: Colors.black,
                        spacing: 8),
                    controller: page,
                    count: board.length,
                    axisDirection: Axis.horizontal,
                  ),
                  TextButton(
                      onPressed: () {
                        CacheHelper.setBool(key: "onBoard", value: true);
                        pushReplacement(context: context, widget: Layout());
                      },
                      child: const Text(
                        "Skip",
                        style: TextStyle(color: Colors.black),
                      )),
                ],
              ),
            ),
          )
        ],
      )),
    );
  }
}
