abstract class SearchState {}

class SearchInitialState extends SearchState {}

class SearchLodingState extends SearchState {}

class SearchScsessState extends SearchState {}

class SearchErrorState extends SearchState {
  String error;
  SearchErrorState({
    required this.error,
  });
}
