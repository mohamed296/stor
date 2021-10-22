import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stor/modules/search/search_modules.dart';
import 'package:stor/shared/provider/cubit.dart';
import 'package:stor/shared/provider/state.dart';
import 'package:stor/shared/widget/defolte_widget.dart';

class ShopLayoutScrean extends StatelessWidget {
  const ShopLayoutScrean({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StorCubit()
        ..getProdect()
        ..getCategory()
        ..getFavoritProdct()
        ..getProfile(),
      child: BlocConsumer<StorCubit, StorState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Home"),
              actions: [
                IconButton(
                  onPressed: () {
                    navigateTo(context, SearchModules());
                  },
                  icon: const Icon(
                    Icons.search,
                  ),
                ),
              ],
            ),
            body: StorCubit.get(context)
                .screan[StorCubit.get(context).currentIndex],
            bottomNavigationBar: BottomNavigationBar(
                currentIndex: StorCubit.get(context).currentIndex,
                onTap: (index) {
                  StorCubit.get(context).changeBottom(index: index);
                },
                items: const [
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.home,
                      ),
                      label: "HOME"),
                  BottomNavigationBarItem(
                      icon: Icon(Icons.apps_outlined), label: "CATEGORY"),
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.favorite,
                      ),
                      label: "FAVORITE"),
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.settings,
                      ),
                      label: "SETTINGS"),
                ]),
          );
        },
      ),
    );
  }
}
