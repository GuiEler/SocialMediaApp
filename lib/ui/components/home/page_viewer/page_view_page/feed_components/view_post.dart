import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../../../domain/entities/entities.dart';
import '../../../../../../shared/widget/widget.dart';
import 'content_components/publish_content.dart';
import 'feed_components.dart';
import 'footer_components/publish_footer.dart';

class ViewPost extends StatefulWidget {
  final Size size;
  final Future<UserEntity> publishUser;
  final Future<UserEntity> currentUser;
  final PublishEntity publish;
  final Function() onContentClick;
  final Function() onLikeClick;
  final Function() onUserImageClick;
  final Function() onCommentClick;

  const ViewPost({
    Key? key,
    required this.size,
    required this.publishUser,
    required this.currentUser,
    required this.publish,
    required this.onContentClick,
    required this.onLikeClick,
    required this.onUserImageClick,
    required this.onCommentClick,
  }) : super(key: key);

  @override
  _ViewPostState createState() => _ViewPostState();
}

class _ViewPostState extends State<ViewPost> {
  bool onPressedFavorite = true;
  String testSmimer = "a";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: widget.size.height / 3,
          //color: Colors.grey,
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: widget.size.height * 0.002,
            ),
            child: Container(
              //   color: Colors.red,
              child: testSmimer.isEmpty
                  ? Shimmer.fromColors(
                      baseColor: Theme.of(context).colorScheme.onBackground.withAlpha(60),
                      highlightColor: Colors.grey[100]!,
                      child: Column(children: [
                        ListTile(
                          leading: Container(
                            width: widget.size.width * 0.13,
                            height: widget.size.width * 0.13,
                            decoration: const BoxDecoration(
                              color: Colors.red,
                              shape: BoxShape.circle,
                            ),
                          ),
                          title: Container(
                            color: Colors.red,
                            height: widget.size.width * 0.04,
                            width: widget.size.width * 0.04,
                          ),
                          subtitle: Container(
                            color: Colors.red,
                            height: widget.size.width * 0.04,
                            width: widget.size.width * 0.04,
                          ),
                        ),
                        Container(
                          color: Colors.red,
                          height: widget.size.height * 0.13,
                          width: widget.size.width * 0.91,
                        ),
                        Container(
                          height: 10,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: widget.size.width * 0.048),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                color: Colors.red,
                                height: widget.size.height * 0.03,
                                width: widget.size.width * 0.3,
                              ),
                              SizedBox(
                                width: widget.size.width * 0.1,
                              ),
                              Container(
                                color: Colors.red,
                                height: widget.size.height * 0.03,
                                width: widget.size.width * 0.4,
                              ),
                            ],
                          ),
                        )
                      ]),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FutureBuilder<UserEntity>(
                          future: widget.publishUser,
                          builder: (context, snapshot) {
                            if (snapshot.hasData && snapshot.data != null) {
                              return PublishHeader(
                                publish: widget.publish,
                                user: snapshot.data!,
                                onUserImageClick: () {},
                                size: widget.size,
                              );
                            }
                            return const Center();
                          },
                        ),
                        Expanded(
                          child: PublishContent(
                            onContentClick: widget.onContentClick,
                            content: widget.publish.content,
                          ),
                        ),
                        FutureBuilder<UserEntity>(
                          future: widget.currentUser,
                          builder: (context, snapshot) => PublishFooter(
                            size: widget.size,
                            onLikeClick: widget.onLikeClick,
                            isLiked: widget.publish.uidOfWhoLikedIt.contains(snapshot.data!.uid),
                            favoriteLength: widget.publish.uidOfWhoLikedIt.length,
                            commentLength: widget.publish.comments.length,
                            onCommentClick: widget.onCommentClick,
                          ),
                        )
                      ],
                    ),
            ),
          ),
        ),
        CustomDivider(
          size: widget.size,
          height: 0.015,
        ),
      ],
    );
  }
}
