
import 'package:location/location.dart';
import 'package:url_launcher/url_launcher.dart';

class LocationServices{
  sendLocationToDatabase(context)async{
    Location location=new Location();
    bool _servisecEnable;
    PermissionStatus _permissionGranted;
    LocationData _locationData;

    _servisecEnable=await location.serviceEnabled();
    if(!_servisecEnable){
      _servisecEnable=await location.requestService();
        if(!_servisecEnable){
          return;
        }
    }
    _permissionGranted=await location.hasPermission();
    if(_permissionGranted==PermissionStatus.denied){
      _permissionGranted =await location.requestPermission();
        if(_permissionGranted!=PermissionStatus.granted){
          return;
        }
    }

    _locationData=await location.getLocation();
    var latitude=_locationData.latitude;
    var longitude=_locationData.longitude;
    print("latitude:$latitude");
    print("longitude:$longitude");
    return _locationData;
  }
  goToMaps(double latitude,double  longitude)async{

    String mapLocationUrl(){
      return  "https://www.google.com/maps/search/?api=1&query=$latitude,$longitude";}
       String encodedUrl=Uri.encodeFull(mapLocationUrl());

      if(await canLaunchUrl(encodedUrl as Uri)){
        await launch(encodedUrl);

      }else{
        print('could not launch $encodedUrl');
        throw 'could not launch $encodedUrl';
      }


  }
  funMap({required double latitude,required double  longitude})async{

    String url(){
      // if(Platform.isIOS)
      //   return "";
      // else{
      // }
      return  "https://www.google.com/maps/search/?api=1&query=$latitude,$longitude";
      //flutter run -d chrome --web-renderer html

      //"whatsapp://send?phone=$phone&text=$message";
    }
    await launch(url());//canLaunch(url()) ? launch(url()) :ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("there is noo whatsapp in your device ")));

  }




}