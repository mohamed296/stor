import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stor/model/category_model.dart';
import 'package:stor/shared/provider/cubit.dart';
import 'package:stor/shared/provider/state.dart';

class CategoryMedules extends StatelessWidget {
  const CategoryMedules({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<StorCubit, StorState>(
      listener: (context, state) {},
      builder: (context, state) {
        return StorCubit.get(context).cModel != null
            ? ListView.separated(
                itemBuilder: (context, index) {
                  return categoryItem(
                      StorCubit.get(context).cModel!.data!.data[index],
                      context);
                },
                separatorBuilder: (context, index) => const SizedBox(
                      height: 10.0,
                    ),
                itemCount: StorCubit.get(context).cModel!.data!.data.length)
            : const Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }

  Widget categoryItem(DataModel model, context) {
    return Card(
      child: ListTile(
        leading: Image(
          image: NetworkImage(model.image!),
          fit: BoxFit.cover,
          width: 50,
        ),
        title: Text(
          model.name!,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        trailing: const Icon(
          Icons.keyboard_arrow_right_outlined,
          size: 35.0,
        ),
      ),
    );
  }
}
