import 'package:firebaseecom/utils/firebase_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  TextEditingController txtname = TextEditingController();
  TextEditingController txtadd = TextEditingController();
  TextEditingController txtcity = TextEditingController();
  TextEditingController txtstate = TextEditingController();
  TextEditingController txtZip = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff13171C),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Container(
            height: 100.h,
            width: 100.w,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                  SizedBox(height: 5.h,),
                  Text("  Name", style: TextStyle(color: Colors.white),),
                  SizedBox(height: 1.5.h,),
                  TextField(
                    controller: txtname,
                    style: TextStyle(color: Colors.white),
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.white)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.white)),
                    ),
                  ),
                  SizedBox(height: 3.h,),
                  Text("  Address", style: TextStyle(color: Colors.white),),
                  SizedBox(height: 1.5.h,),
                  TextField(
                    controller: txtadd,
                    style: TextStyle(color: Colors.white),
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.white)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.white)),
                    ),
                  ),
                  SizedBox(height: 3.h,),
                  Text("  City", style: TextStyle(color: Colors.white),),
                  SizedBox(height: 1.5.h,),
                  TextField(
                    controller: txtcity,
                    style: TextStyle(color: Colors.white),
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.white)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.white)),
                    ),
                  ),
                  SizedBox(height: 3.h,),
                  Text("  States", style: TextStyle(color: Colors.white),),
                  SizedBox(height: 1.5.h,),
                  TextField(
                    controller: txtstate,
                    style: TextStyle(color: Colors.white),
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.white)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.white)),
                    ),
                  ),
                  SizedBox(height: 3.h,),
                  Text("  Zip code", style: TextStyle(color: Colors.white),),
                  SizedBox(height: 1.5.h,),
                  TextField(
                    controller: txtZip,
                    keyboardType: TextInputType.number,
                    style: TextStyle(color: Colors.white),
                    cursorColor: Colors.white,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.white)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: Colors.white)),
                    ),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(onTap: () {
                          Get.offAndToNamed('/bottom');
                        },
                            child: Text("Skip >", style: TextStyle(
                                color: Colors.white, fontSize: 20.sp),)),
                        InkWell(onTap: () async {
                          String? msg = await FireBase.fireBase.UserData(Zip: txtZip.text,Name: txtname.text, Add: txtadd.text, City: txtcity.text, State: txtstate.text);
                          if(msg=="Success")
                            {
                              Get.offAndToNamed('/bottom');
                            }
                        },
                            child: Text("Next >", style: TextStyle(
                                color: Colors.white, fontSize: 20.sp),)),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
