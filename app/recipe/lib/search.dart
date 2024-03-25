import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:recipe/RecipeView.dart';
import 'package:recipe/model.dart';
import 'package:http/http.dart';

class Search extends StatefulWidget {
  String quary;
  Search(this.quary);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  bool isLoading = true;

  List<RecipeModel> recipeList = <RecipeModel>[];

  TextEditingController searchController = new TextEditingController();

  List reciptCatList = [
    {"imgUrl": "https://i.imgur.com/lTPm6va.jpg", "heading": "Chilli Food"},
    {
      "imgUrl":
      "https://plus.unsplash.com/premium_photo-1667682942148-a0c98d1d70db?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      "heading": "Fast Food"
    },
    {
      "imgUrl":
      "https://images.unsplash.com/photo-1527515545081-5db817172677?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      "heading": "Desert"
    },
    {
      "imgUrl":
      "https://images.unsplash.com/photo-1550951791-cbf1ff280109?q=80&w=1935&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      "heading": "Sea Food"
    },
    {
      "imgUrl":
      "https://images.unsplash.com/photo-1606728035253-49e8a23146de?q=80&w=2070&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      "heading": "Non-veg"
    },
    {
      "imgUrl":
      "https://images.unsplash.com/photo-1468465236047-6aac20937e92?q=80&w=1883&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
      "heading": "Beverages"
    },
    {
      "imgUrl":
      "https://images.unsplash.com/photo-1626711934535-9749ea30dba8?q=80&w=1887&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D",
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
      RecipeModel recipeModel = new RecipeModel();
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
    getRecipe(widget.quary);
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
                    stops: [0.4, 0.6],
                    colors: [Colors.green[700]!, Colors.green[400]!])),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                //search bar
                SafeArea(
                  child: Container(
                    // search wala container
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    margin: EdgeInsets.symmetric(horizontal: 21, vertical: 18),
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
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Search(searchController.text)));
                            }
                          },
                          child: Container(
                            margin: EdgeInsets.fromLTRB(3, 0, 7, 0),
                            child: Icon(
                              Icons.search,
                              color: Colors.blueAccent,
                            ),
                          ),
                        ),
                        Expanded(
                          child: TextField(
                            controller: searchController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Let's Cook something ",
                            ),
                          ),
                        ),
                      ],
                    ),
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

                Container(
                    child: isLoading
                        ? CircularProgressIndicator()
                        : ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: recipeList.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                             Navigator.push(context, MaterialPageRoute(builder: (context)=>RecipeView(recipeList[index].appurl)));
                              },
                            child: Card(
                              margin: EdgeInsets.all(10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              elevation: 0.0,
                              child: Stack(
                                children: [
                                  ClipRRect(
                                      borderRadius:
                                      BorderRadius.circular(10.0),
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
                                          padding: EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 10),
                                          decoration: BoxDecoration(
                                            color: Colors.black26,
                                            borderRadius: BorderRadius.only(
                                              bottomRight:
                                              Radius.circular(10),
                                              bottomLeft:
                                              Radius.circular(10),
                                            ),
                                          ),
                                          child: Text(
                                            recipeList[index].applable,
                                            style: TextStyle(
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
                                        decoration: BoxDecoration(
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
                                              Icon(
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


              ],
            ),
          )
        ],
      ),
    );
  }
}
