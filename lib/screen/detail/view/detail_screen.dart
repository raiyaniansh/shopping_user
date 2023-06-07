import 'package:firebaseecom/screen/bottom/controller/bottom_controller.dart';
import 'package:firebaseecom/screen/detail/controller/detail_controller.dart';
import 'package:firebaseecom/screen/detail/modal/detail_modal.dart';
import 'package:firebaseecom/utils/firebase_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class DetialScreen extends StatefulWidget {
  const DetialScreen({Key? key}) : super(key: key);

  @override
  State<DetialScreen> createState() => _DetialScreenState();
}

class _DetialScreenState extends State<DetialScreen> {
  DetailController controller = Get.put(DetailController());
  DetailModal data = Get.arguments;
  int? stock;
  RxInt amt=0.obs;
  RxString rat ="0".obs;
  @override
  void initState() {
    super.initState();
    stock = int.parse(data.Stock!);
    amt.value = int.parse(data.Price!);
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff13171C),
        body: Stack(
          children: [
            Container(
              height: 35.h,
              width: 100.w,
              color: Colors.white,
              alignment: Alignment.center,
              child: Image.network(data.img == ""
                  ? 'https://dwglogo.com/wp-content/uploads/2016/02/Amazoncom-yellow-arrow.png'
                  : "${data.img}",height: 25.h,),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Icon(Icons.arrow_back,color: Colors.black,size: 25.sp),
                  ),
                  InkWell(
                    onTap: () {
                      BottomCon bottom =Get.put(BottomCon());
                      bottom.i.value=1;
                      Get.offAndToNamed('/bottom');
                    },
                    child: Icon(Icons.shopping_cart,color: Colors.black,size: 25.sp),
                  ),
                ],
              ),
            ),
            Stack(
              children: [
                Align(
                  alignment: Alignment(0, 1),
                  child: Container(
                    height: 65.h,
                    width: 100.w,
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Color(0xff13171C),
                      borderRadius: BorderRadius.only(topRight: Radius.circular(25),topLeft: Radius.circular(25))
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 1.h,),
                          Text("${data.Name}",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 30.sp)),
                          SizedBox(height: 0.2.h,),
                          SizedBox(height: 5.h,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Barnd",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 20.sp)),
                              Text("${data.Brand}",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 20.sp)),
                            ],
                          ),
                          SizedBox(height: 1.h,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("category",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 20.sp)),
                              Text("${data.cat}",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 20.sp)),
                            ],
                          ),
                          SizedBox(height: 1.h,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Return Time",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 20.sp)),
                              Text("${data.rtn} Day",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 20.sp)),
                            ],
                          ),
                          SizedBox(height: 3.h,),
                          Text("${data.Dis}",style: TextStyle(fontWeight: FontWeight.normal,color: Colors.white70,fontSize: 15.sp),),
                          SizedBox(height: 1.h,),
                          Text("Rating & Review",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 18.sp)),
                          SizedBox(height: 0.5.h,),
                          Row(
                            children: [
                              Text("Rating",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 18.sp)),
                              Expanded(child: SizedBox()),
                              (data.rat=="1"||data.rat=="2"||data.rat=="3"||data.rat=="4"||data.rat=="5")?Icon(Icons.star,color: Colors.white,size: 18.sp,):Icon(Icons.star_border,color: Colors.white70,size: 18.sp,),
                              (data.rat=="2"||data.rat=="3"||data.rat=="4"||data.rat=="5")?Icon(Icons.star,color: Colors.white,size: 18.sp,):Icon(Icons.star_border,color: Colors.white70,size: 18.sp,),
                              (data.rat=="3"||data.rat=="4"||data.rat=="5")?Icon(Icons.star,color: Colors.white,size: 18.sp,):Icon(Icons.star_border,color: Colors.white70,size: 18.sp,),
                              (data.rat=="4"||data.rat=="5")?Icon(Icons.star,color: Colors.white,size: 18.sp,):Icon(Icons.star_border,color: Colors.white70,size: 18.sp,),
                              (data.rat=="5")?Icon(Icons.star,color: Colors.white,size: 18.sp,):Icon(Icons.star_border,color: Colors.white70,size: 18.sp,),
                            ],
                          ),
                          SizedBox(height: 1.h,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Your Rating",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600,fontSize: 18.sp)),
                              Expanded(child: SizedBox()),
                              InkWell(
                                  onTap: () {
                                    rat.value = '1';
                                    print(rat.value);
                                  },
                                  child: Obx(
                                        () => Container(
                                      child: (rat.value == "1" ||
                                          rat.value == "2" ||
                                          rat.value == "3" ||
                                          rat.value == "4" ||
                                          rat.value == "5")
                                          ? Icon(
                                        Icons.star,
                                        color: Colors.white,
                                        size: 18.sp,
                                      )
                                          : Icon(
                                        Icons.star_border,
                                        color: Colors.white70,
                                        size: 18.sp,
                                      ),
                                    ),
                                  )),
                              InkWell(
                                  onTap: () {
                                    rat.value = "2";
                                    print(rat.value);
                                  },
                                  child: Obx(
                                        () => Container(
                                      child: (
                                          rat.value == "2" ||
                                              rat.value == "3" ||
                                              rat.value == "4" ||
                                              rat.value == "5")
                                          ? Icon(
                                        Icons.star,
                                        color: Colors.white,
                                        size: 18.sp,
                                      )
                                          : Icon(
                                        Icons.star_border,
                                        color: Colors.white70,
                                        size: 18.sp,
                                      ),
                                    ),
                                  )),
                              InkWell(
                                  onTap: () {
                                    rat.value = "3";
                                    print(rat.value);
                                  },
                                  child: Obx(
                                        () => Container(
                                      child: (
                                          rat.value == "3" ||
                                              rat.value == "4" ||
                                              rat.value == "5")
                                          ? Icon(
                                        Icons.star,
                                        color: Colors.white,
                                        size: 18.sp,
                                      )
                                          : Icon(
                                        Icons.star_border,
                                        color: Colors.white70,
                                        size: 18.sp,
                                      ),
                                    ),
                                  )),
                              InkWell(
                                  onTap: () {
                                    rat.value = "4";
                                    print(rat.value);
                                  },
                                  child: Obx(
                                        () => Container(
                                      child: (rat.value == "4" ||
                                          rat.value == "5")
                                          ? Icon(
                                        Icons.star,
                                        color: Colors.white,
                                        size: 18.sp,
                                      )
                                          : Icon(
                                        Icons.star_border,
                                        color: Colors.white70,
                                        size: 18.sp,
                                      ),
                                    ),
                                  )),
                              InkWell(
                                  onTap: () {
                                    rat.value = "5";
                                    print(rat.value);
                                  },
                                  child: Obx(
                                        () => Container(
                                      child: (rat.value == "5")
                                          ? Icon(
                                        Icons.star,
                                        color: Colors.white,
                                        size: 18.sp,
                                      )
                                          : Icon(
                                        Icons.star_border,
                                        color: Colors.white70,
                                        size: 18.sp,
                                      ),
                                    ),
                                  )),
                            ],
                          ),
                          SizedBox(height: 20.h,)
                        ],
                      ),
                    )
                  ),
                ),
                Align(
                  alignment: Alignment(0, 0.95),
                  child: Container(
                    color: Color(0xff13171C),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20,),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 5.h,
                              width: 35.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  border: Border.all(color: Colors.white)
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  InkWell(onTap: () {
                                    controller.RemoveI();
                                  },child: Text("-",style: TextStyle(color: Colors.white,fontSize: 30.sp))),
                                  Container(height: 8.h,width: 0.4.w,color: Colors.white,),
                                  Obx(() => Text("${controller.i.value}",style: TextStyle(color: Colors.white,fontSize: 25.sp))),
                                  Container(height: 8.h,width: 0.4.w,color: Colors.white,),
                                  InkWell(onTap: () {
                                    controller.AddI();
                                  },child: Text("+",style: TextStyle(color: Colors.white,fontSize: 30.sp))),
                                ],
                              ),
                            ),
                            Obx(() => Text("Rs. ${amt.value*controller.i.value}",style: TextStyle(fontSize: 28.sp,color: Colors.white,fontWeight: FontWeight.w600),))
                          ],
                        ),
                      ),
                      SizedBox(height: 2.h,),
                      Center(
                        child: (data.Stock=="0")?InkWell(
                          onTap: () async {
                            Get.back();
                          },
                          child: Container(
                            height: 7.h,
                            width: 90.w,
                            decoration: BoxDecoration(
                                color: Colors.white12,
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(70)
                            ),
                            alignment: Alignment.center,
                            child: Text("Remind me later",style: TextStyle(color: Colors.white,fontSize: 20.sp,fontWeight: FontWeight.w500)),
                          )
                        ):InkWell(
                          onTap: () async {
                            stock =(stock!-controller.i.value);
                            if(rat.value=="0")
                              {
                                rat.value=data.rat!;
                              }
                            else
                              {
                                rat.value=((int.parse(data.rat!)+int.parse(rat.value))/2).toString().substring(0,1);
                              }
                            print(data.key);
                            await FireBase.fireBase.Update(Name: data.Name,rat: rat.value,key: data.key,Price: data.Price,Dis: data.Dis,Brand: data.Brand,cat: data.cat,img: data.img,stock: stock!.toString(),Day: data.rtn);
                            await FireBase.fireBase.CartItem(Name: data.Name,key: data.key,Price: data.Price,Dis: data.Dis,Brand: data.Brand,cat: data.cat,img: data.img,stock: stock!.toString(),rat: data.rat,Day: data.rtn,con: controller.i.value);
                            BottomCon bottom =Get.put(BottomCon());
                            bottom.i.value=1;
                            Get.offAndToNamed('/bottom');
                          },
                          child: Container(
                            height: 7.h,
                            width: 90.w,
                            decoration: BoxDecoration(
                                color: Colors.white12,
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(70)
                            ),
                            alignment: Alignment.center,
                            child: Text("ADD TO CART",style: TextStyle(color: Colors.white,fontSize: 20.sp,fontWeight: FontWeight.w500)),
                          ),
                        ),
                      ),
                    ],
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
