import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:restappintern/Screens/player.dart';
import 'package:restappintern/backendcalls/backend.dart';
import 'package:restappintern/model/channel.dart';
import 'package:restappintern/model/videos.dart';
import 'package:velocity_x/velocity_x.dart';

class ProfileScreen extends StatefulWidget {
  final channel;
  const ProfileScreen(this.channel, {Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    // TODO: implement initState
    list = VideoList(items: []);
    this.channel = widget.channel;
    getVideos();
    super.initState();
  }

  int loading = 0;
  late UserAccount channel;
  String nextToken = "";
  late VideoList list;

  ScrollController sc = ScrollController();
  String previousToken = "nulltoken";
  getVideos() async {
    if (previousToken != nextToken) {
      previousToken = nextToken;
      VideoList tvideos = await Backend.getVideos(
        nextToken,
        channel.items[0].contentDetails.relatedPlaylists.uploads,
      );
      nextToken = tvideos.nextPageToken!;
      list.items!.addAll(tvideos.items!);
      print(list.items!.last.snippet.thumbnails.high.url);

      log("notif", name: "notif");
      log(nextToken, name: "notif");
      for (var item in tvideos.items!) {
        log(item.snippet.title, name: "notif");
      }
      setState(() {
        loading = 1;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          foregroundColor: Colors.black,
          title: channel.items[0].snippet.title.text
              .color(Colors.black)
              .xl2
              .bold
              .make(),
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        body: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Container(
                  height: 250,
                  child: Hero(
                    tag: channel.items[0].id,
                    child: Image.network(
                        channel.items[0].snippet.thumbnails.high.url),
                  ),
                ),
                Row(
                  children: [
                    "Description".text.xl3.make(),
                  ],
                ).pOnly(top: 16),
                SizedBox(
                  height: 100,
                  child: channel.items[0].snippet.description.text.xl
                      .make()
                      .scrollVertical(),
                ),
                loading == 0
                    ? CircularProgressIndicator()
                    : Container(
                        color: Colors.transparent,
                        height: MediaQuery.of(context).size.width / 2,
                        child: NotificationListener<ScrollNotification>(
                          onNotification: (notification) {
                            if (notification.metrics.pixels ==
                                notification.metrics.maxScrollExtent) {
                              log("notif", name: "notif");
                              getVideos();
                            }
                            return true;
                          },
                          child: ListView.separated(
                              scrollDirection: Axis.horizontal,
                              controller: sc,
                              itemBuilder: (context, i) {
                                return Container(
                                  width:
                                      MediaQuery.of(context).size.width / 1.5,
                                  height: MediaQuery.of(context).size.width / 2,
                                  decoration: BoxDecoration(
                                      color: Colors.transparent,
                                      image: DecorationImage(
                                          fit: BoxFit.contain,
                                          image: NetworkImage(
                                            list.items![i].snippet.thumbnails
                                                .high.url,
                                          ))),
                                ).onInkTap(() {
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (context) {
                                    return VideoPlayerScreen(
                                      videoItem: list.items![i],
                                    );
                                  }));
                                });
                              },
                              separatorBuilder: (context, i) {
                                return Padding(
                                  padding: EdgeInsets.only(left: 12),
                                );
                              },
                              itemCount: list.items!.length),
                        ),
                      ).pOnly(top: 40)
              ],
            ).px12(),
          ),
        ),
      ),
    );
  }
}
