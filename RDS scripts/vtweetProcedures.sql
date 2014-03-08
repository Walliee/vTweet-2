USE [TweetAuthLogin]
GO
drop procedure AddVideo;
drop procedure RemoveVideo;
drop procedure SendFriendRequest;
drop procedure UpdateFriendRequest;
drop procedure AddResponse;
drop function IsFriend;
drop procedure ListUsers;
drop procedure ListFriends;
drop procedure ListVideos;
drop procedure ListResponses;

GO


create procedure AddVideo(
@UserID uniqueidentifier,
@URL text)
as
begin
insert into Video(UserID, URL)
values(@UserID, @URL);
end

GO

create procedure RemoveVideo(
@VideoID int
)
as
begin
delete from Video
where VideoID=@VideoID;
end

GO

create procedure SendFriendRequest(
@UserID uniqueidentifier,
@FriendUserID uniqueidentifier,
@Status varchar(1))
as
begin
insert into Friends(UserID,FriendUserID,Status)
values(@UserID,@FriendUserID,@status);
end

GO

create procedure UpdateFriendRequest(
@UserID uniqueidentifier,
@FriendUserID uniqueidentifier,
@Status varchar(1))
as
begin
 if(@Status='y')
begin
update friends
set status='y' where UserID=@UserID and FriendUserID=@FriendUserID;
    end
 else
begin
delete from friends where UserID=@UserID and FriendUserID=@FriendUserID
end
end

GO

create procedure AddResponse(
@OriginalVideoID int,
@ResponseVideoID int)
as
begin
insert into VideoResponse(OriginalVideoID, ResponseVideoID)
values(@OriginalVideoID, @ResponseVideoID);
end

GO

create function IsFriend(
@UserID uniqueidentifier,
@FriendUserID uniqueidentifier)
returns varchar(1)
as
begin
declare @isfriend uniqueidentifier;
declare @retval varchar(1);
select @isfriend = UserID from Friends where ((UserID=@UserID and FriendUserID=@FriendUserID) or (UserID=@FriendUserID and FriendUserID=@UserID)) and status = 'y';
if(@isfriend is not NULL)
begin
set @retval = 'y';
end 
else
begin
set @retval = 'n';
end
return @retval;
end

GO

create procedure ListUsers
as
begin
select * from Users;
end

GO

create procedure ListFriends(
@UserID uniqueidentifier)
as
begin
select * from Friends
where UserID=@UserID or FriendUserID=@UserID;
end

GO

create procedure ListVideos(
@UserID uniqueidentifier)
as
begin
select * from Video
where UserID=@UserID
order by Timestamp;
end

GO

create procedure ListResponses(
@VideoID int)
as
begin
select * from VideoResponse
where OriginalVideoID=@VideoID
order by Timestamp;
end