import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:githubclone/Model/gitRepo.dart';
import 'package:githubclone/providers/repoProvider.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

final counterProvider = StateProvider<int>((ref) {
  return 0;
});

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, ref) {
    int n = ref.watch(counterProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Git hub by Jass',
      theme: ThemeData(
          fontFamily: 'MonaSans',
          primaryColor: const Color(0xFF0a8341),
          secondaryHeaderColor: const Color(0xFFbfdeff),
          disabledColor: const Color(0xffa2a7ad),
          brightness: Brightness.dark,
          hintColor: const Color(0xFFbebebe),
          shadowColor: Colors.black.withOpacity(0.4),
          cardColor: const Color(0xFF334257).withOpacity(0.27),
          textTheme: const TextTheme(
            titleLarge: TextStyle(color: Color(0xFF8e9fb9)),
            titleSmall: TextStyle(color: Color(0xFFe4e8ef)),
          ),
          textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                  foregroundColor: const Color(0xFFcda335))),
          appBarTheme: const AppBarTheme(backgroundColor: Color(0x4D334257)),
          colorScheme: const ColorScheme.dark(
                  primary: Color(0xFFcda335), secondary: Color(0xFFcda335))
              .copyWith(background: const Color(0xFF212326))
              .copyWith(error: const Color(0xFFdd3135))),
      home: const MyHomePage(title: 'GitHub'),
    );
  }
}

/// The homepage of our application
// class Home extends StatelessWidget {
//   const Home({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Consumer(
//       builder: (context, ref, child) {

//         final AsyncValue<List<Repository>> activity = ref.watch(fetchReposProvider);

//         return Center(

//           child: switch (activity) {
//             AsyncData(:final value) => Text('Activity: ${value}'),
//             AsyncError() => const Text('Oops, something unexpected happened'),
//             _ => const CircularProgressIndicator(),
//           },
//         );
//       },
//     );
//   }
// }
class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context, ref) {
    final AsyncValue<List<Repository>> activity = ref.watch(fetchReposProvider);
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 13, 17, 23),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                "assets/icons/gitlogo.png",
                height: 26,
                color: Colors.white,
              ),
              Gap(10),
              Text(title),
            ],
          ),
        ),
        body: Center(
          child: switch (activity) {
            AsyncData(:final value) => ListView.builder(
                itemCount: value.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              Image.asset(
                                "assets/icons/1_w07Er4gPg8H2Ew-P0HhxNA.webp",
                                // color: Color.fromARGB(255, 179, 177, 177),
                                height: 15,
                              ),
                              Gap(10),
                              Expanded(
                                child: Text(
                                  overflow: TextOverflow.ellipsis,
                                  value[index].name,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromARGB(255, 47, 129, 247),
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: Color.fromARGB(255, 48, 54, 61)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 8),
                                  child: Text(
                                    value[index].visibility,
                                  ),
                                ),
                              )
                            ],
                          ),
                          Gap(5),
                          Row(
                            children: [
                              Icon(
                                size: 18,
                                Icons.calendar_month_rounded,
                                color: Color.fromARGB(255, 179, 177, 177),
                              ),
                              Gap(5),
                              Text(
                                "${value[index].updatedAt.day}/${value[index].updatedAt.month}/${value[index].updatedAt.year}  ${value[index].updatedAt.hour} : ${value[index].updatedAt.minute}",
                                //  overflow: TextOverflow.ellipsis,
                                softWrap: true,
                                style: TextStyle(
                                  fontWeight: FontWeight.w200,
                                  color: Color.fromARGB(255, 179, 177, 177),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Text(
                              value[index].description ??
                                  "No description available",
                              //  overflow: TextOverflow.ellipsis,
                              softWrap: true,
                              style: TextStyle(
                                fontWeight: FontWeight.w200,
                                color: Color.fromARGB(255, 179, 177, 177),
                              ),
                            ),
                          ),
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: Color.fromARGB(255, 13, 17, 23),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 3, horizontal: 5),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        height: 24,
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(22),
                                          child: Image.network(
                                            value[index].owner.avatarUrl,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Gap(8),
                                      // CachedNetworkImage(
                                      //   imageUrl: value[index].owner.avatarUrl,
                                      //   imageBuilder: (context, imageProvider) =>
                                      //       Container(
                                      //     decoration: BoxDecoration(
                                      //       image: DecorationImage(
                                      //           image: imageProvider,
                                      //           fit: BoxFit.cover,
                                      //           colorFilter: ColorFilter.mode(
                                      //               Colors.red, BlendMode.colorBurn)),
                                      //     ),
                                      //   ),
                                      //   placeholder: (context, url) =>
                                      //       CircularProgressIndicator(),
                                      //   errorWidget: (context, url, error) =>
                                      //       Icon(Icons.error),
                                      // ),
                                      Text(
                                        overflow: TextOverflow.ellipsis,
                                        value[index].owner.login,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color:
                                              Color.fromARGB(255, 47, 129, 247),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Gap(8),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color: Color.fromARGB(255, 13, 17, 23),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 3, horizontal: 5),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.star_border_rounded,
                                        color: Color.fromARGB(255, 48, 54, 61),
                                      ),
                                      Gap(10),
                                      Text(
                                        "Stars",
                                      ),
                                      Gap(10),
                                      Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            color: Color.fromARGB(
                                                255, 48, 54, 61)),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 3, horizontal: 8),
                                          child: Text(
                                            value[index]
                                                    .stargazersCount
                                                    .toString() ??
                                                "0",
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      decoration: BoxDecoration(
                        border: Border.all(width: 0.1, color: Colors.white),
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                        color: Color.fromARGB(255, 22, 27, 34),
                      ),
                      // height: 100,
                      width: 100,
                    ),
                  );
                }),
            AsyncError() => const Text('Oops, something unexpected happened'),
            _ => const CircularProgressIndicator(),
          },
        ));
  }
}
