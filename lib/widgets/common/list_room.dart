import 'package:flitter/common.dart';
import 'package:flitter/services/gitter/gitter.dart';
import 'package:flitter/widgets/routes/room.dart';
import 'package:flutter/material.dart';
import 'package:flitter/app.dart';

class ListRoomWidget extends StatelessWidget {
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
      new GlobalKey<RefreshIndicatorState>();

  final AppState app;
  final List<Room> rooms;
  final RefreshCallback onRefresh;

  ListRoomWidget(this.app, this.rooms, this.onRefresh);

  @override
  Widget build(BuildContext context) {
    return new RefreshIndicator(
      child: new ListView.builder(
        physics: const AlwaysScrollableScrollPhysics(),
        key: _refreshIndicatorKey,
        itemCount: rooms.length,
        itemBuilder: _buildListTile,
      ),
      onRefresh: onRefresh,
    );
  }

  Widget _buildListTile(BuildContext context, int index) {
    final Room room = rooms[index];
    return new ListTile(
      dense: false,
      title: new Text(room.name),
      leading: new Image.network(room.avatarUrl),
      trailing: room.unreadItems > 0
          ? new Chip(label: new Text("${room.unreadItems}"))
          : null,
      onTap: () {
        materialNavigateTo(context, new RoomView(app, room: room),
            path: RoomView.path);
      },
    );
  }
}
