part of 'services.dart';

class NotesServices{

  static CollectionReference notesCollection = FirebaseFirestore.instance.collection("notes");
  static DocumentReference notesDocument;

  static Reference ref;
  static UploadTask uploadTask;

  static Future<bool> addNotes(Notes notes)async{
    await Firebase.initializeApp();
    String dateNow = ActivityServices.dateNow();
    notesDocument = await notesCollection.add({
      'notesId' : notes.notesId,
      'notesName' : notes.notesName,
      'notesData' : notes.notesData,
      'createdAt' : dateNow,
      'updatedAt' : dateNow,
    });
    if(notesDocument != null){

      notesCollection.doc(notesDocument.id).update(
        {

        });
      return true;
    }else {
      return false;
    }
  }


}