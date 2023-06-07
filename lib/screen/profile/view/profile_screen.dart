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
                       cnum="";
                       upiid="";
                       i=0;
                       uipi=0;
                       var user = snapshot.data!.docs;
                       i=user[0]['cnum'].toString().length;
                       uipi=user[0]['upiid'].toString().length;
                       userkey = user[0].id;
                       for(int j=0;j<i-4;j++)
                         {
                           cnum="${cnum}*";
                         }
                       print(uipi);
                       for(int k=0;k<uipi-4;k++)
                         {
                           upiid="${upiid}*";
                         }
                       return Column(
                         crossAxisAlignment: CrossAxisAlignment.start,
                         children: [
                           Text("${user[0]["Name"]}",style: TextStyle(fontSize: 25.sp,color: Colors.white)),
                           SizedBox(height: 1.h,),
                           Text("${user[0]["email"]}",style: TextStyle(fontSize: 20.sp,color: Colors.white70)),
                           SizedBox(height: 5.h,),
                           (user[0]['Add']=="")?Container():Text("${user[0]["Add"]} , ${user[0]["City"]}, ${user[0]["State"]} - ${user[0]["Zip"]}",style: TextStyle(fontSize: 18.sp,color: Colors.white)),
                           SizedBox(height: 5.h,),
                           Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               Text("Debit/Credit/ATM Cards",style: TextStyle(fontSize: 18.sp,color: Colors.white),),
                               InkWell(onTap: () {
                                 txtcnum = TextEditingController(text: user[0]['cnum']);
                                 txtcname = TextEditingController(text: user[0]['cname']);
                                 txtupiid = TextEditingController(text: user[0]['upiid']);
                                 showDialog(context: context, builder: (context) => AlertDialog(backgroundColor: Color(0xff13171C),content: Column(
                                   mainAxisSize: MainAxisSize.min,
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   children: [
                                     Text('Update your cards',style: TextStyle(color: Colors.white,fontSize: 20.sp,fontWeight: FontWeight.w600)),
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
                                     Row(
                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                       children: [
                                         ElevatedButton(onPressed: () {
                                           Get.back();
                                         }, child: Text("Cancel"),style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Color(0xff13171C))),),
                                         ElevatedButton(onPressed: () {
                                           FireBase.fireBase.UserUData(key: userkey,Name: user[0]['Name'],Zip: user[0]['Zip'],State: user[0]['State'],City: user[0]['City'],Add: user[0]['Add'],cnum: txtcnum.text,cname: txtcname.text,upiid: txtupiid.text);
                                           Get.back();
                                         }, child: Text("Save"),style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Color(0xff13171C))),),

                                       ],
                                     )
                                   ],
                                 )),);
                               },child: Text("Update",style: TextStyle(fontSize: 18.sp,color: Colors.white),)),
                             ],
                           ),
                           SizedBox(height: 1.h,),
                           (user[0]['cnum']=="")?Container():Container(
                             height: 18.h,
                             width: 100.w,
                             decoration: BoxDecoration(
                                 color: Colors.white10,
                                 border: Border.all(color: Colors.white),
                                 borderRadius: BorderRadius.circular(15)
                             ),
                             padding: EdgeInsets.all(15),
                             alignment: Alignment.bottomCenter,
                             child: Column(
                               mainAxisSize: MainAxisSize.min,
                               children: [
                                 Text("${cnum}${user[0]['cnum'].toString().substring(i-4,i)}",style: TextStyle(color: Colors.white,fontSize: 16.sp)),
                                 SizedBox(height: 4.h,),
                                 Align(alignment: Alignment.centerLeft,child: Text("${user[0]['cname']}",style: TextStyle(color: Colors.white,fontSize: 16.sp))),
                               ],
                             ),
                           ),
                           SizedBox(height: 5.h,),
                           Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: [
                               Text("Upi id",style: TextStyle(fontSize: 18.sp,color: Colors.white),),
                               InkWell(onTap: () {
                                 txtcnum = TextEditingController(text: user[0]['cnum']);
                                 txtcname = TextEditingController(text: user[0]['cname']);
                                 txtupiid = TextEditingController(text: user[0]['upiid']);
                                 showDialog(context: context, builder: (context) => AlertDialog(backgroundColor: Color(0xff13171C),content: Column(
                                   mainAxisSize: MainAxisSize.min,
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   children: [
                                     Text('Upi id',style: TextStyle(color: Colors.white,fontSize: 20.sp,fontWeight: FontWeight.w600)),
                                     SizedBox(
                                       height: 1.h,
                                     ),
                                     TextField(
                                       controller: txtupiid,
                                       style: TextStyle(color: Colors.white),
                                       decoration: InputDecoration(label: Text("Upi id", style: TextStyle(color: Colors.white70)), enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white)), focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.white))),
                                     ),
                                     SizedBox(
                                       height: 1.h,
                                     ),
                                     Row(
                                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                       children: [
                                         ElevatedButton(onPressed: () {
                                           Get.back();
                                         }, child: Text("Cancel"),style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Color(0xff13171C))),),
                                         ElevatedButton(onPressed: () {
                                           FireBase.fireBase.UserUData(key: userkey,Name: user[0]['Name'],Zip: user[0]['Zip'],State: user[0]['State'],City: user[0]['City'],Add: user[0]['Add'],cnum: txtcnum.text,cname: txtcname.text,upiid: txtupiid.text);
                                           Get.back();
                                         }, child: Text("Save"),style: ButtonStyle(backgroundColor: MaterialStatePropertyAll(Color(0xff13171C))),),

                                       ],
                                     )
                                   ],
                                 )),);
                               },child: Text("Update",style: TextStyle(fontSize: 18.sp,color: Colors.white),)),
                             ],
                           ),
                           SizedBox(height: 1.h,),
                           (user[0]['upiid']=="")?Container():Text("${upiid}${user[0]['upiid'].toString().substring(uipi-4,uipi)}",style: TextStyle(color: Colors.white,fontSize: 16.sp)),
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
