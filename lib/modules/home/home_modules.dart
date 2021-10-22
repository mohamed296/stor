import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stor/model/category_model.dart';
import 'package:stor/model/home_model.dart';

import 'package:stor/shared/provider/cubit.dart';
import 'package:stor/shared/provider/state.dart';
import 'package:stor/shared/widget/defolte_widget.dart';

class HomeMedules extends StatelessWidget {
  const HomeMedules({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StorCubit, StorState>(
      listener: (context, state) {
        if (state is ChangeFavoritScassesState) {
          if (state.model.status == false) {
            toastShow(
                mass: state.model.massges!.toString(),
                state: ToastStatus.ERROR);
          }
        }
      },
      builder: (context, state) {
        var cubit = StorCubit.get(context);
        return cubit.model != null && cubit.cModel != null
            ? body(cubit.model!, cubit.cModel!, context, cubit)
            : const Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }

  Widget body(HomeModel model, CategoryModel cModel, context, StorCubit cubit) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
              items: model.data!.banners.map((e) {
                return Image(
                  image: NetworkImage(e.image!),
                  fit: BoxFit.cover,
                );
              }).toList(),
              options: CarouselOptions(
                  height: 250.0,
                  initialPage: 0,
                  viewportFraction: 1.0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(seconds: 2),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  scrollDirection: Axis.horizontal)),
          const SizedBox(
            height: 20.0,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Categories",
                    style: Theme.of(context).textTheme.headline4!.copyWith(
                        color: Theme.of(context).colorScheme.primary)),
                const SizedBox(
                  height: 20.0,
                ),
                SizedBox(
                  height: 120,
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return categoriItem(cModel.data!.data[index]);
                      },
                      separatorBuilder: (context, index) => const SizedBox(
                            width: 10.0,
                          ),
                      itemCount: cModel.data!.data.length),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Text("New Prodact",
                    style: Theme.of(context).textTheme.headline4!.copyWith(
                        color: Theme.of(context).colorScheme.primary)),
                const SizedBox(
                  height: 20.0,
                ),
              ],
            ),
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: MediaQuery.of(context).size.width * 0.5,
                mainAxisSpacing: 0.0,
                crossAxisSpacing: 0.0,
                childAspectRatio: 1 / 1.5),
            itemBuilder: (context, index) {
              return prodectItem(model.data!.products[index], context, cubit);
            },
            itemCount: model.data!.products.length,
          ),
        ],
      ),
    );
  }

  Widget categoriItem(DataModel model) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Image(
            image: NetworkImage(model.image!),
            height: 120,
            width: 120,
            fit: BoxFit.cover),
        Container(
            width: 120.0,
            color: Colors.black.withOpacity(0.5),
            child: Text(
              model.name!,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white),
            )),
      ],
    );
  }

  Widget prodectItem(ProductModel model, context, StorCubit cubit) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Image(
              image: NetworkImage(model.image!),
              height: 150,
            ),
            const SizedBox(
              height: 10.0,
            ),
            SizedBox(
              height: 50,
              child: Text(
                model.name!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Row(
              children: [
                Text("${model.price}"),
                const SizedBox(
                  width: 2.0,
                ),
                if (model.oldPrice != 0)
                  Text(
                    "${model.oldPrice}",
                    style: const TextStyle(
                        decoration: TextDecoration.lineThrough,
                        color: Colors.grey),
                  ),
                const Spacer(),
                IconButton(
                    onPressed: () {
                      cubit.changeFavorit(model.id!);
                    },
                    icon: cubit.isFavorit[model.id] != null &&
                            cubit.isFavorit[model.id] == true
                        ? Icon(
                            Icons.favorite,
                            color: Theme.of(context).colorScheme.primary,
                            size: 35,
                          )
                        : const Icon(
                            Icons.favorite_border_outlined,
                            size: 35,
                          ))
              ],
            )
          ],
        ),
      ),
    );
  }
}
