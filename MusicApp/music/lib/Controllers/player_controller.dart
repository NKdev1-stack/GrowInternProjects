import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:permission_handler/permission_handler.dart';

class Player_Controller extends GetxController {


    // We create this controller to get the storage permission from user and show its device music to them

// create instance of audioQuery (Dependency we added)

final audioQuery =  OnAudioQuery();

// Create instance of Audio Player we will use this to Play audio files

  final audioPlayer = AudioPlayer();

  // Using .obs because this will help us to update and access these variables instantly and in realtime so its very useful
var isPlaying = true.obs; // For controlling Play or Pause Button

// Initialization method in this method we will get permission from user

  var duration = ''.obs; // for controlling duration and position of slider according to audio
  var position = ''.obs;

  var maxAudioDuration = 0.0.obs; // Total duration of audio. because we need to tell the slider that how long our audio is then it will move along that or help us to seek the audio
  var value = 0.0.obs;
  @override
  void onInit() {

      // Method for checking permission
  checkPermission(); // For Getting User Permission to access the storage external music files
    super.onInit();
  }


  // Mehtod for Playing Songs*****
playSongs(String? uri, ){
  try{
    // The URI which we are parsing and we will play the audio is the audio file path in the user device
    // So the URI (Audio File path) we will get this when we will call this method
    audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(uri!)));

    // Now play the audio from URI
     audioPlayer.play();

      // for slider position and duration as pe audio
    updatePositionanddurationSlider();


     /// for play and pause
     if(audioPlayer.playing){

       // if you can use .obs(come with getX package) with variables then in order to get or assign value from these variables must use .value
       isPlaying.value=true;

     }else{
       isPlaying.value= false;
     }

  }on Exception catch(Exception){

    print(Exception.toString());
  }
}

  // Method for Audio reading Permission*****
  checkPermission()async{

  // the below line of code will send the permission request to user
  var permission = await Permission.storage.request();

  // Now we are checking the condition if permission is granted or denied so on condition base wwe will take action
  if(permission.isGranted){
  // If User allow the storage access
  //   we will return the audioQuery with query songs.

// if User denied the permission
  }else {
  // We will auto call this method so it will again ask for permmission
    checkPermission();

  }

  }


  // Method for Controlling Slider for audio...**

updatePositionanddurationSlider(){
    // We will call this method when the Audio will start Playing and also we are durationStream which will give realtime values of audio duration and position
   // For duration Stream
    audioPlayer.durationStream.listen((d){

      // .split using string method which will help to split the time.
      duration.value = d.toString().split(".")[0];

      maxAudioDuration.value = d!.inSeconds.toDouble(); // Total Duration of Audio

    });
    audioPlayer.positionStream.listen((p){
      position.value = p.toString().split(".")[0];
      value.value = p.inSeconds.toDouble();// value mean on which time or second we seek the audio with finger

    });
}

// This method will help us to Update the Slider with Seconds
changeDurationToSecond(seconds){

    var duration = Duration(seconds:  seconds);
    // The seek will help us to seek our custom slider..
    audioPlayer.seek(duration);
}


}