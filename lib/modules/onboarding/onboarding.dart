import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:stor/modules/login/login_screan_module.dart';
import 'package:stor/shared/service/local/sheardp_helper.dart';
import 'package:stor/shared/widget/defolte_widget.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({Key? key}) : super(key: key);

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  final PageController boardingControler = PageController();
  bool isLast = false;

  final List<OnBoardingModel> data = [
    OnBoardingModel("assets/images/stor1.png", "View products ",
        "You can browse through the products to see what you like"),
    OnBoardingModel("assets/images/stor2.png", "Choose what you like",
        "Whatever you like you will find inside"),
    OnBoardingModel("assets/images/stor3.png", "Delivery",
        "It will reach you as soon as possible"),
  ];

  void skipOnBoarding() {
    SherdHelper.saveData(key: "onBoarding", value: true).then(
      (value) => navigateaAndFinsh(
        context,
        LoginScreanModule(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: () {
                skipOnBoarding();
              },
              child: const Text("SKIP"))
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            children: [
              Expanded(
                  child: PageView.builder(
                      controller: boardingControler,
                      physics: const BouncingScrollPhysics(),
                      onPageChanged: (int index) {
                        if (index == data.length - 1) {
                          setState(() {
                            isLast = true;
                          });
                        } else {
                          setState(() {
                            isLast = false;
                          });
                        }
                      },
                      itemBuilder: (context, index) =>
                          pageView(context, data[index]),
                      itemCount: data.length)),
              const SizedBox(
                height: 80.0,
              ),
              Row(
                children: [
                  SmoothPageIndicator(
                    controller: boardingControler,
                    count: data.length,
                    effect: const ExpandingDotsEffect(
                      activeDotColor: Color(0xFFE9896A),
                      dotColor: Colors.grey,
                      dotHeight: 10.0,
                      expansionFactor: 4,
                      dotWidth: 10,
                      spacing: 5.0,
                    ),
                  ),
                  const Spacer(),
                  FloatingActionButton(
                    onPressed: () {
                      if (isLast) {
                        skipOnBoarding();
                      } else {
                        boardingControler.nextPage(
                            duration: const Duration(milliseconds: 750),
                            curve: Curves.fastOutSlowIn);
                      }
                    },
                    child: const Icon(
                      Icons.arrow_forward_ios,
                    ),
                  ),
                ],
              )
            ],
          )),
    );
  }

  Widget pageView(context, OnBoardingModel model) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Image(
            image: AssetImage(
              model.image,
            ),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Text(
          model.title,
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 15,
        ),
        Text(
          model.body,
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ],
    );
  }
}

class OnBoardingModel {
  final String image;
  final String title;
  final String body;

  OnBoardingModel(this.image, this.title, this.body);
}
