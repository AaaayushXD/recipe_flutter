import 'package:flutter/material.dart';
import 'package:flutter_project/models/recipe.dart';
import 'package:flutter_project/pages/recipe_page.dart';
import 'package:flutter_project/services/auth_service.dart';
import 'package:flutter_project/services/data_service.dart';
import 'package:status_alert/status_alert.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  String _mealTypeFilter = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _title(),
        actions: [
          _logOutButton(),
        ],
        actionsIconTheme: const IconThemeData(color: Colors.red),
      ),
      body: SafeArea(child: _buildUi()),
    );
  }

  Widget _logOutButton() {
    return IconButton(
      onPressed: () async {
        bool res = await AuthService().logout();
        if (res) {
          Navigator.pushReplacementNamed(context, '/login');
        } else {
          StatusAlert.show(context,
              duration: const Duration(seconds: 2),
              title: "Log out failed",
              subtitle: "Please try again",
              configuration: const IconConfiguration(icon: Icons.done),
              maxWidth: 260,
              backgroundColor: Colors.red);
        }
      },
      icon: const Icon(Icons.login),
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

  Widget _buildUi() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(children: [
        const SizedBox(
          height: 10,
        ),
        _recipeTypeButtons(),
        _recipeList()
      ]),
    );
  }

  Widget _recipeTypeButtons() {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.05,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: FilledButton(
                onPressed: () {
                  setState(() {
                    _mealTypeFilter = "";
                  });
                },
                child: const Text("All")),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: FilledButton(
                onPressed: () {
                  setState(() {
                    _mealTypeFilter = "breakfast";
                  });
                },
                child: const Text("🍳 Breakfast")),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: FilledButton(
                onPressed: () {
                  setState(() {
                    _mealTypeFilter = "snack";
                  });
                },
                child: const Text("🍟 Snack")),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: FilledButton(
                onPressed: () {
                  setState(() {
                    _mealTypeFilter = "lunch";
                  });
                },
                child: const Text("🥟 Lunch")),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: FilledButton(
                onPressed: () {
                  setState(() {
                    _mealTypeFilter = "dinner";
                  });
                },
                child: const Text("🍛 Dinner")),
          ),
        ],
      ),
    );
  }

  Widget _recipeList() {
    return Expanded(
        child: FutureBuilder(
            future: DataService().getRecipe(_mealTypeFilter),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return const Center(child: Text("Unable to Load data."));
              }
              return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  Recipe recipe = snapshot.data![index];
                  return ListTile(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return RecipePage(
                          recipe: recipe,
                        );
                      }));
                    },
                    contentPadding: const EdgeInsets.only(top: 20.0),
                    leading: Image.network(recipe.image ?? ""),
                    title: Text(recipe.name ?? ""),
                    subtitle: Text(
                        "${recipe.cuisine}\nDifficulty: ${recipe.difficulty}"),
                    trailing: Text(
                      "${recipe.rating} ⭐",
                      style: const TextStyle(fontSize: 15),
                    ),
                  );
                },
              );
            }));
  }
}
