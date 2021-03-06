USE [Movie]
GO
/****** Object:  Table [dbo].[Movie]    Script Date: 10/26/2017 7:10:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Movie](
	[Movie_Id] [varchar](50) NULL,
	[Movie_Name] [varchar](50) NULL,
	[Language] [varchar](50) NULL,
	[PublishDate] [datetime] NOT NULL,
	[YearofRelease] [varchar](50) NULL,
	[MoviePoster] [varchar](max) NULL,
	[Title] [varchar](50) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Movie_List]    Script Date: 10/26/2017 7:10:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Movie_List](
	[MovieListId] [varchar](50) NOT NULL,
	[MovieListName] [varchar](50) NULL,
	[UserId] [varchar](50) NULL,
	[DateCreated] [varchar](50) NULL,
 CONSTRAINT [PK_Movie_List] PRIMARY KEY CLUSTERED 
(
	[MovieListId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[Movie_Rating]    Script Date: 10/26/2017 7:10:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[Movie_Rating](
	[MovieRatingId] [varchar](50) NOT NULL,
	[Rating_date] [varchar](50) NULL,
	[Movie_Id] [varchar](50) NULL,
	[Movielist_Id] [varchar](50) NULL,
	[UserId] [varchar](50) NULL,
	[Rating] [tinyint] NULL,
 CONSTRAINT [PK_Movie_Rating] PRIMARY KEY CLUSTERED 
(
	[MovieRatingId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[MovieInList]    Script Date: 10/26/2017 7:10:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MovieInList](
	[mListId] [varchar](50) NOT NULL,
	[MoviceId] [varchar](50) NULL,
	[MoviceListId] [varchar](50) NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[User]    Script Date: 10/26/2017 7:10:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[User](
	[User_Id] [varchar](50) NOT NULL,
	[User_Email] [varchar](50) NULL,
	[Isactive] [bit] NULL,
	[UserPassword] [varchar](50) NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[User_Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  StoredProcedure [dbo].[sp_movie_rating]    Script Date: 10/26/2017 7:10:05 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_movie_rating]
(
	@userid varchar(max),
	@Movie_Id varchar(max),
	@r int=0
)
as
declare @rt int
if exists(select 1 from Movie_Rating where UserId=@userid and Movie_Id=@Movie_Id)
begin
    
	select @rt=Rating from Movie_Rating where UserId=@userid and Movie_Id=@Movie_Id
	if(@rt =5 and @r=1)
	begin
	 set @r=0
	end
	if(@rt =0 and @r=-1)
	begin
	 set @r=0
	end
   update Movie_Rating
   set Rating=Rating+@r 
   where UserId=@userid and Movie_Id=@Movie_Id 
end
else
begin
  insert into Movie_Rating values(NEWID(),CURRENT_TIMESTAMP,@Movie_Id,null,@userid,1)

end
GO
