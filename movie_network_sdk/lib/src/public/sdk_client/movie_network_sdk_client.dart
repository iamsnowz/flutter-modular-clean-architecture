import 'package:movie_network_sdk/src/core/service_locator/sdk_service_locator.dart';

class MovieNetworkSdkClient { 
  static Future<void> setup() async { 
    await serviceLocator.reset();
    await SdkServiceLocator.initServiceLocator();
  }
}