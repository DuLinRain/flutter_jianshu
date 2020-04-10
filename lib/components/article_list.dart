import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334, allowFontScaling: false);

    return ListView(
      children: <Widget>[
        _buildArticleComponent(context),
        _buildArticleTypeB(context)
      ],
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
      padding: EdgeInsets.symmetric(
        horizontal: 40.w,
        vertical: 30.w
      ),
      decoration: BoxDecoration(
        color: Colors.white
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
    );
  }

  /// 文章类型B (描述是文字加图片)
  Widget _buildArticleTypeB (BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
          bottom: 20.w
      ),
      padding: EdgeInsets.symmetric(
          horizontal: 40.w,
          vertical: 30.w
      ),
      decoration: BoxDecoration(
        color: Colors.white
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