import 'package:get/get.dart';

class DetailController extends GetxController
{
  RxInt i =1.obs;

  void AddI()
  {
    i++;
  }

  void RemoveI()
  {
    if(i.value>1)
      {
        i--;
      }
  }
}