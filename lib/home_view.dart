import 'dart:convert';
import 'package:dio_api/api_helper.dart';
import 'package:dio_api/common_widget/common_button.dart';
import 'package:dio_api/common_widget/common_text.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  late Future<List<dynamic>> apiHelper;

  @override
  initState(){
    super.initState();
    apiHelper=ApiHelper().fetchData();
    ApiHelper().dioInterceptorRequest();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: CommonText(text: 'DIO'),
      ),
      body: Column(
        children: [

          Expanded(
            child: FutureBuilder<List<dynamic>>(
                future: apiHelper,
                builder: (context, snapshot){

                  if(snapshot.connectionState == ConnectionState.waiting){
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  else if(snapshot.hasError && snapshot.connectionState == ConnectionState.none){
                    return Text(snapshot.hasError.toString());
                  }
                  else{
                    return ListView.builder(
                        itemCount: snapshot.data?.length,
                        itemBuilder:(context,index){
                          return ListTile(
                            leading: CircleAvatar(child: CommonText(text: snapshot.data?[index].id.toString()??"")),
                            title: CommonText(text: snapshot.data?[index].title??""),
                          );
                        });
                  }
                }
            ),
          ),

          Align(
            alignment: AlignmentDirectional.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [

                CommonButton(buttonText: 'Post',onPressed: (){
                    ApiHelper().postData('nehal shinde', context);
                }),

                CommonButton(buttonText: 'Interceptor',onPressed: (){
                  ApiHelper().interceptorData();
                }),

                CommonButton(buttonText: 'Cancellation',onPressed: (){
                  //ApiHelper().CancelToken();
                }),

              ],
            ),
          ),

        ],
      ),
    );
  }

}