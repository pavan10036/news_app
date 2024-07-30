import 'package:equatable/equatable.dart';
import '../../model/get_news_model.dart';

class FetchNewsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchNewsSuccessState extends FetchNewsState {
  GetNewsModel? data;
  FetchNewsSuccessState(this.data);
}

class FetchNewsInitialState extends FetchNewsState {}

class FetchNewsLoadingState extends FetchNewsState {}

class FetchNewsFailureState extends FetchNewsState {
  String? err;
  FetchNewsFailureState(this.err);
}
