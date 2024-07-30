import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/view/widgets/text_widget.dart';
import '../../../bloc/news_home_bloc/news_home_cubit.dart';
import '../../../bloc/news_home_bloc/news_home_state.dart';
import '../../../constants/constant_strings.dart';

class MyNewsScreen extends StatefulWidget {
  const MyNewsScreen({super.key});

  @override
  State<MyNewsScreen> createState() => _MyNewsScreenState();
}

class _MyNewsScreenState extends State<MyNewsScreen> {
  @override
  void initState() {
    context.read<FetchNewsCubit>().fetchNews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: TextWidget(
          ConstantStrings.myNewsString,
          20,
          Colors.white,
          FontWeight.bold,
        ),
      ),
      body: BlocConsumer<FetchNewsCubit, FetchNewsState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is FetchNewsLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is FetchNewsSuccessState) {
            return Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TextWidget(ConstantStrings.topHeadString, 16, Colors.black,
                      FontWeight.bold),
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.data?.articles?.length,
                      itemBuilder: (BuildContext context, int index) {
                        return state.data?.articles?[index].source?.name != null
                            ? Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            TextWidget(
                                                state.data?.articles?[index]
                                                    .source?.name,
                                                14,
                                                Colors.black,
                                                FontWeight.bold),
                                            TextWidget(
                                              state.data?.articles?[index]
                                                  .content,
                                              10,
                                              null,
                                              null,
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                        ),
                                        width: 100,
                                        height: 120,
                                        child: state.data?.articles?[index]
                                                    .urlToImage !=
                                                null
                                            ? Image.network(
                                                state.data?.articles?[index]
                                                        .urlToImage
                                                        .toString() ??
                                                    "",
                                                fit: BoxFit.fill,
                                              )
                                            : Container(
                                                color: Colors.orange,
                                              ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            : Container();
                      },
                    ),
                  ),
                ],
              ),
            );
          } else if (state is FetchNewsFailureState) {
            return TextWidget(state.err.toString(), 18, Colors.black, null);
          } else {
            return Container();
          }
        },
      ),
    );
  }
}
