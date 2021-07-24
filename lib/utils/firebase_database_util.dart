import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:catatan_harian/models/diary_model.dart';

class FirebaseDatabaseUtil {
  late DatabaseReference _diarysRef;
  FirebaseDatabase database = new FirebaseDatabase(
      databaseURL:
          "https://catatan-harian-f16d5-default-rtdb.asia-southeast1.firebasedatabase.app");
  late DatabaseError error;

  static final FirebaseDatabaseUtil _instance =
      new FirebaseDatabaseUtil.internal();
  FirebaseAuth auth = FirebaseAuth.instance;

  FirebaseDatabaseUtil.internal();

  factory FirebaseDatabaseUtil() {
    return _instance;
  }

  void initState() {
    _diarysRef =
        database.reference().child('/diarys').child(auth.currentUser!.uid);
    print(_diarysRef);
    database.setPersistenceEnabled(true);
    database.setPersistenceCacheSizeBytes(10000000);
  }

  DatabaseError getError() {
    return error;
  }

  DatabaseReference getdiarys() {
    return _diarysRef;
  }

  adddiary(DiaryModel diary) async {
    print(_diarysRef.push());
    await _diarysRef.push().set(<String, String>{
      "title": diary.title,
      "content": diary.content,
    }).then((_) {
      print("asdsaddasdasasd");
      print('Transaction  committed.');
    }).catchError((e) {
      print("database $e");
    });
  }

  void deletediary(DiaryModel diary) async {
    await _diarysRef.child(diary.uid).remove().then((_) {
      print('Transaction  committed.');
    });
  }

  void updatediary(DiaryModel diary) async {
    print("update");
    await _diarysRef.child(diary.uid).update({
      "title": diary.title,
      "content": diary.content,
    }).then((_) {
      print('Transaction  committed.');
    });
  }
}
