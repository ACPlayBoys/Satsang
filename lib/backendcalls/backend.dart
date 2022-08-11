import 'dart:developer';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:restappintern/model/channel.dart';
import 'package:restappintern/model/videos.dart';

class Backend {
  static final url = "www.googleapis.com";
  static final api = "AIzaSyCffaZVnUp2Nw-DY05oSefdwMQCyBmrCTA";
  static Future<UserAccount> getChannelData(channelId) async {
    Map<String, dynamic> parameters = {
      "part": "snippet,contentDetails,statistics",
      "id": channelId,
      "key": api
    };
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: "application/json"
    };
    Uri uri = Uri.https(url, "/youtube/v3/channels", parameters);
    http.Response res = await http.get(uri, headers: headers);
    return (userAccountFromJson(res.body));
  }

  static Future<VideoList> getVideos(pagetoken,[playlistid="PUYuc9opLVj3wi3SoDvgDeoA"]) async {
    Map<String, dynamic> parameters = {
      "part": "snippet",
      "playlistId": playlistid,
      "maxResults": "8",
      "pageToken": pagetoken,
      "key": api
    };
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: "application/json"
    };
    Uri uri = Uri.https(url, "/youtube/v3/playlistItems", parameters);
    http.Response res = await http.get(uri, headers: headers);
    return VideoList.fromRawJson(res.body);
  }

static Future<VideoItem> getSingleVideo(pagetoken,[playlistid="PUYuc9opLVj3wi3SoDvgDeoA"]) async {
    Map<String, dynamic> parameters = {
      "part": "snippet",
      "playlistId": playlistid,
      "maxResults": "1",
      "pageToken": pagetoken,
      "key": api
    };
    Map<String, String> headers = {
      HttpHeaders.contentTypeHeader: "application/json"
    };
    Uri uri = Uri.https(url, "/youtube/v3/playlistItems", parameters);
    http.Response res = await http.get(uri, headers: headers);
    return VideoList.fromRawJson(res.body).items![0];
  }
}
