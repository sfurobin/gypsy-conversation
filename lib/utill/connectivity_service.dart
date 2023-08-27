
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityService{
  Future<bool> checkInternetConnectivity()async{
    var connectivityResult = await Connectivity().checkConnectivity();
    if(connectivityResult == ConnectivityResult.none){
      return false;
    }else if(connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi){
      return true;
    }
    return false;
  }
}