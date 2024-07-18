import 'package:flutter/material.dart';
import 'package:flutter_project/models/recipe.dart';

class RecipePage extends StatelessWidget {
  final Recipe recipe;
  const RecipePage({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: _title(),
        centerTitle: true,
      ),
      body: SafeArea(child: _buildUI(context)),
    );
  }

  Widget _title() {
    return const SizedBox(
        width: 80,
        height: 80,
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Image(image: AssetImage("Assets/images/Fx.png")),
        ));
  }

  Widget _buildUI(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _recipeImage(context),
          _recipeDetail(context),
          _recipeIngredient(context),
          _recipeInstruction(context),
          _footer(context)
        ],
      ),
    );
  }

  Widget _recipeImage(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.40,
      width: MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(
          image: DecorationImage(
              fit: BoxFit.cover, image: NetworkImage(recipe.image ?? ""))),
    );
  }

  Widget _recipeDetail(BuildContext context) {
    return Container(
      color: Colors.white,
      width: MediaQuery.sizeOf(context).width,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${recipe.cuisine}, ${recipe.difficulty}",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w300,
              ),
            ),
            Text(
              "${recipe.name}",
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              "Prep time: ${recipe.prepTimeMinutes}mins | Cook time: ${recipe.cookTimeMinutes}mins",
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w300,
              ),
            ),
            Text(
              " ${recipe.rating} ⭐ | ${recipe.reviewCount} Reviews",
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _recipeIngredient(BuildContext context) {
    return Container(
        color: Colors.white,
        width: MediaQuery.sizeOf(context).width,
        child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
            child: Column(
              children: recipe.ingredients!.map((i) {
                return Row(
                  children: [const Icon(Icons.check_box), Text(" $i")],
                );
              }).toList(),
            )));
  }

  Widget _recipeInstruction(BuildContext context) {
    return Container(
        color: Colors.white,
        width: MediaQuery.sizeOf(context).width,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 15.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: recipe.instructions!.map((i) {
              return Text(
                "${recipe.instructions!.indexOf(i)}. $i\n",
                maxLines: 3,
                textAlign: TextAlign.start,
                style: const TextStyle(
                  fontSize: 15,
                ),
              );
            }).toList(),
          ),
        ));
  }

  Widget _footer(BuildContext context) {
    return Container(
      color: Colors.grey.shade200,
      width: MediaQuery.sizeOf(context).width,
      child: const Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Center(
          child: Text(
            "Copyright ©️ Aayush",
            style: TextStyle(color: Colors.black, fontSize: 12),
          ),
        ),
      ),
    );
  }
}
