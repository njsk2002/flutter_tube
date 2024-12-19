
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tube/model/video_model.dart';

// 유튜브 재생기를 사용하기 위해 패키지 불러오기
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

//유투브 동영상 재생기가 될 위젯
class CustomYouTubePlayer extends StatefulWidget{
//상위 위젯에서 입력받을 동영상정보
final VideoModel videoModel;

const CustomYouTubePlayer({
  required this.videoModel,
  Key? key,
}):super(key:key);
  @override
  State<CustomYouTubePlayer> createState() => _CustomYouTubePlayerState();

}//class

class _CustomYouTubePlayerState extends State<CustomYouTubePlayer>{
  YoutubePlayerController? controller;

  @override
  void initState(){
    super.initState();

    controller = YoutubePlayerController( // 컨트롤러 선언
        initialVideoId: widget.videoModel.id, // 처음실행할 동영상
        flags: YoutubePlayerFlags(
          autoPlay: false, // 자동 실행 사용하지 않기
        ),
    );
  }

  @override
  Widget build(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      YoutubePlayer( // 유튜브 재생기
          controller: controller!,
          showVideoProgressIndicator: true,
      ),
      const SizedBox(height: 16.0),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Text(
          widget.videoModel.title, // 동영상제목
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.0,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      const SizedBox(height: 16.0),
    ],
  );
  }
  
  @override
  void dispose(){
    super.dispose();
    
    controller!.dispose(); // State 폐기 시 컨트롤러 또한 폐기
  }

}