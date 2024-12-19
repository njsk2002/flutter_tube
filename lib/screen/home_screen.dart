
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tube/component/custom_youtube_player.dart';
import 'package:flutter_tube/model/video_model.dart';
import 'package:flutter_tube/repository/youtube_repository.dart';

class HomeScreen extends StatefulWidget {

  const HomeScreen({Key? key}) :super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();

}//class

class _HomeScreenState extends State<HomeScreen>{
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
            '데이튜브',

        ),
        backgroundColor: Colors.black,
      ),

      body: FutureBuilder<List<VideoModel>>(
          future: YoutubeRepository.getVideos(),
          builder: (context, snapshot){
            if (snapshot.hasError){
              return Center(
                child: Text(
                  snapshot.error.toString(),
                ),
              );
            }

            if (!snapshot.hasData){ // 로딩중일때 로딩 위젯 보여주기
              return Center(
                child: CircularProgressIndicator(),
              );
            }

            return RefreshIndicator(
                onRefresh: ()async{
                  setState(() {

                  });
                },
                child : ListView( // List<Videomodel>을 CustomYoutubeplayer로 매핑
                  //아래로 당겨서 스크롤할때 튕기는 애니메이션 추가
                    physics: BouncingScrollPhysics(),
                    children: snapshot.data!
                    .map((e) => CustomYouTubePlayer(videoModel: e)).toList(),
                )
            );

          }
      ),

      // body: CustomYouTubePlayer(
      //     videoModel: VideoModel(
      //         id: '3Ck42C2ZCb8',  // 샘플동영상 id
      //         title: '다트 언어 기본기 1시간안에 끝내기', // 샘플제목
      //     ),
      // ),
    );
  }


  
}