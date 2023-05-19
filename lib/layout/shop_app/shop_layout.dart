

import 'package:ecommerce/layout/shop_app/cubit/cubit.dart';
import 'package:ecommerce/layout/shop_app/cubit/states.dart';
import 'package:ecommerce/modules/shop_app/search/search_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../shared/components/components.dart';
import '../../shared/network/locations_services.dart';


class ShopLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit,ShopStates>(
      listener: (context,state){},
      builder: (context,state){
        var cubit=ShopCubit.get(context);
        LocationServices locationServices=LocationServices();
        double _latitude=37.4219983;//الطول و الغرض
        double _longitude=-122.084;
        return  Scaffold(
          appBar: AppBar(
            elevation: 0.5,

            leading: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Image( image: AssetImage('assets/images/logo.png'), ),
            ),
             title:MediaQuery.of(context).size.width.toInt() >= 560?BottomNavigationBar(
                 onTap: (index){
                   cubit.changeBottom(index);
                 },
                 currentIndex: cubit.currentIndex,
                 items: [
                   BottomNavigationBarItem(
                       icon: Icon(Icons.home,
                       ),
                       label: 'Home'),
                   BottomNavigationBarItem(
                       icon: Icon(Icons.apps,
                       ),
                       label: 'Categories'),
                   BottomNavigationBarItem(
                       icon: Icon(Icons.favorite,
                       ),
                       label: 'Favorites'),
                   BottomNavigationBarItem(
                       icon: Icon(Icons.settings,
                       ),
                       label: 'Settings')
                 ]) :const Text('Noor Market ',style: TextStyle(
               color: Colors.black87,
             ),) ,


            actions: [
              IconButton(
                  onPressed:(){
                   // locationServices.sendLocationToDatabase(context);
                   //locationServices.goToMaps(_latitude, _longitude);
                locationServices.funMap(latitude: _latitude, longitude: _longitude);
                  } ,
                  icon: Icon(Icons.location_on)),
              IconButton(
                  onPressed:(){
                    navigateTo(context, SearchScreen());
                  } ,
                  icon: Icon(Icons.search)),

            ],
          ),
          body:cubit.bottomScreen[cubit.currentIndex] ,

          bottomNavigationBar:MediaQuery.of(context).size.width.toInt() <= 560? BottomNavigationBar(
            onTap: (index){
              cubit.changeBottom(index);
            },
              currentIndex: cubit.currentIndex,
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home,
                    ),
                label: 'Home'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.apps,
                    ),
                    label: 'Categories'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.favorite,
                    ),
                    label: 'Favorites'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.settings,
                    ),
                    label: 'Settings')
              ]) : null,
        );
      },
    );
  }
}
