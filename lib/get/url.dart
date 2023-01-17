import '../main.dart';

String url = '192.168.1.9:5000';
//String urlStorage = 'https://storage.googleapis.com/asset-management-rania/';

Map<String, String> header = {
  'Content-Type': 'application/json',
  'Accept': 'application/json',
  'Authorization': 'Bearer ${gs.read('token')}',
};

class BaseURL {
  static String baseAPI = 'https://$url/';

  static String login = baseAPI + 'login';

  static String user = baseAPI + 'user';
  static String asset = baseAPI + 'asset';
  static String assetID = baseAPI + 'asset_id';
  static String assetExpires = baseAPI + 'asset_expires';
  static String category = baseAPI + 'category';
  static String image = baseAPI + 'image';

  //local
   static String showImages = baseAPI + 'showImages';

  //google cloud
  //static String showImages = urlStorage;
}