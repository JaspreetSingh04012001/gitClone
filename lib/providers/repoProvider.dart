import 'package:dio/dio.dart';
import 'package:githubclone/Model/gitRepo.dart';
import 'package:intl/intl.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final fetchReposProvider =
    FutureProvider.autoDispose<List<Repository>>((ref) async {
  var dateTime = DateTime.now();
  var newDate = DateTime(dateTime.year, dateTime.month - 6, dateTime.day);
// newdate is date of six months before

  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  final String formatted = formatter.format(newDate);

  final response = await Dio().get(
      'https://api.github.com/search/repositories?q=created:>$formatted&sort=stars&order=desc');

  final json = await response.data;

  List x = json["items"];
  List<Repository> repos = await x.map((e) => Repository.fromJson(e)).toList();

  return repos;
});
// Tried to use Generator
// Future<List<Repository>> getRepositories(ref) async {
//   final response = await http.get(Uri.https(AppConstants.apibaseurl,
//       'search/repositories?q=created:>2022-04-29&sort=stars&order=desc'));

//   final json = jsonDecode(response.body) as Map<String, dynamic>;
//   List<Repository> repos = [];
//  // repos
// repos =  json["items"].map((e) => Repository.fromJson(e)).toList();

//   return repos;
// }
