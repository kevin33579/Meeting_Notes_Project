part of "models.dart";

class Notes extends Equatable{
  final String notesId;
  final String notesName;
  final String notesData;
  final String createdAt;
  final String updatedAt;

  Notes(
      this.notesId,
      this.notesName,
      this.notesData,
      this.createdAt,
      this.updatedAt,
      );

  @override
  List<Object> get props => [
    notesId,
    notesName,
    notesData,
    createdAt,
    updatedAt,
  ];


}