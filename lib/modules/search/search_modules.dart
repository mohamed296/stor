import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stor/model/search_model.dart';
import 'package:stor/modules/search/cubit/search_cubit.dart';
import 'package:stor/modules/search/cubit/search_state.dart';
import 'package:stor/shared/widget/defolte_widget.dart';

class SearchModules extends StatelessWidget {
  SearchModules({Key? key}) : super(key: key);
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchState>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = SearchCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              title: SizedBox(
                height: 40,
                child: defoltTextForm(
                    context: context,
                    controler: searchController,
                    valedat: (value) {},
                    oFS: (String value) {
                      cubit.searchForProdect(text: value);
                    },
                    lable: "Search",
                    pIcon: Icons.search,
                    type: TextInputType.name),
              ),
            ),
            body: state is SearchScsessState
                ? ListView.separated(
                    itemBuilder: (context, index) {
                      return prodctItem(
                          cubit.model!.data!.data[index], context);
                    },
                    separatorBuilder: (context, index) {
                      return const SizedBox(
                        height: 10.0,
                      );
                    },
                    itemCount: cubit.model!.data!.data.length)
                : state is SearchLodingState
                    ? const Center(child: CircularProgressIndicator())
                    : const SizedBox(),
          );
        },
      ),
    );
  }

  Widget prodctItem(Data model, context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Image(
              image: NetworkImage(model.image.toString()),
              height: 100,
              width: 120,
              fit: BoxFit.cover,
            ),
            Expanded(
              child: ListTile(
                title: Text(
                  model.name.toString(),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(
                  " ${model.price}",
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

//state is! SearchLodingState?  Container():const Center(child: CircularProgressIndicator(),