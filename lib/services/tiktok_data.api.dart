import 'package:http/http.dart' as http;
import 'package:tiktok_downloader/services/titokdata.dart';

Stream<Data> requestData(String url) async* {
// Replace YOUR_API_HOST and YOUR_API_KEY with the actual values
  final headers = {
    "x-rapidapi-host": "tiktok-video-no-watermark2.p.rapidapi.com",
    "x-rapidapi-key": "9adf074ec0msha47b345c9652775p1eae83jsnfa444bf12210"
  };

  final response = await http.get(
      Uri.parse(
          "https://tiktok-video-no-watermark2.p.rapidapi.com/?url=$url&hd=0"),
      headers: headers);

  if (response.statusCode == 200) {
    final tiktokData = tiktokDataFromJson(response.body);
    yield tiktokData.data;
    // You can now access the properties of the "data" class and do whatever you want with them
    
  } else {
    // Handle error case
    throw Exception("Failed to load");

  }
}
