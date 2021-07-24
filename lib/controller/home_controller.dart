import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:catatan_harian/utils/firebase_database_util.dart';
import 'package:catatan_harian/utils/toast_util.dart';

class HomeController extends GetxController {
  late FirebaseDatabaseUtil databaseUtil;
  @override
  void onInit() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        Get.offAllNamed("/auth/login");
      } else {
        print("data $user");
      }
    });
    databaseUtil = new FirebaseDatabaseUtil();
    databaseUtil.initState();
    super.onInit();
  }

  void logout() {
    showDialog(
        context: Get.context!,
        builder: (BuildContext context) => AlertDialog(
              title: Text("Konfirmasi logout"),
              content: Text("Yakin ingin keluar?"),
              actions: [
                TextButton(
                  child: Text("Batal"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                TextButton(
                  child: Text("Ya"),
                  onPressed: () {
                    logoutProc();
                  },
                ),
              ],
            ));
  }

  Future<void> logoutProc() async {
    await FirebaseAuth.instance.signOut();
    Get.offAllNamed("/auth/login");
    ToastUtil.success(message: "Anda berhasil logout");
  }
}
