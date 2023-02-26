// To parse this JSON data, do
//
//     final tiktokData = tiktokDataFromJson(jsonString);

import 'dart:convert';

TiktokData tiktokDataFromJson(String str) => TiktokData.fromJson(json.decode(str));

String tiktokDataToJson(TiktokData data) => json.encode(data.toJson());

class TiktokData {
    TiktokData({
        required this.code,
        required this.msg,
        required this.processedTime,
        required this.data,
    });

    int code;
    String msg;
    double processedTime;
    Data data;

    factory TiktokData.fromJson(Map<String, dynamic> json) => TiktokData(
        code: json["code"],
        msg: json["msg"],
        processedTime: json["processed_time"]?.toDouble(),
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "msg": msg,
        "processed_time": processedTime,
        "data": data.toJson(),
    };
}

class Data {
    Data({
        required this.awemeId,
        required this.id,
        required this.region,
        required this.title,
        required this.cover,
        required this.originCover,
        required this.duration,
        required this.play,
        required this.wmplay,
        required this.size,
        required this.wmSize,
        required this.music,
        required this.musicInfo,
        required this.playCount,
        required this.diggCount,
        required this.commentCount,
        required this.shareCount,
        required this.downloadCount,
        required this.createTime,
        required this.author,
    });

    String awemeId;
    String id;
    String region;
    String title;
    String cover;
    String originCover;
    int duration;
    String play;
    String wmplay;
    int size;
    int wmSize;
    String music;
    MusicInfo musicInfo;
    int playCount;
    int diggCount;
    int commentCount;
    int shareCount;
    int downloadCount;
    int createTime;
    Author author;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        awemeId: json["aweme_id"],
        id: json["id"],
        region: json["region"],
        title: json["title"],
        cover: json["cover"],
        originCover: json["origin_cover"],
        duration: json["duration"],
        play: json["play"],
        wmplay: json["wmplay"],
        size: json["size"],
        wmSize: json["wm_size"],
        music: json["music"],
        musicInfo: MusicInfo.fromJson(json["music_info"]),
        playCount: json["play_count"],
        diggCount: json["digg_count"],
        commentCount: json["comment_count"],
        shareCount: json["share_count"],
        downloadCount: json["download_count"],
        createTime: json["create_time"],
        author: Author.fromJson(json["author"]),
    );

    Map<String, dynamic> toJson() => {
        "aweme_id": awemeId,
        "id": id,
        "region": region,
        "title": title,
        "cover": cover,
        "origin_cover": originCover,
        "duration": duration,
        "play": play,
        "wmplay": wmplay,
        "size": size,
        "wm_size": wmSize,
        "music": music,
        "music_info": musicInfo.toJson(),
        "play_count": playCount,
        "digg_count": diggCount,
        "comment_count": commentCount,
        "share_count": shareCount,
        "download_count": downloadCount,
        "create_time": createTime,
        "author": author.toJson(),
    };
}

class Author {
    Author({
        required this.id,
        required this.uniqueId,
        required this.nickname,
        required this.avatar,
    });

    String id;
    String uniqueId;
    String nickname;
    String avatar;

    factory Author.fromJson(Map<String, dynamic> json) => Author(
        id: json["id"],
        uniqueId: json["unique_id"],
        nickname: json["nickname"],
        avatar: json["avatar"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "unique_id": uniqueId,
        "nickname": nickname,
        "avatar": avatar,
    };
}

class MusicInfo {
    MusicInfo({
        required this.id,
        required this.title,
        required this.play,
        required this.cover,
        required this.author,
        required this.original,
        required this.duration,
        required this.album,
    });

    String id;
    String title;
    String play;
    String cover;
    String author;
    bool original;
    int duration;
    String album;

    factory MusicInfo.fromJson(Map<String, dynamic> json) => MusicInfo(
        id: json["id"],
        title: json["title"],
        play: json["play"],
        cover: json["cover"],
        author: json["author"],
        original: json["original"],
        duration: json["duration"],
        album: json["album"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "play": play,
        "cover": cover,
        "author": author,
        "original": original,
        "duration": duration,
        "album": album,
    };
}
