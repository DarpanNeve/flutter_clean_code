int calculateReadingTime(String text) {
  final words = text.split(' ');
  final wordCount = words.length;
  final readingTime = (wordCount / 200).ceil();
  return readingTime;
}
