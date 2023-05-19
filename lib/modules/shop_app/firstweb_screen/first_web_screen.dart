import 'package:ecommerce/shared/components/components.dart';
import 'package:flutter/material.dart';

import '../../../layout/shop_app/shop_layout.dart';
import '../../../shared/network/local/cashe_helper.dart';
import '../login/shop_login_screen.dart';
import '../on_bording/on_bording_screen.dart';

class WebScreen extends StatefulWidget {
  const WebScreen({Key? key}) : super(key: key);

  @override
  State<WebScreen> createState() => _WebScreenState();
}

class _WebScreenState extends State<WebScreen> {
  bool? onBoarding=CasheHelper.getData(key: 'onBoarding');

  String? token=CasheHelper.getData(key: 'token');
   Widget? widgetweb;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        leading:Padding(
          padding: const EdgeInsets.all(2.0),
          child: Image( image: AssetImage('assets/images/logo.png'), ),
        ),
      ) ,
      body: Center(
          child:
          TextButton(onPressed: (){

            if(onBoarding != null){//اذا عديت من ال onboarding
              if(token!=null){widgetweb=ShopLayout();} //وصار معك token روج على شوب لي اوت
              else{ widgetweb=ShopLoginScreen();}//والا روح على ال login
            }else{ widgetweb=OnBordingScreen();}
        setState(() {
          navigateTo(context, widgetweb);
        });

      },
      child:Text("go to shopping") ,)),
    );
  }
}
