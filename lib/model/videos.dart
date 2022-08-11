// To parse this JSON data, do
//
//     final videoList = videoListFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

class VideoList {
    VideoList({
        this.kind,
        this.etag,
        this.nextPageToken,
        this.items,
        this.pageInfo,
    });

     String? kind;
     String? etag;
     String? nextPageToken;
     List<VideoItem>? items;
     PageInfo? pageInfo;

    factory VideoList.fromRawJson(String str) => VideoList.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory VideoList.fromJson(Map<String, dynamic> json) => VideoList(
        kind: json["kind"],
        etag: json["etag"],
        nextPageToken: json["nextPageToken"],
        items: List<VideoItem>.from(json["items"].map((x) => VideoItem.fromJson(x))),
        pageInfo: PageInfo.fromJson(json["pageInfo"]),
    );

    Map<String, dynamic> toJson() => {
        "kind": kind,
        "etag": etag,
        "nextPageToken": nextPageToken,
        "items": List<dynamic>.from(items!.map((x) => x.toJson())),
        "pageInfo": pageInfo!.toJson(),
    };
}

class VideoItem {
    VideoItem({
       required this.kind,
       required this.etag,
       required this.id,
       required this.snippet,
    });

    final String kind;
    final String etag;
    final String id;
    final video snippet;

    factory VideoItem.fromRawJson(String str) => VideoItem.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory VideoItem.fromJson(Map<String, dynamic> json) => VideoItem(
        kind: json["kind"],
        etag: json["etag"],
        id: json["id"],
        snippet: video.fromJson(json["snippet"]),
    );

    Map<String, dynamic> toJson() => {
        "kind": kind,
        "etag": etag,
        "id": id,
        "snippet": snippet.toJson(),
    };
}

class video {
    video({
       required this.publishedAt,
       required this.channelId,
       required this.title,
       required this.description,
       required this.thumbnails,
       required this.channelTitle,
       required this.playlistId,
       required this.position,
       required this.resourceId,
       required this.videoOwnerChannelTitle,
       required this.videoOwnerChannelId,
    });

    final DateTime publishedAt;
    final String channelId;
    final String title;
    final String description;
    final Thumbnails thumbnails;
    final String channelTitle;
    final String playlistId;
    final int position;
    final ResourceId resourceId;
    final String videoOwnerChannelTitle;
    final String videoOwnerChannelId;

    factory video.fromRawJson(String str) => video.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory video.fromJson(Map<String, dynamic> json) => video(
        publishedAt: DateTime.parse(json["publishedAt"]),
        channelId: json["channelId"],
        title: json["title"],
        description: json["description"],
        thumbnails: Thumbnails.fromJson(json["thumbnails"]),
        channelTitle: json["channelTitle"],
        playlistId: json["playlistId"],
        position: json["position"],
        resourceId: ResourceId.fromJson(json["resourceId"]),
        videoOwnerChannelTitle: json["videoOwnerChannelTitle"],
        videoOwnerChannelId: json["videoOwnerChannelId"],
    );

    Map<String, dynamic> toJson() => {
        "publishedAt": publishedAt.toIso8601String(),
        "channelId": channelId,
        "title": title,
        "description": description,
        "thumbnails": thumbnails.toJson(),
        "channelTitle": channelTitle,
        "playlistId": playlistId,
        "position": position,
        "resourceId": resourceId.toJson(),
        "videoOwnerChannelTitle": videoOwnerChannelTitle,
        "videoOwnerChannelId": videoOwnerChannelId,
    };
}

class ResourceId {
    ResourceId({
       required this.kind,
       required this.videoId,
    });

    final String kind;
    final String videoId;

    factory ResourceId.fromRawJson(String str) => ResourceId.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory ResourceId.fromJson(Map<String, dynamic> json) => ResourceId(
        kind: json["kind"],
        videoId: json["videoId"],
    );

    Map<String, dynamic> toJson() => {
        "kind": kind,
        "videoId": videoId,
    };
}

class Thumbnails {
    Thumbnails({
       required this.thumbnailsDefault,
       required this.medium,
       required this.high,
       required this.standard,
    });

    final Default thumbnailsDefault;
    final Default medium;
    final Default high;
    final Default standard;

    factory Thumbnails.fromRawJson(String str) => Thumbnails.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Thumbnails.fromJson(Map<String, dynamic> json) => Thumbnails(
        thumbnailsDefault: Default.fromJson(json["default"]),
        medium: Default.fromJson(json["medium"]),
        high: Default.fromJson(json["high"]),
        standard: Default.fromJson(json["high"]),
    );

    Map<String, dynamic> toJson() => {
        "default": thumbnailsDefault.toJson(),
        "medium": medium.toJson(),
        "high": high.toJson(),
        "standard": standard == null ? null : standard.toJson(),
    };
}

class Default {
    Default({
       required this.url,
       required this.width,
       required this.height,
    });

    final String url;
    final int width;
    final int height;

    factory Default.fromRawJson(String str) => Default.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory Default.fromJson(Map<String, dynamic> json) => Default(
        url: json["url"],
        width: json["width"],
        height: json["height"],
    );

    Map<String, dynamic> toJson() => {
        "url": url,
        "width": width,
        "height": height,
    };
}

class PageInfo {
    PageInfo({
       required this.totalResults,
       required this.resultsPerPage,
    });

    final int totalResults;
    final int resultsPerPage;

    factory PageInfo.fromRawJson(String str) => PageInfo.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory PageInfo.fromJson(Map<String, dynamic> json) => PageInfo(
        totalResults: json["totalResults"],
        resultsPerPage: json["resultsPerPage"],
    );

    Map<String, dynamic> toJson() => {
        "totalResults": totalResults,
        "resultsPerPage": resultsPerPage,
    };
}
