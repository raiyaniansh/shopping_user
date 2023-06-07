import 'package:firebaseecom/screen/singup/controller/singup_cantroller.dart';
import 'package:firebaseecom/utils/firebase_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class SingInscreen extends StatefulWidget {
  const SingInscreen({Key? key}) : super(key: key);

  @override
  State<SingInscreen> createState() => _SingInscreenState();
}

class _SingInscreenState extends State<SingInscreen> {
  @override
  Widget build(BuildContext context) {
    SingupController homeController = Get.put(SingupController());
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff13171C),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 20.h),
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Color(0xff242C32),
                  ),
                  height: 60.h,
                  width: 80.w,
                  padding: EdgeInsets.all(15),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(height: 3.h,),
                      Text("SingIn",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 25.sp),),
                      Image.network("https://dwglogo.com/wp-content/uploads/2016/02/Amazoncom-yellow-arrow.png",color: Colors.white,height: 6.h,),
                      SizedBox(height: 3.h,),
                      TextField(
                        controller: homeController.txtemail,
                        cursorColor: Colors.white70,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          label: Text("Email",style: TextStyle(color: Colors.white70)),
                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8),borderSide: BorderSide(color: Colors.white)),
                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8),borderSide: BorderSide(color: Colors.white)),
                        ),
                      ),
                      SizedBox(height: 2.h,),
                      TextField(
                        controller: homeController.txtpass,
                        cursorColor: Colors.white70,
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          label: Text("Password",style: TextStyle(color: Colors.white70)),
                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8),borderSide: BorderSide(color: Colors.white)),
                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(8),borderSide: BorderSide(color: Colors.white)),
                        ),
                      ),
                      Expanded(child: SizedBox(height: 2.h,)),
                      InkWell(
                        onTap: () async {
                          String? msg =await homeController.SingIn();
                          if(msg=="success")
                          {
                            Get.offAndToNamed('/bottom');
                          }
                          else{
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("$msg")));
                          }
                        },
                        child: Container(
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Color(0xff13171C),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              "SingIn",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 20),
                            )),
                      ),
                      SizedBox(height: 2.h,),
                      InkWell(onTap: () {
                        Get.toNamed('/singup');
                      },child: Text("You don't have account?SingUp",style: TextStyle(color: Colors.white70,fontWeight: FontWeight.bold,fontSize: 12.sp),)),
                      SizedBox(height: 2.h,),
                      InkWell(
                        onTap: () async {
                          String msg = await FireBase.fireBase.signInWithGoogle();
                          if(msg=="success")
                          {
                            Get.offAndToNamed('/bottom');
                            FireBase.fireBase.UserData(Zip: "",State: "",City: "",Add: "",Name: "");
                          }
                        },
                        child: Container(height: 7.h,width: 7.h,padding: EdgeInsets.all(5),decoration: BoxDecoration(color: Colors.white24,shape: BoxShape.circle),alignment: Alignment.center,child: Image.network('https://clipartcraft.com/images/transparent-background-google-logo-white-8.png')),
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
