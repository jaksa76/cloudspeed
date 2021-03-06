USE [perf_competition]
GO
/****** Object:  StoredProcedure [dbo].[AddFriend]    Script Date: 12/08/2008 10:28:31 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[AddFriend] 
	-- Add the parameters for the stored procedure here
	@leftuser  varchar(127),
	@rightuser varchar(127)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DECLARE @leftid AS INT
	SELECT @leftid = UserID FROM Users WHERE Name = @leftuser
	DECLARE @rightid AS INT
	SELECT @rightid = UserID FROM Users WHERE Name = @rightuser
	  
	BEGIN TRANSACTION
		INSERT INTO Friends (LeftID, RightID) VALUES (@leftid, @rightid)
		INSERT INTO Friends (LeftID, RightID) VALUES (@rightid, @leftid)
	COMMIT

END

GO
/****** Object:  StoredProcedure [dbo].[AddPost]    Script Date: 12/08/2008 10:28:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[AddPost] 
	-- Add the parameters for the stored procedure here
	@user  varchar(127),
	@post varchar(255)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	DECLARE @userid AS INT
	SELECT @userid = UserID FROM Users WHERE Name = @user
	  
	BEGIN TRANSACTION
		INSERT INTO Posts (UserID, Post, Time) VALUES (@userid, @post, GetDate())
	COMMIT

END

GO
/****** Object:  StoredProcedure [dbo].[AuthenticateUser]    Script Date: 12/08/2008 10:28:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[AuthenticateUser] 
	-- Add the parameters for the stored procedure here
	@user  varchar(127), 
	@password varchar(63)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT Name 
	FROM Users
    WHERE Name = @user
    AND Password = @password

END

GO
/****** Object:  StoredProcedure [dbo].[AuthenticateUserAndCountFriends]    Script Date: 12/08/2008 10:28:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[AuthenticateUserAndCountFriends] 
	-- Add the parameters for the stored procedure here
	@user  varchar(127), 
	@password varchar(63)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT Name, count(Friends.RightID) as FriendCount
	FROM Users LEFT OUTER JOIN Friends ON Users.UserID = Friends.LeftID
    WHERE Name = @user
    AND Password = @password
	GROUP BY Name

END

GO
/****** Object:  StoredProcedure [dbo].[CreateUser]    Script Date: 12/08/2008 10:28:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[CreateUser] 
	-- Add the parameters for the stored procedure here
	@user  varchar(127), 
	@password varchar(63)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	INSERT INTO Users(Name, Password) VALUES (@user, @password)

END

GO
/****** Object:  StoredProcedure [dbo].[GetFriendLimitedPosts]    Script Date: 12/08/2008 10:28:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[GetFriendLimitedPosts] 
	-- Add the parameters for the stored procedure here
	@limit int,
	@user  varchar(127)
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    -- Insert statements for procedure here
	SELECT TOP 20 P.Time AS Time, P.Post AS Post, U2.Name AS Name
	FROM Users AS U1, Users AS U2, Friends AS F, Posts AS P
    WHERE U1.Name = @user
    AND U1.UserID = F.LeftID
	AND F.RightID = P.UserID
	AND P.UserID = U2.UserID
	ORDER BY P.Time DESC
  
END
