use SecretsofAptB;
go

if exists (select * from sys.tables where name='BlogCategory')
	drop table BlogCategory
go

if exists (select * from sys.tables where name='Category')
	drop table Category
go

if exists (select * from sys.tables where name='Comment')
	drop table Comment
go

if exists (select * from sys.tables where name='Blog')
	drop table Blog
go

create table Blog(
	BlogID int identity(1,1) primary key,
	Title varchar (50) not null,
	HtmlContent nvarchar(max),
	DatecCreated datetime2 not null default getutcdate(), 
	DateModified datetime2 null,
	Author varchar (30),
	Imagepath varchar (256),
	BlogDescription varchar (150),
	IsDraft bit,
)

create table Comment(
	CommentID int identity (1,1) primary key,
	UserName varchar(30),
	UserEmail varchar(50), 
	CommentText varchar (250),
	DateCreated datetime2 not null default getutcdate(),
	DateModified datetime2 null,
	IsDisplayed bit,
	BlogID int foreign key references Blog(BlogID) not null,
)

create table Category(
	CategoryID int identity (1,1) primary key,
	CategoryName varchar(30),
)

create table BlogCategory(
	BlogID int not null,
	CategoryID int not null,
	constraint PK_BlogCategory
		primary key (BlogID, CategoryID), 
	constraint FK_Category_BlogCategory
		foreign key (CategoryID) 
		references Category(CategoryID),
	constraint FK_Blog_BlogCategory
		foreign key (BlogID)
		references Blog(BlogID)
)