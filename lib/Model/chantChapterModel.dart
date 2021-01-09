class TableChantChapterModel {
  static TableChantChapterModel shared = TableChantChapterModel();

  List<ChantChapterModel> model = [];
}

class ChantChapterModel {
  String id;
  String title;
  String audioFileName;
  List<String> chapters;
  List<String> meanings;

  ChantChapterModel(
      {this.id, this.title, this.audioFileName, this.chapters, this.meanings});

  String getPathAudioFile() {
    return 'assets/audio/$audioFileName';
  }
}
