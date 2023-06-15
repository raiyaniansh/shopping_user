import 'package:firebaseecom/screen/home/modal/home_modal.dart';
import 'package:firebaseecom/utils/firebase_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  int i=0;
  int uipi=0;
  String? cnum;
  String? userkey;
  String? upiid;
  TextEditingController txtcnum = TextEditingController();
  TextEditingController txtcname = TextEditingController();
  TextEditingController txtupiid = TextEditingController();
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Color(0xff13171C),
          body: Padding(
            padding: const EdgeInsets.only(left: 10, top: 30, right: 10),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: Color(0xff13171C),
                    child: Row(
                      children: [
                        Text(
                          "Profile",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 30.sp),
                        ),
                        Expanded(child: SizedBox()),
                      ],
                    ),
                  ),
                  SizedBox(height: 3.h,),
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Container(
                        color: Color(0xff242C32),
                        height: 15.h,
                        width: 15.h,
                        child: Image.network(
                            "https://dwglogo.com/wp-content/uploads/2016/02/Amazoncom-yellow-arrow.png",
                            color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(height: 1.h,),
                  StreamBuilder(builder: (context, snapshot) {
                   if(snapshot.hasError)
                     {
                       return Text("${snapshot.error}");
                     }
                   else if(snapshot.hasData)
                     {
                       var user = snapshot.data!.docs;
                       return Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Text("${user[0]["Name"]}",style: TextStyle(fontSize: 25.sp,color: Colors.white)),
                           SizedBox(height: 1.h,),
                           Text("${user[0]["email"]}",style: TextStyle(fontSize: 20.sp,color: Colors.white70)),
                           SizedBox(height: 5.h,),
                           (user[0]['Add']=="")?Container():Text("${user[0]["Add"]} , ${user[0]["City"]}, ${user[0]["State"]} - ${user[0]["Zip"]}",style: TextStyle(fontSize: 18.sp,color: Colors.white)),
                           SizedBox(height: 5.h,),
                           Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             children: [
                               Text(
                                 "History",
                                 style: TextStyle(
                                     color: Colors.white,
                                     fontWeight: FontWeight.bold,
                                     fontSize: 30.sp),
                               ),
                               SizedBox(
                                 height: 1.h,
                               ),
                               StreamBuilder(
                                 builder: (context, snapshot) {
                                   if (snapshot.hasData) {
                                     var data = snapshot.data!.docs;
                                     List<ProductModal> productlist = [];
                                     for (var x in data) {
                                       ProductModal order = ProductModal(
                                         Name: x['Name'],
                                         Price: x['Price'],
                                         Dis: x['Dis'],
                                         Brand: x['Brand'],
                                         con: x["Con"],
                                         cat: x["Cat"],
                                         img: x["Img"],
                                       );
                                       productlist.add(order);
                                     }
                                     return Container(
                                       height: 43.h,
                                       child: ListView.builder(
                                         physics: BouncingScrollPhysics(),
                                         itemCount: productlist.length,
                                         itemBuilder: (context, index) => Container(
                                           padding: EdgeInsets.all(7),
                                           decoration: BoxDecoration(
                                               color: Colors.white10,
                                               borderRadius: BorderRadius.circular(15)),
                                           margin:
                                           EdgeInsets.symmetric(vertical: 5),
                                           child: Row(
                                             children: [
                                               Container(
                                                 width: 7.h,
                                                 height: 7.h,
                                                 margin: EdgeInsets.only(right: 8),
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
                                               Column(
                                                 crossAxisAlignment: CrossAxisAlignment.start,
                                                 children: [
                                                   Text("${productlist[index].Name}",
                                                       style: TextStyle(color: Colors.white)),
                                                   Text("Qua : ${productlist[index].con}",
                                                       style: TextStyle(color: Colors.white)),
                                                   Text("Rs. ${productlist[index].Price}",
                                                       style: TextStyle(color: Colors.white)),
                                                 ],
                                               ),
                                             ],
                                           ),
                                         ),
                                       ),
                                     );
                                   }
                                   return Center(
                                     child: CircularProgressIndicator(
                                       color: Colors.white,
                                     ),
                                   );
                                 },
                                 stream: FireBase.fireBase.readbuy(),
                               ),
                             ],
                           ),
                         ],
                       );
                     }
                   return CircularProgressIndicator(color: Colors.white,);
                  },stream: FireBase.fireBase.Readuser(),),
                ],
              ),
            ),
          )),
    );
  }
}
