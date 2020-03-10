import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:punglo/container/detail.dart';
import 'package:punglo/models/product_model.dart';
import 'package:punglo/utility/my_style.dart';

class ShowListProduct extends StatefulWidget {
  @override
  _ShowListProductState createState() => _ShowListProductState();
}

class _ShowListProductState extends State<ShowListProduct> {
  //Field

  String urlAPI = 'https://jsonplaceholder.typicode.com/photos';
  List<ProductModel> productModels = List();
  ScrollController scrollController = ScrollController();
  int sizeListview = 10;

  //Method

  @override
  void initState() {
    super.initState();
    readJSON();
    setupController();
  }

  void setupController() {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        print('End of List View');
        setState(() {
          sizeListview += 10;
        });
      }
    });
  }

  Future<void> readJSON() async {
    try {
      Response response = await Dio().get(urlAPI);
      print('response = $response');

      for (var map in response.data) {
        ProductModel model = ProductModel.fromJson(map);
        setState(() {
          productModels.add(model);
        });
      }
    } catch (e) {}
  }

  Widget showProcess() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget showListView() {
    return ListView.builder(
        controller: scrollController,
        itemCount: sizeListview,
        itemBuilder: (BuildContext buildContext, int index) {
          return GestureDetector(
            onTap: () {
              MaterialPageRoute route = MaterialPageRoute(
                builder: (value) => Detail(
                  model: productModels[index],
                ),
              );
              Navigator.of(context).push(route);
            },
            child: Row(
              children: <Widget>[
                showPic(index),
                showText(index),
              ],
            ),
          );
        });
  }

  Widget showPic(int index) {
    return Container(
      padding: EdgeInsets.all(16.0),
      width: MediaQuery.of(context).size.width * 0.5,
      child: Image.network(productModels[index].url),
    );
  }

  Widget showText(int index) {
    return Container(
      padding: EdgeInsets.all(16.0),
      width: MediaQuery.of(context).size.width * 0.5,
      height: MediaQuery.of(context).size.width * 0.5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[showID(index), showTitle(index)],
      ),
    );
  }

  Widget showID(int index) {
    return Text(
      productModels[index].id.toString(),
      style: TextStyle(
        fontSize: 50.0,
        fontWeight: FontWeight.bold,
        color: MyStyle().darkColor,
      ),
    );
  }

  Widget showTitle(int index) {
    return Text(productModels[index].title);
  }

  @override
  Widget build(BuildContext context) {
    return productModels.length == 0 ? showProcess() : showListView();
  }
}
