import 'package:cloud_firestore/cloud_firestore.dart';

final db = Firestore.instance;

Future<void> addNewWork(work) async {
  await db
      .collection('Todo')
      .document(work['id'])
      .setData(work)
      .catchError((e) => print(e));
}

Future<dynamic> getAllWork() async {
  return db.collection('Todo').orderBy('timestamp', descending: false).snapshots();
}

removeWork(String id) async {
  return await db.collection('Todo').document(id).delete();
}

doneWork(String id) async {
  return await db.collection('Todo').document(id).updateData({'isDone': true});
}

changeFavourite(String id, bool isFavourite) async {
  return await db.collection('Todo').document(id).updateData({'isFavourite': isFavourite});
}

Future<dynamic> getFavouriteWork() async {
  return db.collection('Todo').where('isFavourite', isEqualTo: true).snapshots();
}

Future<dynamic> getDoneWork() async {
  return db.collection('Todo').where('isDone', isEqualTo: true).snapshots();
}
