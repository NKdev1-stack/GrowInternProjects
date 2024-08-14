import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music/Widgets/text_widget.dart';
import 'package:music/consts/colors.dart' as const_colors;
import 'package:music/views/music_player.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../Controllers/player_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    // Calling the Created Permission Controller using Get.put()

    var controller = Get.put(Player_Controller());

    return Scaffold(
        backgroundColor: const_colors.bgDarkColor,
        appBar: AppBar(
          backgroundColor: const_colors.bgDarkColor,
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search),
              color: const_colors.whiteColor,
            )
          ],
          leading: const Icon(
            Icons.sort,
            color: const_colors.whiteColor,
          ),
          title: Text_Widget('Beats', 18, const_colors.whiteColor, 'regular'),
        ),
        // Song model is by default created by Audio Query
        body: FutureBuilder<List<SongModel>>(
          future: controller.audioQuery.querySongs(
            //.. if in playerController user allow the permission then we call this future
            // it will auto ignore the corrupted or any other files to avoid error
            ignoreCase: true,
            // Time order like song length is small will be show first
            orderType: OrderType.ASC_OR_SMALLER,
            // No sorting
            sortType: null,
            // uriType will access all External audios
            uriType: UriType.EXTERNAL,
          ),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.data!.isEmpty) {
              return Center(
                  child: Text_Widget(
                      'No Song Found', 14, const_colors.whiteColor, 'regular'));
            } else {
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        tileColor: const_colors.bgColor,
                        title: Text_Widget(
                            snapshot.data![index].displayNameWOExt,
                            15,
                            const_colors.whiteColor,
                            'bold'),
                        subtitle:
                            snapshot.data![index].artist.toString().isEmpty
                                ? Text_Widget('Author not Found', 14,
                                    const_colors.whiteColor, 'regular')
                                : Text_Widget(
                                    snapshot.data![index].artist.toString(),
                                    12,
                                    const_colors.whiteColor,
                                    'regular'),
                        // We will show the AUDIO ART WORK IMAGE THERE (The default Audio Images which are defined in Audio by default by composer)
                        // in QueryArworkWidget() ArtWork Type will be default AUDIO image and null Art Work mean if image does not have any ARTWORK image then we will show default music icon

                        leading: QueryArtworkWidget(
                          id: snapshot.data![index].id,
                          type: ArtworkType.AUDIO,
                          nullArtworkWidget: const Icon(
                            Icons.music_note,
                            color: Colors.white,
                            size: 32,
                          ),
                        ),
                        trailing: const Icon(
                          Icons.play_circle,
                          color: const_colors.whiteColor,
                          size: 26,
                        ),
                        onTap: () {
                          // Call the PlayAudio Method from player controller class to play specific audio from device
                          controller.playSongs(snapshot.data![index].uri);
                          // Open the Player screen when we can create controls for audio and also we will play audio
                          // Opening New screen using getX
                          // passing data to the constructor of Player Screen so now we can also access this data on next screen using the data parameter
                          Get.to(() =>  MusicPlayer(data:snapshot.data![index],));
                        },
                      ),
                    );
                  },
                ),
              );
            }
          },
        ));
  }
}
