
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music/Widgets/text_widget.dart';
import 'package:music/consts/colors.dart' as const_colors;
import 'package:music/views/Home.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../Controllers/player_controller.dart';

class MusicPlayer extends StatelessWidget {
  // using SongModel data for getting the data(Song) from previous screen and then we will play it there
  // SongModel is from audio_query dependency so this will get the audio from previous screen
  final SongModel data;
  MusicPlayer({super.key, required this.data});

  // calling Audio Player Controller which will play the audio so we will call it using GET X
  var controller = Get.find<Player_Controller>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const_colors.bgDarkColor,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomePage(),
                  ));
              controller.audioPlayer.pause();
            },
            icon: const Icon(
              Icons.arrow_back_sharp,
              color: const_colors.whiteColor,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
                child: Container(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              height: 300,
              width: 300,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Colors.red),
              // Here we can show the default Artwork of image
              // using data which we declare on top
              child: QueryArtworkWidget(
                id: data.id,
                type: ArtworkType.AUDIO,
                artworkHeight: double.infinity,
                artworkWidth: double.infinity,
                nullArtworkWidget: const Icon(
                  Icons.music_note_rounded,
                  size: 80,
                ),
              ),
            )),
            const SizedBox(
              height: 10,
            ),
            Expanded(
                child: Container(
              padding: const EdgeInsets.all(12),
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                  color: const_colors.whiteColor,
                  borderRadius:
                      BorderRadius.vertical(top: Radius.circular(16))),
              child: Column(
                children: [
                  Text_Widget(
                      // Showing name using data parameter that we create on top and this is getting the data from the previous class home future builder and passing to this screen

                      data.displayNameWOExt,
                      24,
                      const_colors.bgDarkColor,
                      'bold'),
                  const SizedBox(
                    height: 12,
                  ),
                  Text_Widget(data.artist.toString(), 14,
                      const_colors.bgColor, 'regular'),
                  const SizedBox(
                    height: 12,
                  ),
                  // Row Contains Code For Slider
                  Obx (()=>
                     Row(
                      children: [
                        Text_Widget(
                          // showing the total duration of Audio from the update Slider method()

                        controller.position.value, 14, const_colors.bgDarkColor, 'regular'),
                        Expanded(
                            child: Slider(
                          // Now assign the value variable to that which means that what is current time of audio mean if audio reach at 10 second it will update it

                              value: controller.value.value,
                              // min: Duration(),
                              max: controller.maxAudioDuration.value,
                          onChanged: (newValue) {
                            // Code for Updating Slider with the Duration of Audio using audio player seek
                            // we will pass the slider values to the method and the method will return new value
                            controller.changeDurationToSecond(newValue.toInt());

                            // So simply we set the new value to newvalue.
                            newValue = newValue;



                          },
                          thumbColor: const_colors.slideColor,
                          activeColor: const_colors.slideColor,
                          inactiveColor: const_colors.bgDarkColor,
                        )),
                        Text_Widget(
                          // showing realtime time from controller using update Slider method()
                          // This will show how  much audio is played
                            controller.duration.value, 14, const_colors.bgDarkColor, 'regular'),
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  // Code for Buttons (Next Audio like this)
                  // Obx It helps to rebuild specific parts of your UI automatically when the underlying data changes.
                  Obx(
                        ()=>
                            Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.skip_previous_rounded,
                            size: 50,
                          ),
                        ),
                        controller.isPlaying.value
                            ? IconButton(
                                onPressed: () {
                                  controller.audioPlayer.pause();
                                  controller.isPlaying.value = false;

                                },
                                icon: const Icon(Icons.pause_circle,size: 60,))
                            : IconButton(
                                onPressed: () {
                                  controller.audioPlayer.play();
                                  controller.isPlaying.value = true;

                                },
                                icon: const Icon(Icons.play_circle,size: 60)),
                        IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.skip_next_rounded,
                              size: 50,
                            )),
                      ],
                    ),
                  )
                ],
              ),
            ))
          ],
        ),
      ),
    );
  }
}
