import 'dart:math';

import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //future의 상태가 변경될 때마다 매번 실행한다.
        body: FutureBuilder<int>(
            future: getNumber(),
            builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
              print('------data-------');
              print(snapshot.connectionState); //future의 상태, waiting.. done..
              print(snapshot.data);

              //ConnectionState.none; -> Future 또는 Stream이 입력되지 않은상태
              //ConnectionState.active; -> Stream에서만 존재 / 아직 스트림이 실행중인 상태
              //ConnectionState.done; -> Future 또는 Stream이 종료 됐을 때
              //ConnectionState.waiting; -> 실행중

              // 이 ConnectionState가지고 분기처리 가능

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
}
