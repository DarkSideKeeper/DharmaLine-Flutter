import 'package:cloud_firestore/cloud_firestore.dart';

import 'chantChapterModel.dart';

class ChantTopicModel {
  String title;
  String imageName;
  List<ChantChapterModel> chapterModel = [];

  ChantTopicModel(
      String title, String imageName, List<DocumentReference> refChapters) {
    this.title = title;
    this.imageName = imageName;

    refChapters.forEach((ref) {
      ChantChapterModel chapter = TableChantChapterModel.shared.model
          .singleWhere((chapter) => chapter.id == ref.id, orElse: () => null);
      chapterModel.add(chapter);
    });
  }

  String getImageFile() {
    return 'assets/prayer/$imageName';
  }
}
