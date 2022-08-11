import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:restappintern/Screens/player.dart';
import 'package:restappintern/Screens/profileScreen.dart';
import 'package:restappintern/backendcalls/backend.dart';
import 'package:restappintern/model/channel.dart';
import 'package:restappintern/model/videos.dart';
import 'package:velocity_x/velocity_x.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    getChannel();
    super.initState();
  }

  int loading = 0;
  late List<UserAccount> channel = [];
  String nextToken = "";
  late List<VideoItem> list = [];

  getChannel() async {
    var b = await Backend.getChannelData("UC3gnhko-qhwOdUDh_DcZaAw");
    channel.add(b);
    var c = await Backend.getChannelData("UC_nseD9NYQYCiDMy-AfkZfA");
    channel.add(c);
    getVideo();
  }

  getVideo() async {
    var b = await Backend.getSingleVideo(
        "", channel[0].items[0].contentDetails.relatedPlaylists.uploads);
    list.add(b);
    var c = await Backend.getSingleVideo(
        "", channel[1].items[0].contentDetails.relatedPlaylists.uploads);
    list.add(c);
    setState(() {
      loading = 1;
    });
  }

  ScrollController sc = ScrollController();
  String previousToken = "nulltoken";

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            child: loading == 0
                ? CircularProgressIndicator()
                : Column(
                    children: [
                      Container(
                        color: Colors.transparent,
                        height: 300,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.separated(
                            scrollDirection: Axis.vertical,
                            controller: sc,
                            itemBuilder: (context, i) {
                              return Container(
                                width: MediaQuery.of(context).size.width,
                                height: 300,
                                decoration: BoxDecoration(
                                    color: Colors.transparent,
                                    image: DecorationImage(
                                        fit: BoxFit.contain,
                                        image: NetworkImage(list[i]
                                            .snippet
                                            .thumbnails
                                            .high
                                            .url))),
                              ).onInkTap(() {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (context) {
                                  return VideoPlayerScreen(
                                    videoItem: list[i],
                                  );
                                }));
                              });
                            },
                            separatorBuilder: (context, i) {
                              return Padding(
                                padding: EdgeInsets.only(left: 12),
                              );
                            },
                            itemCount: 2),
                      ).pOnly(top: 40),
                      Row(
                        children: [
                          "Popular Satsang".text.xl3.make(),
                        ],
                      ).pOnly(top: 16),
                      Container(
                        color: Colors.transparent,
                        height: MediaQuery.of(context).size.width / 2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              child: Hero(
                                tag: channel[0].items[0].id,
                                child: Image.network(channel[0]
                                    .items[0]
                                    .snippet
                                    .thumbnails
                                    .high
                                    .url),
                              ),
                              width: h,
                              height: h,
                            ).onInkTap(() {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: ((context) {
                                return ProfileScreen(channel[0]);
                              })));
                            }),
                            Container(
                              child: Hero(
                                tag: channel[1].items[0].id,
                                child: Image.network(channel[1]
                                    .items[0]
                                    .snippet
                                    .thumbnails
                                    .high
                                    .url),
                              ),
                              width: h,
                              height: h,
                            ).onInkTap(() {
                              Navigator.of(context)
                                  .push(MaterialPageRoute(builder: ((context) {
                                return ProfileScreen(channel[1]);
                              })));
                            }),
                          ],
                        ),
                      ).pOnly(top: 40)
                    ],
                  ).px12(),
          ),
        ),
      ),
    );
  }

  double h = 160;
}
