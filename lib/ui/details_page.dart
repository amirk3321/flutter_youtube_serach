import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_youtube_search/model/details/details_model.dart';
import 'package:flutter_youtube_search/ui/home_page.dart';
import 'package:kiwi/kiwi.dart' as Kiwi;
import 'package:flutter_youtube_search/bloc/details/bloc.dart';

class DetailsPage extends StatefulWidget {
  final String videoId;

  DetailsPage({Key key, this.videoId}) : super(key: key);

  @override
  State<StatefulWidget> createState() => DetailsPageState();
}

class DetailsPageState extends State<DetailsPage> {
  DetailsBloc _detailsBloc = Kiwi.Container().resolve<DetailsBloc>();

  @override
  void initState() {
    _detailsBloc.onFetchVideoDetails(id: widget.videoId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        builder: (_) => _detailsBloc,
        child: Scaffold(
          body: BlocBuilder<DetailsBloc, DetailsState>(
            builder: _buildBlocBuilder,
          ),
        ));
  }

  Widget _buildBlocBuilder(BuildContext context, DetailsState state) {
    //Sliver is just portion of scrollable area
    //effciently scrollable large number of children
    return CustomScrollView(slivers: <Widget>[
      SliverAppBar(
        expandedHeight: 280,
        pinned: true,
        flexibleSpace: _buildFlexibleSpaceBar(state),
      ),
      _buildBody(state),
    ]);
  }

  FlexibleSpaceBar _buildFlexibleSpaceBar(DetailsState state) {
    if (state.isLoading) return FlexibleSpaceBar();

    if (state.isSuccess) {
      return FlexibleSpaceBar(
        title: Text(
          state.videoItems.snippet.title,
          style: TextStyle(color: Colors.white),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        background: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Image.network(
              state.videoItems.snippet.thumbnails.high.url,
              fit: BoxFit.cover,
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  stops: [0.15, 0.5],
                  colors: [Colors.black87, Colors.transparent],
                ),
              ),
            )
          ],
        ),
      );
    } else {
      return FlexibleSpaceBar(
        background: CenterMessage(
          iconData: Icons.error_outline,
          message: state.error,
        ),
      );
    }
  }

  Widget _buildBody(DetailsState state) {
    if (state.isLoading) {
      return SliverFillRemaining(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (state.isSuccess) {
      return _buildRemainingDetailsList(state.videoItems.snippet);
    } else {
      SliverFillRemaining(
        child: Center(
          child: CenterMessage(
            message: state.error,
            iconData: Icons.error_outline,
          ),
        ),
      );
    }
  }

  Widget _buildRemainingDetailsList(VideoSnippet items) {
    return SliverPadding(
      padding: EdgeInsets.all(8.0),
      sliver: SliverList(
        delegate: SliverChildListDelegate(
          <Widget>[
            SizedBox(height: 5,),
            Text(
              items.title,
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height: 5,),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                width: MediaQuery.of(context).size.width * 2,
                child: Wrap(
                    spacing: 10,
                   children: _getTagsAsChipWidgets(items),
                ),
              ),
            ),
            SizedBox(height: 5,),
            Text('Description',
            style: Theme.of(context).textTheme.title,),
            SizedBox(height: 5,),
            Text(items.description),
          ],
        ),
      ),
    );
  }

  _getTagsAsChipWidgets(VideoSnippet items) {
    return items.tags.map((tags) => 
    Chip(label: Text(tags))).toList();
  }
}
