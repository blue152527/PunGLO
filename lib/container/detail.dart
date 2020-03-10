import 'package:flutter/material.dart';
import 'package:punglo/models/product_model.dart';
import 'package:punglo/utility/my_style.dart';

class Detail extends StatefulWidget {
  final ProductModel model;
  Detail({Key key, this.model}) : super(key: key);

  @override
  _DetailState createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  // Field
  ProductModel productModel;

  // Method
  @override
  void initState() {
    super.initState();
    productModel = widget.model;
  }

  Widget showPic() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      width: MediaQuery.of(context).size.width,
      child: Image.network(
        productModel.url,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget arrowBack() {
    return IconButton(
      icon: Icon(
        Icons.arrow_back,
        size: 36.0,
        color: Colors.white,
      ),
      onPressed: () => Navigator.of(context).pop(),
    );
  }

  Widget mainContent() {
    return Column(
      children: <Widget>[showPic(), showID(), showTitle()],
    );
  }

  Widget showID() {
    return Container(margin: EdgeInsets.all(15.0),
      child: Row(
        children: <Widget>[
          Card(
            color: MyStyle().primaryColor,
            child: Text(productModel.id.toString(),
                style: TextStyle(
                  fontSize: 60.0,
                  fontWeight: FontWeight.bold,
                  color: MyStyle().darkColor,
                )),
          ),
        ],
      ),
    );
  }

  Widget showTitle() {
    return Container(
      margin: EdgeInsets.all(15.0),
      child: Text(productModel.title),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            mainContent(),
            arrowBack(),
          ],
        ),
      ),
    );
  }
}
