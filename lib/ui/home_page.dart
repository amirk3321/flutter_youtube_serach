import 'package:flutter/material.dart';
import 'package:flutter_youtube_search/model/search/search_model.dart';
import 'package:flutter_youtube_search/ui/details_page.dart';
import 'package:kiwi/kiwi.dart' as Kiwi;
import 'package:flutter_youtube_search/bloc/search/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  final _scrollController = ScrollController();
  SearchBloc _searchBloc = Kiwi.Container().resolve<SearchBloc>();

  @override
  Widget build(BuildContext context) {
    return _searchBar();
  }

  Widget _searchBar() {
    return BlocProvider(
      builder: (_) => _searchBloc,
      child: Scaffold(
        appBar: AppBar(
          title: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
              ),
              child: SearchField()),
        ),
        body: BlocBuilder<SearchBloc,SearchState>(
          builder: (BuildContext context, SearchState state) {
            if (state.isInitial) {
              return CenterMessage(
                message: "Search Videos",
                iconData: Icons.ondemand_video,
              );
            }
            if (state.isLoading) {
              Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state.isSuccess) {
              return _buildResultList(state);
            } else {
              return CenterMessage(
                message: state.error,
                iconData: Icons.error_outline,
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildResultList(SearchState state) {
    return NotificationListener<ScrollNotification>(
      onNotification: _handleScrollNotification,
      child: ListView.builder(
        controller: _scrollController,
        itemCount: _calculateListItemsCount(state),
        itemBuilder: (context, index) {
          return index >= state.searchResult.length
              ? _buildLoaderListItems()
              : _buildVideoListItems(state.searchResult[index]);
        },
      ),
    );
  }

  Widget _buildVideoListItems(SearchItems items){
    return GestureDetector(
      child: _buildVideoListItemsCards(items.snippet),
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (_){
          return DetailsPage(videoId: items.id.videoId,);
        }));
      },
    );
  }

  Widget _buildVideoListItemsCards(SearchSnippet videosSnippet) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            AspectRatio(
              aspectRatio: 5 / 3,
              child: Image.network(
                videosSnippet.thumbnails.high.url,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              videosSnippet.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SizedBox(height: 5,),
            Text(
              videosSnippet.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoaderListItems() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  int _calculateListItemsCount(SearchState state) {
    //when we reached the end of result we return true  and return search result
    if (state.hasReachedEndOfResults) {
      return state.searchResult.length;
    } else {
      //
      return state.searchResult.length + 1;
    }
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification is ScrollEndNotification &&
        _scrollController.position.extentAfter == 0) {
      _searchBloc.onFetchNextPageResult();
    }
    return false;
  }
}

class SearchField extends StatefulWidget {
  SearchField({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => SearchFiledState();
}

class SearchFiledState extends State<SearchField> {
  TextEditingController _searchController = TextEditingController();
  FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _searchController.selection = TextSelection(
            baseOffset: 0, extentOffset: _searchController.text.length);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5),
      child: TextField(
        controller: _searchController,
        focusNode: _focusNode,
        onSubmitted: (query) {
          BlocProvider.of<SearchBloc>(context).onSearchInitiated(query);
        },
        decoration: InputDecoration(
          hintText: 'Searching',
          icon: Icon(Icons.search),
          border: InputBorder.none,
        ),
      ),
    );
  }
}

//CenterMessage
class CenterMessage extends StatelessWidget {
  final String message;
  final IconData iconData;

  CenterMessage({Key key, this.message, this.iconData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: .6,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Icon(iconData),
            SizedBox(
              height: 5,
            ),
            Text(
              message,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
