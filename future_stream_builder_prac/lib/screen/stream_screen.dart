import 'dart:math';

import 'package:flutter/material.dart';

class StreamScreen extends StatefulWidget {
  const StreamScreen({super.key});

  @override
  State<StreamScreen> createState() => _StreamScreenState();
}

class _StreamScreenState extends State<StreamScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //future의 상태가 변경될 때마다 매번 실행한다.
        body: StreamBuilder<int>(
            stream: streamNumbers(),
            builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
              print('------data-------');
              print(snapshot.connectionState); //stream의 경우 거의 active 이다가 done
              print(snapshot.data);

              /// 이 ConnectionState가지고 분기처리 가능
              //ConnectionState.none; -> Future 또는 Stream이 입력되지 않은상태
              //ConnectionState.active; -> Stream에서만 존재 / 아직 스트림이 실행중인 상태
              //ConnectionState.done; -> Future 또는 Stream이 종료 됐을 때
              //ConnectionState.waiting; -> 실행중

              //먄약 로딩중인데 데이터 왔으면
              if (snapshot.connectionState == ConnectionState.active) {
                return SizedBox(
                  width: double.infinity,
                  child: Column(
                    children: [
                      CircularProgressIndicator(),
                      Text(snapshot.data.toString()),
                    ],
                  ),
                );
              }

              //error 확인 방법
              if (snapshot.hasError) {
                final error = snapshot.error;
                return Center(
                  child: Text(error.toString()), //에러~~~
                );
              }
              //데이터 존재유무 확인
              if (snapshot.hasData) {
                final data = snapshot.data;

                return Center(
                  child: Text(data.toString()),
                );
              }

              return Center(
                child: Text('NO DATA'),
              );
            }));
  }

  Future<int> getNumber() async {
    await Future.delayed(const Duration(seconds: 3));

    final random = Random();

    //throw Exception('에러~~~');

    return random.nextInt(100);
  }

  Stream<int> streamNumbers() async* {
    for (int i = 0; i < 10; i++) {
      await Future.delayed(Duration(seconds: 1));

      if (i == 5) {
        throw '던져 에러!';
      }

      yield i;
    }
  }
}
