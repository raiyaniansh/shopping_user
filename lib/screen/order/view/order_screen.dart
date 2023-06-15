import 'package:firebaseecom/screen/home/modal/home_modal.dart';
import 'package:firebaseecom/utils/firebase_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

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
  ProductModal product = ProductModal();

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
                                        onPressed: () {
                                          product = ProductModal(
                                              Name: productlist[index].Name,
                                              rat: productlist[index].rat,
                                              Price: productlist[index].Price,
                                              Dis: productlist[index].Dis,
                                              Brand: productlist[index].Brand,
                                              img: productlist[index].img,
                                              con: productlist[index].con,
                                              cat: productlist[index].cat,
                                              Stock: productlist[index].Stock,
                                              rtn: productlist[index].rtn,
                                              rid: productlist[index].rid,
                                              key: productlist[index].key);
                                          num total = int.parse(
                                                  productlist[index].Price!) *
                                              int.parse(
                                                  productlist[index].con!) *
                                              100;
                                          Razorpay razorpay = Razorpay();
                                          razorpay.on(
                                              Razorpay.EVENT_PAYMENT_SUCCESS,
                                              _handlePaymentSuccess);
                                          razorpay.on(
                                              Razorpay.EVENT_PAYMENT_ERROR,
                                              _handlePaymentError);
                                          razorpay.on(
                                              Razorpay.EVENT_EXTERNAL_WALLET,
                                              _handleExternalWallet);
                                          var options = {
                                            'key': 'rzp_test_S2mfF9oI5zrbuE',
                                            'amount': '$total',
                                          };
                                          razorpay.open(options);
                                        },
                                        child: Text("BuyNow"),
                                        style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStatePropertyAll(
                                            Color(0xff242C32),
                                          ),
                                        ),
                                      ),
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
                    ),
                  );
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

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    FireBase.fireBase.Orderitem(Name: product.Name,cat: product.cat,con: product.con,img: product.img,Brand: product.Brand,Dis: product.Dis,Price: product.Price,stock: product.Stock,Day: product.rtn,key: product.key);
    FireBase.fireBase.Historyd(Brand: product.Brand,Price: product.Price,Name: product.Name,Dis: product.Dis,img: product.img,con: product.con,cat: product.cat);
    FireBase.fireBase.delet(product.rid);
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet was selected
  }
}
