import 'package:http/http.dart';
import 'package:weatherapp/services/location.dart';

class Networking{
  late String data;
  late double lon, lat;

  getData() async {
    Location location = new Location();
    await location.getLocation();
    lat = location.lat;
    lon = location.lon;


    Uri url = Uri.parse("https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=c462fca2efd39d83d5bd898f448d2900&units=metric");
    Response response = await get(url);
    data = response.body;
    if(response.statusCode == 200){
      return data;
    }else{
      return "Error";
    }
  }
}