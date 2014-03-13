select * from Users;
select * from Friends;
insert into Friends(UserID, FriendUserID) values ('1EFB9D3F-C0E7-4DF7-B50A-A021115D2CE2', '7F066D15-F71A-4C03-9955-3B708D0DA849')
exec ListFriends '1EFB9D3F-C0E7-4DF7-B50A-A021115D2CE2'
