import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:icon_broken/icon_broken.dart';
import 'package:social_app/app_cubit/social_cubit.dart';
import 'package:social_app/app_cubit/social_status.dart';
import 'package:social_app/models/post%20model.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit,SocialStates>(
      builder: (BuildContext context, state) {
        return ConditionalBuilder(
            condition:SocialCubit.get(context).posts.length>0 ,
            builder: (context)=>SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: Card(
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      elevation: 5,
                      child: Stack(
                        alignment: Alignment.bottomLeft,
                        children: [
                          const Image(
                            image: NetworkImage(
                                'https://img.freepik.com/premium-photo/friends-having-fun-with-traditional-games_23-2149332682.jpg?w=1060'),
                            height: 250,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                          Text(
                            "communicate with friends",
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 19,
                                shadows: [
                                  Shadow(
                                      color: Colors.blue.withOpacity(0.4),
                                      offset: const Offset(0, 5))
                                ]),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),

                  ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder:(context,index)=>Item(context,SocialCubit.get(context).posts[index],index),
                      separatorBuilder:(context,index)=>Container(
                        height: 7,
                        width: double.infinity,
                        color: Colors.grey[300],
                      ) ,
                      itemCount: SocialCubit.get(context).posts.length)
                ],
              ),
            ),
            fallback: (context)=>Center(child: CircularProgressIndicator()),
        );
      },
      listener: (BuildContext context, Object? state) {  },

    );
  }
}

Widget Item(context,PostModel model,index)=>Card(
  elevation: 10,
  clipBehavior: Clip.antiAliasWithSaveLayer,
  margin: const EdgeInsets.symmetric(horizontal: 8),
  child: Padding(
    padding: EdgeInsets.symmetric(horizontal: 5),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          elevation: 1,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundImage: NetworkImage(
                    "${model.image}",
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "${model.name}",
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall,
                        ),
                        const SizedBox(
                          width: 3,
                        ),
                        const Icon(
                          Icons.check_circle,
                          size: 18,
                          color: Colors.blue,
                        )
                      ],
                    ),
                    Text(
                      "${model.dateTime}",
                      style: Theme.of(context).textTheme.bodySmall,
                    )
                  ],
                ),
                Spacer(),
                IconButton(
                    onPressed: () {}, icon: Icon(Icons.more_horiz))
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${model.text}",
                style: Theme.of(context)
                    .textTheme
                    .headlineSmall
                    ?.copyWith(color: Colors.black, height: 1.3),
              ),

        /*      Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Container(
                  width: double.infinity,
                  child: Wrap(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: Container(
                          height: 25,
                          child: MaterialButton(
                            onPressed: () {},
                            child: Text(
                              "# Flutter developer",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(color: Colors.blue),
                            ),
                            minWidth: 1,
                            padding: EdgeInsets.zero,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: Container(
                          height: 25,
                          child: MaterialButton(
                            onPressed: () {},
                            child: Text(
                              "# Flutter developer",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(color: Colors.blue),
                            ),
                            minWidth: 1,
                            padding: EdgeInsets.zero,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

*/

              //photo
              if(model.postPhoto!="") Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Container(
                    height: 180,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      image: DecorationImage(
                        image: NetworkImage(
                            'https://img.freepik.com/premium-photo/friends-having-fun-with-traditional-games_23-2149332682.jpg?w=1060'),
                        fit: BoxFit.cover,
                      ),
                    )),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        child: Row(
                          children: [
                            const Icon(
                              IconBroken.Heart,
                              size: 18,
                              color: Colors.red,
                            ),
                            SizedBox(
                              width: 7,
                            ),
                            Text(
                              "${SocialCubit.get(context).postsLike[index]}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(fontSize: 15),
                            )
                          ],
                        ),
                        onTap: () {
                          SocialCubit.get(context).postLikes(postId: SocialCubit.get(context).postId[index] );
                        },
                      ),
                    ),



                    Expanded(
                      child: InkWell(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              IconBroken.Chat,
                              size: 18,
                              color: Colors.amber,
                            ),
                            SizedBox(
                              width: 7,
                            ),
                            Text(
                              "120 comment",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge
                                  ?.copyWith(fontSize: 15),
                            )
                          ],
                        ),
                        onTap: () {
                        },
                      ),
                    ),
                  ],
                ),
              ),


              Container(
                height: 1,
                width: double.infinity,
                color: Colors.grey[300],
              ),



              Padding(
                padding: const EdgeInsets.symmetric(vertical: 7.0),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 15,
                              backgroundImage: NetworkImage(
                                "${SocialCubit.get(context).model!.image}",
                              ),
                            ),
                            SizedBox(
                              width: 7,
                            ),
                            Text(
                              "Write a comment",
                              style:
                              Theme.of(context).textTheme.caption,
                            )
                          ],
                        ),
                        onTap: () {},
                      ),
                    ),
                    /*InkWell(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            IconBroken.Heart,
                            size: 18,
                            color: Colors.red,
                          ),
                          SizedBox(
                            width: 7,
                          ),
                          Text(
                            "Like",
                            style:
                            Theme.of(context).textTheme.caption,
                          )
                        ],
                      ),
                      onTap: () {},
                    ),*/
                    SizedBox(width: 12,),
                    InkWell(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Icon(
                            IconBroken.Send,
                            size: 18,
                            color: Colors.red,
                          ),
                          SizedBox(
                            width: 7,
                          ),
                          Text(
                            "Share",
                            style:
                            Theme.of(context).textTheme.caption,
                          )
                        ],
                      ),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  ),
);