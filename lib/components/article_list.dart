import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jianshu/pages/article_detail_page.dart';
import 'package:jianshu/utils/event_bus.dart';
import 'package:nav_router/nav_router.dart';

class ArticleList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ArticleListState();
}

class _ArticleListState extends State<ArticleList> {
  /// 标题样式
  TextStyle titleStyle = TextStyle(
      color: Color(0xff252525),
      fontSize: 30.sp,
      fontWeight: FontWeight.w600
  );

  /// 描述样式
  TextStyle descStyle = TextStyle(
      fontSize: 26.sp,
      height: 1.5,
      color: Color(0xff515151)
  );

  /// 文章底部栏文字按钮
  TextStyle bottomBarTextStyle = TextStyle(
      fontSize: 22.sp,
      color: Color(0xff999999)
  );

  /// 刷新加载器
  GlobalKey<RefreshIndicatorState> refreshIndicator = GlobalKey();

  List alist = [
    'A', 'B', 'C', 'B', 'A', 'B', 'C'
  ];

  /// 上一次滚动的距离
  double offsetPixels = 0.0;

  /// 当前滚动方向（相对于上次滚动的方向）
  String scrollDirection = '';

  Future<void> refreshData () {

  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334, allowFontScaling: false);

    return RefreshIndicator(
      key: refreshIndicator,
      onRefresh: refreshData,
      color: Theme.of(context).primaryColor,
      child: NotificationListener<ScrollNotification>(
        child: ListView(
          physics: const AlwaysScrollableScrollPhysics(),
          children: alist.map((item) {
            Widget articleComponent;
            switch (item) {
              case 'A':
                articleComponent = _buildArticleTypeA(context);
                break;
              case 'B':
                articleComponent = _buildArticleTypeB(context);
                break;
              case 'C':
                articleComponent = _buildArticleTypeC(context);
                break;
            }

            return articleComponent;
          }).toList(),
        ),
        onNotification: (ScrollNotification scrollNotification) {
          if (scrollNotification is ScrollUpdateNotification && scrollNotification.depth == 0) {
            double pixels = scrollNotification.metrics.pixels;
            if (pixels > offsetPixels) {
              // 这边处理向下滚动的逻辑
              if (scrollDirection != 'down') {
                eventBus.fire(HomeScrollDirectionEvent('down'));
                scrollDirection = 'down';
              }
            } else {
              // 这边处理向上滚动的逻辑
              if (scrollDirection != 'up') {
                eventBus.fire(HomeScrollDirectionEvent('up'));
                scrollDirection = 'up';
              }
            }
            /// 记录一下当前滚动的距离
            offsetPixels = pixels;
          }
          return true;
        },
      ),
    );
  }

  /// 构建文章模板
  Widget _buildArticleComponent (BuildContext context) {
    Widget article;

    article = _buildArticleTypeA(context);

    return article;
  }

  /// 文章类型A (只有文字)
  Widget _buildArticleTypeA (BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        bottom: 20.w
      ),
      child: Material(
        color: Colors.white,
        child: Ink(
          child: InkWell(
            splashColor: Colors.transparent,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 40.w,
                  vertical: 30.w
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '一个人是否值得交往，看这四点就够了',
                    style: titleStyle,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: 20.w,
                        bottom: 24.w
                    ),
                    child: Text(
                      '有人说：“不必把太多人请进生命里，若他们走进不了你的内心，就只会把你的生命搅扰得拥挤不堪。” 朋友不必多，贵在能知心。珍贵的情谊，要留给最值得结交的人。一个人是否值得交往，看这四点就够了。',
                      style: descStyle,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  _buildNormalBottomBar(context)
                ],
              ),
            ),
            onTap: () {
              routePush(ArticleDetailPage());
            },
          ),
        ),
      ),
    );
  }

  /// 文章类型B (描述是文字加图片)
  Widget _buildArticleTypeB (BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          bottom: 20.w
      ),
      child: Material(
        color: Colors.white,
        child: Ink(
          child: InkWell(
            splashColor: Colors.transparent,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 40.w,
                  vertical: 30.w
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text('“胸大就是风骚吗？”：比起别人的看法，你更该得到自己的肯定', style: titleStyle,),
                  Padding(
                    padding: EdgeInsets.only(
                        top: 20.w,
                        bottom: 24.w
                    ),
                    child: Flex(
                      direction: Axis.horizontal,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: Text(
                            '最近，一张《2020女性标准体重表》在朋友圈刷屏。细看数值就会发现，标准体重是健康，美体体重是健身，',
                            style: descStyle,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Expanded(
                          flex: 0,
                          child: Container(
                            margin: EdgeInsets.only(
                                left: 30.w
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(10.w),
                              child: Image.network(
                                'https://upload-images.jianshu.io/upload_images/3356997-6b687f4a1850c966.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/700/format/webp',
                                width: 210.w,
                                height: 140.w,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  _buildNormalBottomBar(context)
                ],
              ),
            ),
            onTap: () {
              routePush(ArticleDetailPage());
            },
          ),
        ),
      ),
    );
  }

  /// 文章类型C (标题加图片)
  Widget _buildArticleTypeC(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          bottom: 20.w
      ),
      child: Material(
        color: Colors.white,
        child: Ink(
          child: InkWell(
            splashColor: Colors.transparent,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 40.w,
                  vertical: 30.w
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(
                    '做了这么久的程序员，你知道为什么会有Lambda表达式吗？',
                    style: titleStyle,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: 20.w,
                        bottom: 24.w
                    ),
                    child: Flex(
                      direction: Axis.horizontal,
                      children: <Widget>[
                        Expanded(
                          flex: 1,
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10.w),
                                bottomLeft: Radius.circular(10.w)
                            ),
                            child: Image.network(
                              'https://upload-images.jianshu.io/upload_images/3356997-6b687f4a1850c966.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/700/format/webp',
                              height: 160.w,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 0,
                          child: Container(
                            width: 10.w,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Image.network(
                            'https://upload-images.jianshu.io/upload_images/3356997-6b687f4a1850c966.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/700/format/webp',
                            height: 160.w,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Expanded(
                          flex: 0,
                          child: Container(
                            width: 10.w,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(10.w),
                                bottomRight: Radius.circular(10.w)
                            ),
                            child: Image.network(
                              'https://upload-images.jianshu.io/upload_images/3356997-6b687f4a1850c966.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/700/format/webp',
                              height: 160.w,
                              fit: BoxFit.cover,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  _buildNormalBottomBar(context)
                ],
              ),
            ),
            onTap: () {
              routePush(ArticleDetailPage());
            },
          ),
        ),
      ),
    );
  }

  /// 文章通用底部栏
  Widget _buildNormalBottomBar (BuildContext context) {
    return Flex(
      direction: Axis.horizontal,
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Row(
            children: <Widget>[
              Icon(
                IconData(0xe606, fontFamily: 'iconfont'),
                color: Theme.of(context).primaryColor,
                size: 26.sp,
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: 6.w,
                    right: 14.w
                ),
                child: Text('80.964', style: TextStyle(
                    color: Theme.of(context).primaryColor,
                    fontSize: 22.sp
                ),),
              ),
              Text(
                '写bug的程序员',
                style: bottomBarTextStyle,
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: 16.w,
                    right: 16.w
                ),
                child: Text(
                  '759 阅读',
                  style: bottomBarTextStyle,
                ),
              ),
              Text(
                '1 评论',
                style: bottomBarTextStyle,
              ),
              Padding(
                padding: EdgeInsets.only(
                    left: 16.w
                ),
                child: Text(
                  '20 赞',
                  style: bottomBarTextStyle,
                ),
              )
            ],
          ),
        ),
        Expanded(
          flex: 0,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            child: Icon(
              IconData(0xe681, fontFamily: 'iconfont'),
              size: 20.sp,
              color: Color(0xffdadada),
            ),
          ),
        )
      ],
    );
  }
}