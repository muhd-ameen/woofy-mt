import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:lylac/constanats/const.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CarouselSl extends StatefulWidget {
  const CarouselSl({Key key}) : super(key: key);

  @override
  _CarouselSlState createState() => _CarouselSlState();
}

class _CarouselSlState extends State<CarouselSl> {
  final urlImages = [
    'assets/images/hcc-1.png',
    'assets/images/hcc-1.png',
    'assets/images/hcc-1.png',
    // 'https://helpx.adobe.com/content/dam/help/en/photoshop/using/convert-color-image-black-white/jcr_content/main-pars/before_and_after/image-before/Landscape-Color.jpg',
  ];

  int activeIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          CarouselSlider.builder(
              itemCount: urlImages.length,
              options: CarouselOptions(
                viewportFraction: 1,
                aspectRatio: 17 / 9,
                enableInfiniteScroll: false,
                onPageChanged: (index, reason) {
                  setState(() {
                    activeIndex = index;
                  });
                },
              ),
              itemBuilder: (context, index, realIndex) {
                final urlImage = urlImages[index];
                return buildImage(urlImage, index);
              }),
          SizedBox(height: 5),
          buildIndicator(),
        ],
      ),
    );
  }

  Widget buildImage(String urlImage, int index) => Container(
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.grey,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          gradient: LinearGradient(
              colors: [
                const Color(0xFFFF9F06),
                const Color(0xFFFFE1B4),
              ],
              begin: const FractionalOffset(0.0, 0.0),
              end: const FractionalOffset(1.0, 0.0),
              stops: [0.0, 1.0],
              tileMode: TileMode.clamp),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          child: Stack(
            children: [
              Positioned(
                bottom: 12,
                right: 0,
                height: 135,
                child: Image.asset(
                  urlImage,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                  left: 25,
                  top: 25,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.asset(
                        'assets/images/logo-1.png',
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Text(
                        'Flash Offer',
                        style: TextStyle(
                          fontFamily: 'Montserrat',
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: 18.0,
                        ),
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Text(
                        'We are here with the best \ndeserts intown.',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                          fontSize: 11.0,
                        ),
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      Row(
                        children: [
                          Text(
                            'Order',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 14.0,
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: Colors.white,
                            size: 17,
                          )
                        ],
                      )
                    ],
                  )),
            ],
          ),
        ),
      );

  Widget buildIndicator() => AnimatedSmoothIndicator(
        activeIndex: activeIndex,
        count: urlImages.length,
        effect: WormEffect(
          dotHeight: 12,
          dotWidth: 12,
          dotColor: Color(0xFFE2E2E2),
          activeDotColor: kThemeColor,
        ),
      );
}
