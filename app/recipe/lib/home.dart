import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:recipe/RecipeView.dart';
import 'package:recipe/model.dart';
import 'package:recipe/search.dart';
import 'package:http/http.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  bool isLoading = true;


  List<RecipeModel> recipeList = <RecipeModel>[];

  TextEditingController searchController = TextEditingController();

  List reciptCatList = [
    {
      "imgUrl": "https://i.imgur.com/lTPm6va.jpg",
      "heading": "Chilli Food"
    },
    {
      "imgUrl": "https://plus.unsplash.com/premium_photo-1667682942148-a0c98d1d70db?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      "heading": "Fast"
    },
    {
      "imgUrl": "https://images.unsplash.com/photo-1527515545081-5db817172677?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      "heading": "Desert"
    },
    {
      "imgUrl": "https://images.unsplash.com/photo-1550951791-cbf1ff280109?q=80&w=1935&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      "heading": "Sea Food"
    },
    {
      "imgUrl": "https://images.unsplash.com/photo-1606728035253-49e8a23146de?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      "heading": "Chiken"
    },
    {
      "imgUrl": "https://images.unsplash.com/photo-1468465236047-6aac20937e92?q=80&w=1883&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      "heading": "Beverages"
    },
    {
      "imgUrl": "https://images.unsplash.com/photo-1626711934535-9749ea30dba8?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      "heading": "Salad"
    }
  ];

  //api link
  getRecipe(String query) async {
    String url =
        "https://api.edamam.com/search?q=$query&app_id=786d89db&app_key=98036dc21c26bbd0d8693276db265069";
    Response response = await get(Uri.parse(url));
    Map data = jsonDecode(response.body);

    data["hits"].forEach((element) {
      RecipeModel recipeModel = RecipeModel();
      recipeModel = RecipeModel.fromMap(element["recipe"]);
      recipeList.add(recipeModel);
      setState(() {
        isLoading = false;
      });
      log(recipeModel.toString());
    });

   recipeList.forEach((Recipe) {
      print(Recipe.applable);
      print(Recipe.appcalories);
    });
  }



// first auto search for food

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getRecipe("ladoo");



  }



  @override
  Widget build(BuildContext context) {
    // //search  bar random dish
    // var dish_name = ["Dhokla","Litti Chokha","Fish Curry","Maggi","Samosa","Dhosa","Idli","Paneer","Momos"];
    // final _random = new Random();
    // var dish = dish_name[_random.nextInt(dish_name.length)];

    return Scaffold(
        body: Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  stops: const [0.4, 0.6],
                  colors: [Colors.green[700]!, Colors.green[400]!])),
        ),
        SingleChildScrollView(
          child: Column(
            children: [
              //search bar
              SafeArea(
                child: Container(
                  // search wala container
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  margin: const EdgeInsets.symmetric(horizontal: 21, vertical: 18),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(25)),

                  child: Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          if ((searchController.text).replaceAll(" ", " ") ==
                              "") {
                            print("blank search");
                          } else {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Search(searchController.text)));
                          }
                        },
                        child: Container(
                          margin: const EdgeInsets.fromLTRB(3, 0, 7, 0),
                          child: const Icon(
                            Icons.search,
                            color: Colors.blueAccent,
                          ),
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          controller: searchController,
                          textInputAction: TextInputAction.search,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: "Let's Cook something ",
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("WHAT DO YOU WANT TO COOK TODAY?",
                        style: TextStyle(fontSize: 33, color: Colors.white)),
                    SizedBox(
                      height: 10,
                    ),
                    Text("Let's Cook Something New!",
                        style: TextStyle(fontSize: 20, color: Colors.white))
                  ],
                ),
              ),

              /*
        ----- //container//

        ------  // listview . builder //   ---- imp(shrinkwrap,,itemcount,,itembuiler)
        //item builder//--//return inkwell//

        ---- //InkWell// -- tap, doubleTap , etc
                        hower - color
                        tap - splash

        * ----- gesture dector - swipe

          ----- //card// - elevation background color, radious child

          ------ --// stack // --

          ----- //ClipRRect// - work as frame(click round rectangle)

          ----- ClipPath -- custom frame or clips - triangle , rectangle ,etc

          ----- positioned  ---topleft . top , down ,left
        */

              Center(
                child: Container(
                    child: isLoading ? const CircularProgressIndicator() : ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: recipeList.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                             Navigator.push(context, MaterialPageRoute(builder: (context)=>RecipeView(recipeList[index].appurl)));
                            },
                            child: Card(
                              margin: const EdgeInsets.all(10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              elevation: 0.0,
                              child: Stack(
                                children: [
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(10.0),
                                      child: Image.network(
                                        recipeList[index].appimgUrl,
                                        fit: BoxFit.cover,
                                        width: double.infinity,
                                        height: 200,
                                      )),

                                  //position for label(name) container
                                  Positioned(
                                      left: 0,
                                      right: 0,
                                      bottom: 0,
                                      child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 10),
                                          decoration: const BoxDecoration(
                                              color: Colors.black26,
                                            borderRadius: BorderRadius.only(
                                              bottomRight: Radius.circular(10),
                                              bottomLeft: Radius.circular(10),
                                            ),),

                                          child: Text(
                                            recipeList[index].applable,
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 19,
                                            ),
                                          ))),

                                  //position for calore container
                                  Positioned(
                                    right: 0,
                                    width: 80,
                                    height: 40,
                                    child: Container(
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(10),
                                          ),
                                        ),
                                        child: Center(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              const Icon(
                                                Icons.local_fire_department,
                                                size: 18,
                                              ),
                                              Text(recipeList[index]
                                                  .appcalories
                                                  .toString()
                                                  .substring(0, 6)),
                                            ],
                                          ),
                                        )),
                                  )
                                ],
                              ),
                            ),
                          );
                        })),
              ),

              Container(
                height: 100,
                child:   ListView.builder(
                    itemCount: reciptCatList.length,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return Container(
                        child: InkWell(
                          onTap: () {
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Search(reciptCatList[index]["heading"])));
                          },
                          child: Card(
                            margin: const EdgeInsets.all(20),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                            elevation: 0.0,
                            child: Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(18.0),
                                  child: Image.network(
                                    reciptCatList[index]["imgUrl"],
                                    fit: BoxFit.cover,
                                    width: 200,
                                    height: 250,
                                  ),
                                ),
                                Positioned(
                                    left: 0,
                                    right: 0,
                                    top: 0,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 10),
                                      decoration:
                                          BoxDecoration(color: Colors.black26,borderRadius: BorderRadius.circular(18.0)),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            reciptCatList[index]["heading"],
                                            style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 28),
                                          ),
                                        ],
                                      ),
                                    )),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
              )
            ],
          ),
        )
      ],
    ));
  }
}
