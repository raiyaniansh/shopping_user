import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FireBase {
  static final FireBase fireBase = FireBase._fireBaseh();

  FireBase._fireBaseh();

  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  Future<String?> singup({required email, required password}) async {
    String? msg;
    await firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((value) {
      msg = "success";
    }).catchError((e) {
      msg = "$e";
    });
    return msg;
  }

  Future<String?> Login({required email, required password}) async {
    String? msg;
    await firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      msg = "success";
    }).catchError((e) {
      msg = "$e";
    });
    return msg;
  }

  Future<void> SignOut() async {
    await firebaseAuth.signOut();
    await GoogleSignIn().signOut();
  }

  FirebaseFirestore db = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Map<String, dynamic>>> readdata() {
    return db.collection('product').snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> readcart() {
    String? user = firebaseAuth.currentUser!.uid;
    return db.collection('cart').doc('$user').collection("cart").snapshots();
  }

  Future<String?> Update(
      {String? Name, Brand, Price, Dis, Day, stock, img, cat, key,rat}) async {
    String? msg;
    await db.collection("product").doc('$key').set({
      "Name": "$Name",
      "Brand": "$Brand",
      "Price": "$Price",
      "Dis": "$Dis",
      "Day": "$Day",
      "Stock": "$stock",
      "Cat": "$cat",
      "Img": "$img",
      "rat": rat,
    }).then((value) => msg = "Success");
    return msg;
  }

  Future<String?> Orderitem(
      {String? Name, Brand, Price, Dis, Day, stock, img, cat, key, con,Pay}) async {
    String? msg;
    String? user = firebaseAuth.currentUser!.uid;
    String? email = firebaseAuth.currentUser!.email;
    await db.collection("order").add({
      "Name": "$Name",
      "Pay": "$Pay",
      "Con": "$con",
      "Brand": "$Brand",
      "Price": "$Price",
      "Dis": "$Dis",
      "Day": "$Day",
      "Stock": "$stock",
      "Cat": "$cat",
      "Img": "$img",
      "Key": "$user",
      "email": "$email",
    }).then((value) => msg = "Success");
    return msg;
  }

  Future<String?> CartItem(
      {String? Name, Brand, Price, Dis, Day, stock, img, cat, key, con,rat}) async {
    String? msg;
    String? user = firebaseAuth.currentUser!.uid;
    await db.collection("cart").doc('$user').collection('cart').add({
      "Name": "$Name",
      "Con": "$con",
      "Brand": "$Brand",
      "Price": "$Price",
      "Dis": "$Dis",
      "Day": "$Day",
      "Stock": "$stock",
      "Cat": "$cat",
      "Img": "$img",
    }).then((value) => msg = "Success");
    return msg;
  }

  void delet(id) {
    String? user = firebaseAuth.currentUser!.uid;
    db.collection("cart").doc('$user').collection("cart").doc('$id').delete();
  }

  Future<String?> UserData({Name, Add, City, State, Zip}) async {
    String? msg;
    String? user = firebaseAuth.currentUser!.uid;
    String? email = firebaseAuth.currentUser!.email;
    await db.collection('user').doc('$user').collection('data').add({
      "Name": "$Name",
      "email": email,
      "Add": "$Add",
      "City": "$City",
      "State": "$State",
      "Zip": "$Zip",
      "cnum":"",
      "cname":"",
      "upiid":"",
    }).then((value) => msg = "Success");
    return msg;
  }

  Future<String?> UserUData({cnum,cname,upiid,Name, Add, City, State, Zip,key}) async {
    String? msg;
    String? user = firebaseAuth.currentUser!.uid;
    String? email = firebaseAuth.currentUser!.email;
    await db.collection('user').doc('$user').collection('data').doc('$key').set({
      "Name": "$Name",
      "email": email,
      "Add": "$Add",
      "City": "$City",
      "State": "$State",
      "Zip": "$Zip",
      "cnum":"$cnum",
      "cname":"$cname",
      "upiid":"$upiid",
    }).then((value) => msg = "Success");
    return msg;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> Readuser() {
    String? user = firebaseAuth.currentUser!.uid;
    return db.collection('user').doc('$user').collection('data').snapshots();
  }

  Future<String> signInWithGoogle() async {
    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    String msg="";
    return await firebaseAuth.signInWithCredential(credential).then((value) => msg="success").catchError((e)=> msg="$e");
  }

}
