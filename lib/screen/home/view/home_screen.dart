import 'dart:math';

import 'package:firebaseecom/screen/detail/modal/detail_modal.dart';
import 'package:firebaseecom/screen/home/modal/home_modal.dart';
import 'package:firebaseecom/utils/firebase_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff13171C),
        body: Padding(
          padding: const EdgeInsets.only(left: 10, top: 30),
          child: Stack(
            children: [
              StreamBuilder(
                stream: FireBase.fireBase.readdata(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text("${snapshot.error}"));
                  } else if (snapshot.hasData) {
                    var data = snapshot.data!.docs;
                    List<ProductModal> productlist = [];
                    for (var x in data) {
                      ProductModal productModal = ProductModal(
                          Name: x['Name'],
                          rat: x['rat'],
                          Price: x['Price'],
                          Dis: x['Dis'],
                          Brand: x['Brand'],
                          Stock: x['Stock'],
                          cat: x['Cat'],
                          img: x["Img"],
                          key: x.id,
                          rtn: x['Day']);
                      productlist.add(productModal);
                    }
                    return SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 6.h,
                          ),
                          Text("Top Product",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w600)),
                          SizedBox(
                            height: 1.h,
                          ),
                          SizedBox(
                            height: 30.h,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                physics: BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      DetailModal d1 = DetailModal(
                                          rat: productlist[index].rat,
                                          img: productlist[index].img,
                                          cat: productlist[index].cat,
                                          rtn: productlist[index].rtn,
                                          Brand: productlist[index].Brand,
                                          Dis: productlist[index].Dis,
                                          Price: productlist[index].Price,
                                          Name: productlist[index].Name,
                                          key: productlist[index].key,
                                          Stock: productlist[index].Stock);
                                      Get.toNamed('/details', arguments: d1);
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(right: 10),
                                      height: 25.h,
                                      width: 45.w,
                                      decoration: BoxDecoration(
                                        color: Colors.black54,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Column(
                                        children: [
                                          SizedBox(height: 1.h,),
                                          Stack(
                                            children: [
                                              Align(
                                                alignment: Alignment(0, 0),
                                                child: Container(
                                                    height: 22.h,
                                                    width: 40.w,
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius.circular(15),
                                                        image: DecorationImage(
                                                            image: NetworkImage(productlist[
                                                                            index]
                                                                        .img ==
                                                                    ""
                                                                ? 'https://dwglogo.com/wp-content/uploads/2016/02/Amazoncom-yellow-arrow.png'
                                                                : "${productlist[index].img}")))),
                                              ),
                                              (productlist[index].Stock=="0")?Align(
                                                alignment: Alignment(0, 0),
                                                child: Container(
                                                    height: 22.h,
                                                    width: 40.w,
                                                    decoration: BoxDecoration(
                                                        color: Colors.white24,
                                                        borderRadius:
                                                            BorderRadius.circular(15),
                                                        ),
                                                  alignment: Alignment.center,
                                                  child: Transform.rotate(angle: -pi/4,child: Column(
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                      Container(height: 0.3.h,width: 38.w,color: Colors.red,),
                                                      Text("Out of Stock",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 25.sp,color: Colors.red),),
                                                      Container(height: 0.3.h,width: 38.w,color: Colors.red,),
                                                    ],
                                                  )),
                                                ),
                                              ):Container(),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 1.h,
                                          ),
                                          Container(
                                              width: 35.w,
                                              child: Text(
                                                'Rs. ${productlist[index].Price}',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18.sp,
                                                    fontWeight: FontWeight.w600,
                                                    overflow:
                                                        TextOverflow.ellipsis),
                                              )),
                                          SizedBox(
                                            height: 0.5.h,
                                          ),
                                          Container(
                                              width: 35.w,
                                              child: Text(
                                                '${productlist[index].Name}',
                                                style: TextStyle(
                                                    color: Colors.white70,
                                                    fontSize: 15.sp,
                                                    fontWeight: FontWeight.w500,
                                                    overflow:
                                                        TextOverflow.ellipsis),
                                              )),
                                          Expanded(child: SizedBox()),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                itemCount: productlist.length),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Container(
                            height: 15.h,
                            margin: EdgeInsets.only(right: 5),
                            width: 80.w,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              image: DecorationImage(
                                  image: NetworkImage(
                                      "https://luxurywatchbuyer.com/wp-content/uploads/2015/04/banner-2.png"),
                                  fit: BoxFit.cover),
                            ),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Text("All Product",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w600)),
                          SizedBox(
                            height: 2.h,
                          ),
                          SizedBox(
                            height: 30.h,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                physics: BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return InkWell(
                                    onTap: () {
                                      DetailModal d1 = DetailModal(
                                          rat: productlist[index].rat,
                                          img: productlist[index].img,
                                          cat: productlist[index].cat,
                                          rtn: productlist[index].rtn,
                                          Brand: productlist[index].Brand,
                                          Dis: productlist[index].Dis,
                                          Price: productlist[index].Price,
                                          Name: productlist[index].Name,
                                          key: productlist[index].key,
                                          Stock: productlist[index].Stock);
                                      Get.toNamed('/details', arguments: d1);
                                    },
                                    child: Container(
                                      margin: EdgeInsets.only(right: 10),
                                      height: 25.h,
                                      width: 45.w,
                                      decoration: BoxDecoration(
                                        color: Colors.black54,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Column(
                                        children: [
                                          SizedBox(height: 1.h,),
                                          Stack(
                                            children: [
                                              Align(
                                                alignment: Alignment(0, 0),
                                                child: Container(
                                                    height: 22.h,
                                                    width: 40.w,
                                                    decoration: BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                        BorderRadius.circular(15),
                                                        image: DecorationImage(
                                                            image: NetworkImage(productlist[
                                                            index]
                                                                .img ==
                                                                ""
                                                                ? 'https://dwglogo.com/wp-content/uploads/2016/02/Amazoncom-yellow-arrow.png'
                                                                : "${productlist[index].img}")))),
                                              ),
                                              (productlist[index].Stock=="0")?Align(
                                                alignment: Alignment(0, 0),
                                                child: Container(
                                                  height: 22.h,
                                                  width: 40.w,
                                                  decoration: BoxDecoration(
                                                    color: Colors.white24,
                                                    borderRadius:
                                                    BorderRadius.circular(15),
                                                  ),
                                                  alignment: Alignment.center,
                                                  child: Transform.rotate(angle: -pi/4,child: Column(
                                                    mainAxisSize: MainAxisSize.min,
                                                    children: [
                                                      Container(height: 0.3.h,width: 38.w,color: Colors.red,),
                                                      Text("Out of Stock",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 25.sp,color: Colors.red),),
                                                      Container(height: 0.3.h,width: 38.w,color: Colors.red,),
                                                    ],
                                                  )),
                                                ),
                                              ):Container(),
                                            ],
                                          ),
                                          SizedBox(
                                            height: 1.h,
                                          ),
                                          Container(
                                              width: 35.w,
                                              child: Text(
                                                'Rs. ${productlist[index].Price}',
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18.sp,
                                                    fontWeight: FontWeight.w600,
                                                    overflow:
                                                        TextOverflow.ellipsis),
                                              )),
                                          SizedBox(
                                            height: 0.5.h,
                                          ),
                                          Container(
                                              width: 35.w,
                                              child: Text(
                                                '${productlist[index].Name}',
                                                style: TextStyle(
                                                    color: Colors.white70,
                                                    fontSize: 15.sp,
                                                    fontWeight: FontWeight.w500,
                                                    overflow:
                                                        TextOverflow.ellipsis),
                                              )),
                                          Expanded(child: SizedBox()),
                                        ],
                                      ),
                                    ),
                                  );
                                },
                                itemCount: productlist.length),
                          ),
                          SizedBox(
                            height: 2.h,
                          ),
                          Text("Phone",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w600)),
                          SizedBox(
                            height: 2.h,
                          ),
                          SizedBox(
                            height: 30.h,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                physics: BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return (productlist[index].cat == "Phone")
                                      ? InkWell(
                                          onTap: () {
                                            DetailModal d1 = DetailModal(
                                                rat: productlist[index].rat,
                                                img: productlist[index].img,
                                                cat: productlist[index].cat,
                                                rtn: productlist[index].rtn,
                                                Brand: productlist[index].Brand,
                                                Dis: productlist[index].Dis,
                                                Price: productlist[index].Price,
                                                Name: productlist[index].Name,
                                                key: productlist[index].key,
                                                Stock:
                                                    productlist[index].Stock);
                                            Get.toNamed('/details',
                                                arguments: d1);
                                          },
                                          child: Container(
                                            margin: EdgeInsets.only(right: 10),
                                            height: 25.h,
                                            width: 45.w,
                                            decoration: BoxDecoration(
                                              color: Colors.black54,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Column(
                                              children: [
                                                SizedBox(height: 1.h,),
                                                Stack(
                                                  children: [
                                                    Align(
                                                      alignment: Alignment(0, 0),
                                                      child: Container(
                                                          height: 22.h,
                                                          width: 40.w,
                                                          decoration: BoxDecoration(
                                                              color: Colors.white,
                                                              borderRadius:
                                                              BorderRadius.circular(15),
                                                              image: DecorationImage(
                                                                  image: NetworkImage(productlist[
                                                                  index]
                                                                      .img ==
                                                                      ""
                                                                      ? 'https://dwglogo.com/wp-content/uploads/2016/02/Amazoncom-yellow-arrow.png'
                                                                      : "${productlist[index].img}")))),
                                                    ),
                                                    (productlist[index].Stock=="0")?Align(
                                                      alignment: Alignment(0, 0),
                                                      child: Container(
                                                        height: 22.h,
                                                        width: 40.w,
                                                        decoration: BoxDecoration(
                                                          color: Colors.white24,
                                                          borderRadius:
                                                          BorderRadius.circular(15),
                                                        ),
                                                        alignment: Alignment.center,
                                                        child: Transform.rotate(angle: -pi/4,child: Column(
                                                          mainAxisSize: MainAxisSize.min,
                                                          children: [
                                                            Container(height: 0.3.h,width: 38.w,color: Colors.red,),
                                                            Text("Out of Stock",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 25.sp,color: Colors.red),),
                                                            Container(height: 0.3.h,width: 38.w,color: Colors.red,),
                                                          ],
                                                        )),
                                                      ),
                                                    ):Container(),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 1.h,
                                                ),
                                                Container(
                                                    width: 35.w,
                                                    child: Text(
                                                      'Rs. ${productlist[index].Price}',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 18.sp,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          overflow: TextOverflow
                                                              .ellipsis),
                                                    )),
                                                SizedBox(
                                                  height: 0.5.h,
                                                ),
                                                Container(
                                                    width: 35.w,
                                                    child: Text(
                                                      '${productlist[index].Name}',
                                                      style: TextStyle(
                                                          color: Colors.white70,
                                                          fontSize: 15.sp,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          overflow: TextOverflow
                                                              .ellipsis),
                                                    )),
                                                Expanded(child: SizedBox()),
                                              ],
                                            ),
                                          ),
                                        )
                                      : Container();
                                },
                                itemCount: productlist.length),
                          ),
                        ],
                      ),
                    );
                  }
                  return Center(
                      child: CircularProgressIndicator(
                    color: Colors.white,
                  ));
                },
              ),
              Align(
                alignment: Alignment(0, -1),
                child: Container(
                  color: Color(0xff13171C),
                  child: Row(
                    children: [
                      Text(
                        "Home",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 30.sp),
                      ),
                      Expanded(child: SizedBox()),
                      InkWell(
                        onTap: () {
                          Get.toNamed('/search');
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Icon(Icons.search_outlined,
                              size: 25.sp, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}