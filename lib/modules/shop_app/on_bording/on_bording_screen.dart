
import 'package:ecommerce/modules/shop_app/login/shop_login_screen.dart';
import 'package:ecommerce/shared/components/components.dart';
import 'package:ecommerce/shared/network/local/cashe_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../shared/styles/colors.dart';

//بما انة ال pageView.builder بدو اكتر من صورة ونص
//اذا كانت الشغلة صغيرة وش محتاجة bloc فمنعمل statefull متل الانتقال الى الشاشة التالة الى النهاءية
class BoardingModil{
  late final String image;
  late final String title;
  late final String body;
  BoardingModil({
    required this.image,
    required this.title,
    required this.body
});
}
class OnBordingScreen extends StatefulWidget {
  @override
  State<OnBordingScreen> createState() => _OnBordingScreenState();
}

class _OnBordingScreenState extends State<OnBordingScreen> {
//المونترولر للودجت بتيح التخكم بالوجت من مكان تانب
var boardControler=PageController();
bool isLast=false;
void submit(){  //لتفادي جعل ال onBoarding  تظهر عند كل تشغيل

CasheHelper.saveData(//لتفادي جعل ال onBoarding  تظهر عند كل تشغيل
      key: 'onBoarding',
      value: true).then((value) {
    if(value!){
      navigateAndFinish(context, ShopLoginScreen());

    }
  });
  navigateAndFinish(
      context,
      ShopLoginScreen()
  );

}
  @override
  Widget build(BuildContext context) {
    List<BoardingModil> boarding=[
      BoardingModil(
         image: 'assets/images/onboard_1.png',
        title: 'this new market app',
        body: 'from our company',
      ),
      BoardingModil(
        image: 'assets/images/onbor2.png',
        title: 'Computer Engineer field',
        body: 'Software engineer',
      ),
      BoardingModil(
        image: 'assets/images/onbor7.png',
        title: 'shop all products now from our app',
        body: 'It Engineer app ',
      ),
    ];

    return Scaffold(
      appBar: AppBar(
    actions: [
      defaultTextButton(
          function:submit,//هون
          text: 'Skip'),

    ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(//تقليب
                onPageChanged: (int index){
                  //وصلنا لاخر صفحة
                  if(index==boarding.length-1) {
                    setState(() {
                      isLast=true;
                    });
                  }else{
                    setState(() {
                      isLast=false;
                    });
                  }
                },
                physics: BouncingScrollPhysics(),
                controller: boardControler,
                itemBuilder: (context,index)=>buildBoardingItem(boarding[index]),
              itemCount: boarding.length,),
            ),
            SizedBox(
              height: 40.0,
            ),
            Row(
              children: [
               SmoothPageIndicator(//ال3 نقاط
                   controller: boardControler,
                   count: boarding.length,
               effect: ExpandingDotsEffect(
                 dotColor: Colors.grey,
                 activeDotColor: defaultColor,
                 dotHeight: 10,
                 expansionFactor: 4,
                 dotWidth: 10,
                 spacing: 5.0,

               ),
               ),
                Spacer(),//بياخد كل المسافة القاضية بالنص
                FloatingActionButton(
                    onPressed: (){
                      if(isLast){
                        //navigateAndFinish لان مش عايز ادوس باك عايز الغي يلي فات

                       //here
                        submit();
                             }
                      else{
                        boardControler.nextPage(
                            duration: Duration(
                              milliseconds: 750,
                            ),
                            curve: Curves.fastLinearToSlowEaseIn//شكل التنقل
                        );
                      }
                    },
                child: Icon(Icons.arrow_forward_ios),)
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModil modil)=>Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
          child: Image(image:AssetImage('${modil.image}') )),
      SizedBox(
        height: 30.0,
      ),
      Text(
        '${modil.title}',
        style: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(
        height: 15.0,
      ),
      Text(
        '${modil.body}',
        style: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(
        height: 30.0,
      ),
    ],
  );
}
