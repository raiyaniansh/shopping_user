import 'package:firebaseecom/screen/home/modal/home_modal.dart';
import 'package:firebaseecom/utils/firebase_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  RxInt pay = 4.obs;
  String? userkey;
  TextEditingController txtcnum = TextEditingController();
  TextEditingController txtcname = TextEditingController();
  TextEditingController txtupiid = TextEditingController();
  var user;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff13171C),
        body: Padding(
          padding: const EdgeInsets.only(left: 10, top: 30, right: 10),
          child: Stack(
            children: [
              StreamBuilder(
                stream: FireBase.fireBase.readcart(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(child: Text("${snapshot.error}"));
                  } else if (snapshot.hasData) {
                    var data = snapshot.data!.docs;
                    List<ProductModal> productlist = [];
                    for (var x in data) {
                      ProductModal productModal = ProductModal(
                        rid: x.id,
                        Name: x['Name'],
                        Price: x['Price'],
                        Dis: x['Dis'],
                        Brand: x['Brand'],
                        Stock: x['Stock'],
                        cat: x['Cat'],
                        img: x["Img"],
                        key: x.id,
                        rtn: x['Day'],
                        con: x['Con'],
                      );
                      productlist.add(productModal);
                    }
                    return Column(
                      children: [
                        StreamBuilder(builder: (context, snapshot) {
                          if(snapshot.hasData)
                          {
                            user = snapshot.data!.docs;
                            userkey=user[0].id;
                            txtcnum = TextEditingController(text :user[0]['cnum']);
                            txtcname = TextEditingController(text :user[0]['cname']);
                            txtupiid = TextEditingController(text :user[0]['upiid']);
                          }
                          return Container();
                        },stream: FireBase.fireBase.Readuser()),
                        SizedBox(
                          height: 6.h,
                        ),
                        Expanded(
                          child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) => Container(
                              margin: EdgeInsets.symmetric(vertical: 5),
                              padding: EdgeInsets.symmetric(vertical: 10),
                              width: 80.w,
                              // height: 10.h,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Colors.white10,
                                  borderRadius: BorderRadius.circular(15)),
                              child: ExpansionTile(
                                trailing: Container(
                                  width: 1.w,
                                  height: 1.h,
                                ),
                                leading: Container(
                                  width: 8.h,
                                  height: 10.h,
                                  decoration: BoxDecoration(
                                      color: Colors.white10,
                                      borderRadius: BorderRadius.circular(15),
                                      image: DecorationImage(
                                          image: NetworkImage(productlist[index]
                                                      .img ==
                                                  ""
                                              ? 'https://dwglogo.com/wp-content/uploads/2016/02/Amazoncom-yellow-arrow.png'
                                              : "${productlist[index].img}"))),
                                ),
                                title: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 40.w,
                                      child: Text(
                                        overflow: TextOverflow.ellipsis,
                                        "${productlist[index].Name}",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 18.sp),
                                      ),
                                    ),
                                    Text(
                                      "Rs. ${productlist[index].Price}",
                                      style: TextStyle(
                                          color: Colors.white70,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12.sp),
                                    ),
                                    Text(
                                      "Quantity : ${productlist[index].con}",
                                      style: TextStyle(
                                          color: Colors.white70,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 12.sp),
                                    ),
                                  ],
                                ),
                                childrenPadding: EdgeInsets.all(10),
                                children: [
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      ElevatedButton(
                                          onPressed: () async {
                                            FireBase.fireBase
                                                .delet(productlist[index].rid);
                                          },
                                          child: Text("Remove"),
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStatePropertyAll(
                                                      Color(0xff242C32)))),
                                      ElevatedButton(
                                          onPressed: () async {
                                            showModalBottomSheet(
                                                isDismissible: true,
                                                isScrollControlled: true,
                                                context: context,
                                                builder: (context) => Container(
                                                  height: 80.h,
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Color(0xff13171C),
                                                        borderRadius:
                                                            BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  35),
                                                          topRight:
                                                              Radius.circular(
                                                                  35),
                                                        ),
                                                      ),
                                                      padding: EdgeInsets.only(
                                                          left: 15,
                                                          right: 15,
                                                          top: 20),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            "Payment Option",
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 25.sp,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600),
                                                          ),
                                                          SizedBox(
                                                            height: 2.h,
                                                          ),
                                                          InkWell(
                                                            onTap: () {
                                                              pay.value = 0;
                                                            },
                                                            child: Obx(
                                                              () => Row(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Container(
                                                                    height:
                                                                        2.5.h,
                                                                    // margin: EdgeInsets.only(left: 15),
                                                                    width:
                                                                        2.5.h,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      shape: BoxShape
                                                                          .circle,
                                                                      color: pay.value == 0
                                                                          ? Colors
                                                                              .blue
                                                                          : Colors
                                                                              .transparent,
                                                                      border: Border.all(
                                                                          color:
                                                                              Colors.blue),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 2.w,
                                                                  ),
                                                                  Container(
                                                                    width: 80.w,
                                                                    child:
                                                                        Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .min,
                                                                      children: [
                                                                        Text(
                                                                            "Pay with Debit/Credit/ATM Cards",
                                                                            style:
                                                                                TextStyle(color: Colors.white, fontSize: 13.sp)),
                                                                        pay.value ==
                                                                                0
                                                                            ? Container(
                                                                                child: Column(
                                                                                  mainAxisSize: MainAxisSize.min,
                                                                                  children: [
                                                                                    SizedBox(
                                                                                      height: 1.h,
                                                                                    ),
                                                                                    TextField(
                                                                                      keyboardType: TextInputType.number,
                                                                                      controller: txtcnum,
                                                                                      style: TextStyle(color: Colors.white),
                                                                                      decoration: InputDecoration(label: Text("Card number", style: TextStyle(color: Colors.white70)), enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)), focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white))),
                                                                                    ),
                                                                                    SizedBox(
                                                                                      height: 1.5.h,
                                                                                    ),
                                                                                    TextField(
                                                                                      controller: txtcname,
                                                                                      style: TextStyle(color: Colors.white),
                                                                                      decoration: InputDecoration(label: Text("Name on card", style: TextStyle(color: Colors.white70)), enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)), focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white))),
                                                                                    ),
                                                                                    SizedBox(
                                                                                      height: 1.h,
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              )
                                                                            : Container(),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 1.h,
                                                          ),
                                                          InkWell(
                                                            onTap: () {
                                                              pay.value = 1;
                                                            },
                                                            child: Obx(
                                                              () => Row(
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  Container(
                                                                    height:
                                                                        2.5.h,
                                                                    // margin: EdgeInsets.only(left: 15),
                                                                    width:
                                                                        2.5.h,
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      shape: BoxShape
                                                                          .circle,
                                                                      color: pay.value == 1
                                                                          ? Colors
                                                                              .blue
                                                                          : Colors
                                                                              .transparent,
                                                                      border: Border.all(
                                                                          color:
                                                                              Colors.blue),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 2.w,
                                                                  ),
                                                                  Container(
                                                                    width: 80.w,
                                                                    child:
                                                                        Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      mainAxisSize:
                                                                          MainAxisSize
                                                                              .min,
                                                                      children: [
                                                                        Text(
                                                                            "Other UPI Apps",
                                                                            style:
                                                                                TextStyle(color: Colors.white, fontSize: 13.sp)),
                                                                        pay.value ==
                                                                                1
                                                                            ? Container(
                                                                                child: Column(
                                                                                  mainAxisSize: MainAxisSize.min,
                                                                                  children: [
                                                                                    SizedBox(
                                                                                      height: 1.h,
                                                                                    ),
                                                                                    TextField(
                                                                                      controller: txtupiid,
                                                                                      style: TextStyle(color: Colors.white),
                                                                                      decoration: InputDecoration(label: Text("UPI Id", style: TextStyle(color: Colors.white70)), enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)), focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white))),
                                                                                    ),
                                                                                    SizedBox(
                                                                                      height: 1.h,
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              )
                                                                            : Container(),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: 1.h,
                                                          ),
                                                          InkWell(
                                                            onTap: () {
                                                              pay.value = 2;
                                                            },
                                                            child: Obx(
                                                                  () => Row(
                                                                crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                                children: [
                                                                  Container(
                                                                    height:
                                                                    2.5.h,
                                                                    // margin: EdgeInsets.only(left: 15),
                                                                    width:
                                                                    2.5.h,
                                                                    decoration:
                                                                    BoxDecoration(
                                                                      shape: BoxShape
                                                                          .circle,
                                                                      color: pay.value == 2
                                                                          ? Colors
                                                                          .blue
                                                                          : Colors
                                                                          .transparent,
                                                                      border: Border.all(
                                                                          color:
                                                                          Colors.blue),
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    width: 2.w,
                                                                  ),
                                                                  Container(
                                                                    width: 80.w,
                                                                    child:
                                                                    Column(
                                                                      crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                      mainAxisSize:
                                                                      MainAxisSize
                                                                          .min,
                                                                      children: [
                                                                        Text(
                                                                            "Cash on Delivery",
                                                                            style:
                                                                            TextStyle(color: Colors.white, fontSize: 13.sp)),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(child: SizedBox()),
                                                          Row(
                                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                            children: [
                                                              Text("Total payment",style: TextStyle(color: Colors.white,fontSize: 18.sp)),
                                                              Text("Rs. ${(int.parse(productlist[index].Price!)*int.parse(productlist[index].con!))}",style: TextStyle(color: Colors.white,fontSize: 18.sp)),
                                                            ],
                                                          ),
                                                          SizedBox(height: 2.h,),
                                                          InkWell(onTap: () async {
                                                            String? payty;
                                                            if(pay.value==0)
                                                              {
                                                                payty="Pay with Debit/Credit/ATM Cards";
                                                              }
                                                            else if(pay.value==1)
                                                              {
                                                                payty="Other UPI Apps";
                                                              }
                                                            else
                                                              {
                                                                payty="Cash on Delivery";
                                                              }
                                                            if(pay.value==0||pay.value==1||pay.value==2){
                                                                  await FireBase.fireBase.Orderitem(
                                                                  Name: productlist[index].Name,
                                                                      Pay: payty,
                                                                  key: productlist[index].key,
                                                                  Price: productlist[index].Price,
                                                                  Dis: productlist[index].Dis,
                                                                  Brand: productlist[index].Brand,
                                                                  cat: productlist[index].cat,
                                                                  img: productlist[index].img,
                                                                  Day: productlist[index].rtn,
                                                                  con: productlist[index].con);
                                                                  FireBase.fireBase.UserUData(key: userkey,Name: user[0]['Name'],Zip: user[0]['Zip'],State: user[0]['State'],City: user[0]['City'],Add: user[0]['Add'],cnum: txtcnum.text,cname: txtcname.text,upiid: txtupiid.text);
                                                                  FireBase.fireBase.delet(productlist[index].rid);
                                                              Get.back();
                                                              ScaffoldMessenger.of(context)
                                                                  .showSnackBar(SnackBar(content: Text("Product buy successfully")));
                                                            }
                                                          },child: Container(height: 7.h,width: 100.w,decoration: BoxDecoration(color: Colors.white10,border: Border.all(color: Colors.white),borderRadius: BorderRadius.circular(10)),child: Text("Buy Now",style: TextStyle(color: Colors.white,fontSize: 18.sp,fontWeight: FontWeight.w600),),alignment: Alignment.center)),
                                                          SizedBox(height: 1.h,),
                                                        ],
                                                      ),
                                                    ),
                                                backgroundColor:
                                                    Colors.transparent);
                                          },
                                          child: Text("BuyNow"),
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStatePropertyAll(
                                                      Color(0xff242C32)))),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            itemCount: productlist.length,
                          ),
                        ),
                      ],
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
                        "Cart",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 30.sp),
                      ),
                      Expanded(child: SizedBox()),
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
