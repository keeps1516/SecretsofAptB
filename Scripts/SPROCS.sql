use SecretsofAptB
go

if exists(
	select *
	from INFORMATION_SCHEMA.ROUTINES
	where ROUTINE_NAME = 'CreateCategory')
begin
	drop procedure CreateCategory
	end
	go
create procedure CreateCategory(
	@CategoryName varchar(30)
)
as
begin
insert into Category(CategoryName)
values (@CategoryName)
end
go

if exists(
	select *
	from INFORMATION_SCHEMA.ROUTINES
	where ROUTINE_NAME = 'ReadCategories')
begin
	drop procedure ReadCategories
	end
	go
create procedure ReadCategories
as
select * from Category
go

if exists(
	select *
	from INFORMATION_SCHEMA.ROUTINES
	where ROUTINE_NAME = 'UpdateCategories')
begin
	drop procedure UpdateCategories
	end
	go
create procedure UpdateCategories(
@CategoryID int, @CategoryName varchar(30)
)
as
update Category
set Category.CategoryName = @CategoryName
where Category.CategoryID = @CategoryID
go

if exists(
	select *
	from INFORMATION_SCHEMA.ROUTINES
	where ROUTINE_NAME = 'DeleteCategory')
begin
	drop procedure DeleteCategory
	end
	go
create procedure DeleteCategory(
@CategoryID int
)
as
delete Category
where Category.CategoryID = @CategoryID
go

if exists(
	select *
	from INFORMATION_SCHEMA.ROUTINES
	where ROUTINE_NAME = 'CreateNewBlog')
begin
	drop procedure CreateNewBlog
	end
	go
create procedure CreateNewBlog(
@Title varchar(50), 
@HtmlContent varchar(max), 
@DateCreated datetime2, 
@Author varchar(30),
@Imagepath varchar(256),
@BlogDescription varchar(150),
@IsDraft bit
)
as

insert into Blog(Title, HtmlContent, DatecCreated, Author,Imagepath,BlogDescription,IsDraft)
values (@Title, @HtmlContent, @DateCreated, @Author, @Imagepath, @BlogDescription, @IsDraft)
go

if exists(
	select *
	from INFORMATION_SCHEMA.ROUTINES
	where ROUTINE_NAME = 'SelectAllBlogs')
begin
	drop procedure SelectAllBlogs
	end
	go
create procedure SelectAllBlogs
as
select Blog.Author, Blog.BlogDescription, Blog.DatecCreated, Blog.DateModified, Blog.Title, Blog.IsDraft, Blog.BlogID
from Blog
go

if exists(
	select *
	from INFORMATION_SCHEMA.ROUTINES
	where ROUTINE_NAME = 'SelectBlog')
begin
	drop procedure SelectBlog
	end
	go
create procedure SelectBlog(
@BlogID int
)
as
select *
from Blog
where Blog.BlogID=@BlogID
go

if exists(
	select *
	from INFORMATION_SCHEMA.ROUTINES
	where ROUTINE_NAME = 'UpdateBlog')
begin
	drop procedure UpdateBlog
	end
	go
create procedure UpdateBlog(
@BlogID int,
@Author varchar(30),
@Title varchar(50),
@HtmlContent nvarchar(max),
@ImagePath varchar(256),
@BlogDescription varchar(150),
@IsDraft bit,
@DateModified datetime2
)
as
begin
Update Blog 
set Author = @Author,
Title = @Title,
HtmlContent = @HtmlContent,
DateModified = getutcdate(),
Imagepath = @ImagePath,
BlogDescription = @BlogDescription,
IsDraft = @IsDraft
where @BlogID = Blog.BlogID
end
go

if exists(
select *
from INFORMATION_SCHEMA.ROUTINES
where ROUTINE_NAME = 'DeleteBlog')
begin
	drop procedure DeleteBlog
	end
	go
create procedure DeleteBlog(
@BlogId int
)
as
delete from Blog
where @BlogId = Blog.BlogID
go

if exists(
select *
from INFORMATION_SCHEMA.ROUTINES
where ROUTINE_NAME = 'CreateComment')
begin
	drop procedure CreateComment
	end
	go
create procedure CreateComment(
@UserName varchar(30),
@UserEmail varchar(50),
@BlogID int,
@CommentText varchar(250), 
@DateCreated datetime2,
@IsDisplayed bit
)
as
insert into Comment(UserName, UserEmail, CommentText, DateCreated, IsDisplayed, BlogID)
values (@UserName, @UserEmail, @CommentText, @DateCreated, @IsDisplayed, @BlogID)
go

if exists(
select *
from INFORMATION_SCHEMA.ROUTINES
where ROUTINE_NAME = 'ReadComment')
begin
	drop procedure ReadComment
	end
	go
create procedure ReadComment(
@CommentID int
)
as
select *
from Comment
where Comment.CommentID = @CommentID
go

if exists(
select *
from INFORMATION_SCHEMA.ROUTINES
where ROUTINE_NAME = 'UpdateDisplayedComment'
)
begin
	drop procedure UpdateDisplayedComment
	end
	go
create procedure UpdateDisplayedComment(
@CommentID int,
@IsDisplayed bit
)
as
begin
update Comment
set IsDisplayed = @IsDisplayed,
DateModified = getutcdate()
where CommentID = @CommentID
end
go

if exists(
select *
from INFORMATION_SCHEMA.ROUTINES
where ROUTINE_NAME = 'DeleteComment'
)
begin
	drop procedure DeleteComment
	end
	go
create procedure DeleteComment(
@CommentID int
)
as
delete from Comment
where CommentID = @CommentID
go

if exists(
select *
from INFORMATION_SCHEMA.ROUTINES
where ROUTINE_NAME = 'SelectAllThisBlogsComments'
)
begin
	drop procedure SelectAllThisBlogsComments
	end
	go
create procedure SelectAllThisBlogsComments(
@BlogID int
)
as
select b.Title, c.CommentID, c.CommentText, c.DateCreated, c.DateModified, c.IsDisplayed, c.UserEmail, c.UserName
from Comment c
inner join Blog b on 
c.BlogID = b.BlogID
where b.BlogID = @BlogID
go

if exists(
select *
from INFORMATION_SCHEMA.ROUTINES
where ROUTINE_NAME = 'SelectAllThisCategoryBlogs'
)
begin
	drop procedure SelectAllThisCategoryBlogs
	end
	go
create procedure SelectAllThisCategoryBlogs(
@CategoryID int
)
as
Select c.CategoryName,b.Title, b.BlogID, b.DatecCreated, b.DateModified, b.Author, b.BlogDescription, b.IsDraft
from BlogCategory bc
inner join Blog b
on bc.BlogID = b.BlogID
inner join Category c
on bc.CategoryID = c.CategoryID
where bc.CategoryID = @CategoryID
go

if exists(
select *
from INFORMATION_SCHEMA.ROUTINES
where ROUTINE_NAME = 'AssociateBlogAndCategory'
)
begin
	drop procedure AssociateBlogAndCategory
	end
	go
create procedure AssociateBlogAndCategory(
@BlogID int,
@CategoryID int
)
as
if not exists(
select *
from BlogCategory b
where  b.BlogID = @BlogID 
and b.CategoryID = @CategoryID
)
begin
	insert into BlogCategory
	values (@BlogID,@CategoryID)
end
go
---TODO:  Comment, CRUD BlogCategory