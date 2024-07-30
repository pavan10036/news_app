import 'package:flutter_bloc/flutter_bloc.dart';
import '../../model/get_news_model.dart';
import '../../repository/repository.dart';
import 'news_home_state.dart';

class FetchNewsCubit extends Cubit<FetchNewsState> {
  FetchNewsCubit() : super(FetchNewsInitialState());
  Repository repository = Repository();
  Future fetchNews() async {
    try {
      emit(FetchNewsLoadingState());
      GetNewsModel? data = await repository.fetchNews();
      emit(FetchNewsSuccessState(data));
    } catch (err) {
      emit(
        FetchNewsFailureState(
          err.toString(),
        ),
      );
    }
  }
}
