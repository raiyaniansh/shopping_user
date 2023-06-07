import 'package:firebaseecom/screen/bottom/controller/bottom_controller.dart';
import 'package:firebaseecom/screen/detail/modal/detail_modal.dart';
import 'package:firebaseecom/screen/home/modal/home_modal.dart';
import 'package:firebaseecom/utils/firebase_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController txtsearch = TextEditingController();
  RxString search = "".obs;
  RxInt i=0.obs;
  List<ProductModal> productlist = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff13171C),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: StreamBuilder(
            stream: FireBase.fireBase.readdata(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text("${snapshot.error}"));
              } else if (snapshot.hasData) {
                productlist = [];
                var data = snapshot.data!.docs;
                for (var x in data) {
                  ProductModal productModal = ProductModal(
                      Name: x['Name'],
                      Price: x['Price'],
                      Dis: x['Dis'],
                      Brand: x['Brand'],
                      Stock: x['Stock'],
                      rat: x['rat'],
                      cat: x['Cat'],
                      img: x["Img"],
                      key: x.id,
                      rtn: x['Day']);
                  productlist.add(productModal);
                }
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 1.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: Icon(Icons.arrow_back, color: Colors.white),
                        ),
                        InkWell(
                          onTap: () {
                            BottomCon bottom = Get.put(BottomCon());
                            bottom.i.value = 1;
                            Get.offAndToNamed('/bottom');
                          },
                          child: Icon(Icons.shopping_cart, color: Colors.white),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    TextField(
                      controller: txtsearch,
                      onChanged: (value) {
                        search.value = value.substring(0,1).toUpperCase()+value.substring(1).toLowerCase();
                        i.value=value.length;
                        print(search.value);
                       },
                      cursorColor: Colors.white,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintStyle: TextStyle(color: Colors.white54),
                        hintText: "Search for item...",
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        fillColor: Colors.white10,
                        filled: true,
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Text(" Results",
                        style: TextStyle(
                            fontSize: 20.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w600)),
                    SizedBox(
                      height: 1.h,
                    ),
                    Expanded(
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
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
                              child: Obx(
                                () => Container(
                                  child: (productlist[index].Name!.substring(0,i.value) ==
                                              search.value ||
                                          productlist[index].cat!.substring(0,i.value) ==
                                              search.value)
                                      ? Container(
                                          margin: EdgeInsets.only(
                                              top: 5, left: 8, right: 8),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                "${productlist[index].Name}",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 15.sp),
                                              ),
                                              Container(
                                                margin: EdgeInsets.only(top: 8),
                                                height: 0.1.h,
                                                color: Colors.white10,
                                              )
                                            ],
                                          ),
                                        )
                                      : Container(),
                                ),
                              ),
                            );
                          },
                          itemCount: productlist.length),
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
        ),
      ),
    );
  }
}
