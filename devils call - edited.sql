-------------------------------------------  USE MASTER DATABASE  ----------------------------------------

USE [master]
GO

-------------------------------------------  DATABASE  ----------------------------------------


/****** Object:  Database [DevilsCall]    Script Date: 4/17/2018 2:11:56 PM ******/

---- Create database ----

IF EXISTS ( SELECT [name] FROM sys.databases WHERE [name] = 'DevilsCall' )
DROP DATABASE DevilsCall
GO

CREATE DATABASE [DevilsCall]
GO

USE [DevilsCall]
GO

------------------------------------------- USER ROLES and LOGIN ----------------------------
USE master;
CREATE LOGIN DC_admin WITH PASSWORD = 'password',
DEFAULT_DATABASE = [DevilsCall]
GO

USE DevilsCall;

CREATE USER DC_admin FOR LOGIN DC_admin;
EXEC sp_addrolemember 'db_owner', 'DC_admin';
EXEC sp_addrolemember 'db_datareader', 'DC_admin'
EXEC sp_addrolemember 'db_datawriter', 'DC_admin'
GO



-------------------------------------------  TABLES  ----------------------------------------


/****** Object:  Table [dbo].[Club]    Script Date: 4/17/2018 2:11:56 PM ******/

---- Create Table for Clubs ----
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF OBJECT_ID(N'DevilsCall.dbo.Club', N'U') IS NULL
BEGIN
CREATE TABLE [dbo].[Club](
	[ClubID] [smallint] IDENTITY(1,1) NOT NULL,
	[ClubName] [nvarchar](50) NOT NULL,
	[YearOfCreation] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[ClubID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[ClubName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO

 --- SELECT * FROM Club 

/****** Object:  Table [dbo].[Department]    Script Date: 4/17/2018 2:11:57 PM ******/

---- Create Table for Departments ----
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF OBJECT_ID(N'DevilsCall.dbo.Department', N'U') IS NULL
BEGIN
CREATE TABLE [dbo].[Department](
	[DepartmentID] [smallint] IDENTITY(1,1) NOT NULL,
	[DepartmentName] [nvarchar](50) NOT NULL,
	[SchoolID] [smallint] NULL,
PRIMARY KEY CLUSTERED 
(
	[DepartmentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[DepartmentName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO

--- Select * from Department

/****** Object:  Table [dbo].[Event]    Script Date: 4/17/2018 2:11:57 PM ******/

---- Create Table for Events ----
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF OBJECT_ID(N'DevilsCall.dbo.Event', N'U') IS NULL
BEGIN
CREATE TABLE [dbo].[Event](
	[EventID] [smallint] IDENTITY(1,1) NOT NULL,
	[Title] [nvarchar](200) NOT NULL,
	[Date] [date] NOT NULL,
	[Time] [time](7) NULL,
	[Description] [nvarchar](1000) NULL,
	[MaxInvitees] [int] NULL,
	[CurrentHeadCount] [int] NULL,
	[MaxGuests] [int] NULL,
	[CreatedBy] [smallint] NOT NULL,
	[LocationID] [smallint] NULL,
	[OverallRating] [tinyint] NULL,
PRIMARY KEY CLUSTERED 
(
	[EventID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO

-- SELECT * FROM Event


/****** Object:  Table [dbo].[Feedback]    Script Date: 4/17/2018 2:11:57 PM ******/

---- Create Table for Feedback from invitees ----
/* The feedback given by an invitee for the event is stored in this table */

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF OBJECT_ID(N'DevilsCall.dbo.Feedback', N'U') IS NULL
BEGIN
CREATE TABLE [dbo].[Feedback](
	[FeedbackID] [smallint] IDENTITY(1,1) NOT NULL,
	[EventID] [smallint] NOT NULL,
	[Comment] [nvarchar](200) NULL,
	[FeedbackRating] [tinyint] NOT NULL
) ON [PRIMARY]
END
GO

-- SELECT * FROM Feedback


/****** Object:  Table [dbo].[Invitee]    Script Date: 4/17/2018 2:11:57 PM ******/

--- Create Table for Invitee ---
/* If a user is invited to an event, the user is considered an invitee. 
Details such as number of guests (for example, Plus One) and RSVP are stored in this table */

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF OBJECT_ID(N'DevilsCall.dbo.Invitee', N'U') IS NULL
BEGIN
CREATE TABLE [dbo].[Invitee](
	[InviteeID] [smallint] IDENTITY(1,1) NOT NULL,
	[UserID] [smallint] NOT NULL,
	[EventID] [smallint] NOT NULL,
	[Rsvp] [nvarchar](10) NULL,
	[AdditionalGuests] [int] NULL
) ON [PRIMARY]
END
GO

-- SELECT * FROM Invitee

/****** Object:  Table [dbo].[Location]    Script Date: 4/17/2018 2:11:57 PM ******/

--- Create Table for Location ---
/* Every location is preset in the application. Each location is available in the table Location */

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF OBJECT_ID(N'DevilsCall.dbo.Location', N'U') IS NULL
BEGIN
CREATE TABLE [dbo].[Location](
	[LocationID] [smallint] NOT NULL,
	[Description] [nvarchar](200) NULL,
	[Address] [nvarchar](500) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[LocationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO


/****** Object:  Table [dbo].[Member]    Script Date: 4/17/2018 2:11:57 PM ******/

--- Create Table for Members ---
/* This table is the result of normalizing the relation between a user and a club.
If a user belongs to a club, the relation of the user as a member of the club is stored in this table. */

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF OBJECT_ID(N'DevilsCall.dbo.Member', N'U') IS NULL
BEGIN
CREATE TABLE [dbo].[Member](
	[MemberID] [smallint] IDENTITY(1,1) NOT NULL,
	[UserID] [smallint] NOT NULL,
	[ClubID] [smallint] NOT NULL
) ON [PRIMARY]
END
GO

-- SELECT * FROM Member


/****** Object:  Table [dbo].[School]    Script Date: 4/17/2018 2:11:57 PM ******/

---- Create Table for School ----
/* School Name and ID are stored in this table */

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF OBJECT_ID(N'DevilsCall.dbo.School', N'U') IS NULL
BEGIN
CREATE TABLE [dbo].[School](
	[SchoolID] [smallint] IDENTITY(1,1) NOT NULL,
	[SchoolName] [nvarchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[SchoolID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[SchoolName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO


/****** Object:  Table [dbo].[Users]    Script Date: 4/17/2018 2:11:57 PM ******/

--- Create Table for Users ---
/* The details of all users are stored in the table. 
We will assume that the details are prefetched from the main university server */

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF OBJECT_ID(N'DevilsCall.dbo.Users', N'U') IS NULL
BEGIN
CREATE TABLE [dbo].[Users](
	[UserID] [smallint] IDENTITY(1,1) NOT NULL,
	[EmailAddress] [nvarchar](50) NOT NULL,
	[FirstName] [nvarchar](50) NOT NULL,
	[LastName] [nvarchar](50) NULL,
	[DepartmentID] [smallint] NULL,
	[Program] [nvarchar](50) NULL,
	[YearOfJoining] [date] NULL,
	[EnrollmentStatus] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[EmailAddress] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
END
GO

-- SELECT * FROM Users

/****** Object:  View [dbo].[v_listOfInvitees]    Script Date: 4/17/2018 2:11:57 PM ******/

---- Create View for list of invitees ----

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF OBJECT_ID(N'DevilsCall.dbo.v_listOfInvitees', N'U') IS NULL
BEGIN
CREATE view  dbo.v_listOfInvitees
as
select u.UserID,EmailAddress, FirstName,LastName, DepartmentName,SchoolName ,e.EventID,Title, Rsvp,AdditionalGuests
from Users u join Department d 
on u.DepartmentID =d.DepartmentID
join School s on s.SchoolID=d.SchoolID
join Member m on u.UserID=m.MemberID
join Event e on e.EventID=m.MemberID
join Invitee i on i.UserID=u.UserID
END
GO



-------------------------------------------  INDEXES  ----------------------------------------


/****** Object:  Index [idx_date]    Script Date: 4/17/2018 2:11:57 PM ******/
CREATE NONCLUSTERED INDEX [idx_date] ON [dbo].[Event]
(
	[Date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [idx_event]    Script Date: 4/17/2018 2:11:57 PM ******/
CREATE NONCLUSTERED INDEX [idx_event] ON [dbo].[Feedback]
(
	[EventID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [idx_eventID]    Script Date: 4/17/2018 2:11:57 PM ******/
CREATE NONCLUSTERED INDEX [idx_eventID] ON [dbo].[Invitee]
(
	[EventID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [idx_club]    Script Date: 4/17/2018 2:11:57 PM ******/
CREATE NONCLUSTERED INDEX [idx_club] ON [dbo].[Member]
(
	[ClubID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [idx_Department]    Script Date: 4/17/2018 2:11:57 PM ******/
CREATE NONCLUSTERED INDEX [idx_Department] ON [dbo].[Users]
(
	[DepartmentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [idx_EnrollmentStatus]    Script Date: 4/17/2018 2:11:57 PM ******/
CREATE NONCLUSTERED INDEX [idx_EnrollmentStatus] ON [dbo].[Users]
(
	[EnrollmentStatus] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
SET ANSI_PADDING ON

GO
/****** Object:  Index [idx_programs]    Script Date: 4/17/2018 2:11:57 PM ******/
CREATE NONCLUSTERED INDEX [idx_programs] ON [dbo].[Users]
(
	[Program] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [idx_year]    Script Date: 4/17/2018 2:11:57 PM ******/
CREATE NONCLUSTERED INDEX [idx_year] ON [dbo].[Users]
(
	[YearOfJoining] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO



-------------------------------------------  TABLE CONSTRAINTS  ----------------------------------------



 /****** Table Constraints      Script Date: 4/26/2018 16:17:21 PM ******/

--- Default value for RSVP is set to no ---
ALTER TABLE [dbo].[Invitee] ADD  DEFAULT ('no') FOR [Rsvp]
GO

--- Default value for AdditionalGuests is set to 0 ---
ALTER TABLE [dbo].[Invitee] ADD  DEFAULT ((0)) FOR [AdditionalGuests]
GO

--- SchoolID in Department table references SchoolID in School table ---
ALTER TABLE [dbo].[Department]  WITH CHECK ADD  CONSTRAINT [FK_Department_School_SchoolID] FOREIGN KEY([SchoolID])
REFERENCES [dbo].[School] ([SchoolID])
GO
ALTER TABLE [dbo].[Department] CHECK CONSTRAINT [FK_Department_School_SchoolID]
GO

--- LocationID in Event table references LocationID in Location table ---
ALTER TABLE [dbo].[Event]  WITH CHECK ADD  CONSTRAINT [FK_Event_Location_LocationID] FOREIGN KEY([LocationID])
REFERENCES [dbo].[Location] ([LocationID])
GO
ALTER TABLE [dbo].[Event] CHECK CONSTRAINT [FK_Event_Location_LocationID]
GO

--- CreatedBy in Event table references UserID in Users table ---
ALTER TABLE [dbo].[Event]  WITH CHECK ADD  CONSTRAINT [FK_Event_Users_UserID] FOREIGN KEY([CreatedBy])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Event] CHECK CONSTRAINT [FK_Event_Users_UserID]
GO

--- EventID in Feedback table references EventID in Event table ---
ALTER TABLE [dbo].[Feedback]  WITH CHECK ADD  CONSTRAINT [FK_Feedback_Event_EventID] FOREIGN KEY([EventID])
REFERENCES [dbo].[Event] ([EventID])
GO
ALTER TABLE [dbo].[Feedback] CHECK CONSTRAINT [FK_Feedback_Event_EventID]
GO

--- EventID in Invitee table references EventID in Event table ---
ALTER TABLE [dbo].[Invitee]  WITH CHECK ADD  CONSTRAINT [FK_Invitee_Event_EventID] FOREIGN KEY([EventID])
REFERENCES [dbo].[Event] ([EventID])
GO
ALTER TABLE [dbo].[Invitee] CHECK CONSTRAINT [FK_Invitee_Event_EventID]
GO

--- UserID in Invitee table references UserID in Users table ---
ALTER TABLE [dbo].[Invitee]  WITH CHECK ADD  CONSTRAINT [FK_Invitee_Users_UserID] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Invitee] CHECK CONSTRAINT [FK_Invitee_Users_UserID]
GO

--- ClubID in Member table references ClubID in Club table ---
ALTER TABLE [dbo].[Member]  WITH CHECK ADD  CONSTRAINT [FK_member_club_clubID] FOREIGN KEY([ClubID])
REFERENCES [dbo].[Club] ([ClubID])
GO
ALTER TABLE [dbo].[Member] CHECK CONSTRAINT [FK_member_club_clubID]
GO

--- UserID in Member table references UserID in Users table ---
ALTER TABLE [dbo].[Member]  WITH CHECK ADD  CONSTRAINT [FK_member_Users_UserID] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO
ALTER TABLE [dbo].[Member] CHECK CONSTRAINT [FK_member_Users_UserID]
GO

--- DepartmentID in Users table references DepartmentID in Department table ---
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [FK_Users_Department_DepartmentID] FOREIGN KEY([DepartmentID])
REFERENCES [dbo].[Department] ([DepartmentID])
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [FK_Users_Department_DepartmentID]
GO

--- Restrict Rsvp in Invitee table to no, yes and maybe values ---
ALTER TABLE [dbo].[Invitee]  WITH CHECK ADD CHECK  (([Rsvp]='no' OR [Rsvp]='maybe' OR [Rsvp]='yes'))
GO

--- Restrict enrollmentstatus in Users table to alumni, online, parttime, or fulltime values ---
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [ck_enrollment] CHECK  (([enrollmentstatus]='alumni' OR [enrollmentstatus]='online' OR [enrollmentstatus]='partime' OR [enrollmentstatus]='fulltime'))
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [ck_enrollment]
GO

--- Restrict program in Users table to postdoc, phd, graduate and undergraduate values ---
ALTER TABLE [dbo].[Users]  WITH CHECK ADD  CONSTRAINT [ck_program] CHECK  (([program]='postdoc' OR [program]='phd' OR [program]='graduate' OR [program]='undergrad'))
GO
ALTER TABLE [dbo].[Users] CHECK CONSTRAINT [ck_program]
GO


-------------------------------------------  STORED PROCEDURES  ----------------------------------------


/****** Object:  StoredProcedure [dbo].[sp_createEvent]    Script Date: 4/17/2018 2:11:56 PM ******/

--- Create Stored Procedure sp_createEvent ---
/*
Used to create an event with the following details. Once the event is created, 
the guest type is checked namely club, department and school. Based on the guest type, 
the invitee details are displayed. 
*/

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF OBJECT_ID(N'DevilsCall.dbo.sp_createEvent', N'U') IS NULL
BEGIN
CREATE PROC [dbo].[sp_createEvent] 
@title nvarchar(200)='Event_',
@date date=null,
@time time,
@description nvarchar(1000),
@maxInvitees int,
@currentHeadCount int,
@maxGuests int,
@createdBy smallint,
@locationID smallint,
@overAllRating tinyint,
@guestType varchar(50)=null,
@guestTypeGroup varchar(50)=null
as
SET @date = ISNULL(@date, convert(date,GETDATE()))
SET @currentHeadCount = 0;
SET @overAllRating = 0;
if @title = 'Event_'
begin
set @title=@title + convert(varchar,current_timestamp)
end
--SET @time = ISNULL(@time, convert(time,CURRENT_TIMESTAMP))
BEGIN TRANSACTION;
BEGIN TRY
insert into dbo.Event 
values(@title,@date,@time,@description,@maxInvitees,@currentHeadCount,@maxGuests,@createdBy,@locationID,@overAllRating)

declare @eventid smallint
select @eventid=max(EventID) from dbo.Event  
where CreatedBy =@createdby


if lower(@guestType)='department'
begin
insert into Invitee(UserID,EventID)
select u.UserID,@eventid from Users u
join Department d on u.DepartmentID=d.DepartmentID
where d.DepartmentName=@guestTypeGroup
end

else if lower(@guestType)='school'
begin
insert into Invitee(UserID,EventID)
 select u.UserID,@eventid from Users u
join Department d on u.DepartmentID=d.DepartmentID
join School s on s.SchoolID=d.SchoolID
where s.SchoolName=@guestTypeGroup
end

else if lower(@guestType)='club'
begin
insert into Invitee(UserID,EventID)
select u.UserID,@eventid from Users u
join member m on u.userid=m.userid
join club c on c.clubid=m.clubid
where c.clubname=@guestTypeGroup
end

else if @guestType is null
begin
insert into Invitee(UserID,EventID)
select u.UserID,@eventid from Users u
end

select u.UserID,u.FirstName,u.LastName,u.EmailAddress
from users u join invitee i
on u.UserID=i.UserID
where i.EventID=@eventid

END TRY ----whole transaction
	BEGIN CATCH
	SELECT 
		ERROR_NUMBER() AS ErrorNumber
		,ERROR_SEVERITY() AS ErrorSeverity
		,ERROR_STATE() AS ErrorState
		,ERROR_PROCEDURE() AS ErrorProcedure
		,ERROR_LINE() AS ErrorLine
		,ERROR_MESSAGE() AS ErrorMessage;
				IF @@TRANCOUNT > 0
					ROLLBACK TRANSACTION;
	END CATCH;

	IF @@TRANCOUNT > 0
	COMMIT TRANSACTION;

END
GO


/****** Object:  StoredProcedure [dbo].[sp_createFeedback]    Script Date: 4/17/2018 2:11:56 PM ******/

--- Create Stored Procedure sp_createFeedback ---
/*
Used to accept feedback once an event is done. Feedback rating between 1 and 5 is expected 
to be given by the guest and the ratings are updated continuously in the Event table using triggers. 
*/

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF OBJECT_ID(N'DevilsCall.dbo.createFeedback', N'U') IS NULL
BEGIN
create proc [dbo].[sp_createFeedback]
@eventID smallint,
@comment nvarchar(200),
@feedBackRating tinyint
as
BEGIN TRANSACTION;
BEGIN TRY
insert into Feedback
values(@eventID,@comment,@feedBackRating)
	END TRY
	BEGIN CATCH
						SELECT 
							ERROR_NUMBER() AS ErrorNumber
							,ERROR_SEVERITY() AS ErrorSeverity
							,ERROR_STATE() AS ErrorState
							,ERROR_PROCEDURE() AS ErrorProcedure
							,ERROR_LINE() AS ErrorLine
							,ERROR_MESSAGE() AS ErrorMessage;

							IF @@TRANCOUNT > 0
								ROLLBACK TRANSACTION;
						END CATCH;

	IF @@TRANCOUNT > 0
	COMMIT TRANSACTION;
END
GO

/****** Object:  StoredProcedure [dbo].[sp_inviteeRsvp]    Script Date: 4/17/2018 2:11:56 PM ******/

--- Create Stored Procedure sp_inviteeRsvp ---
/*
This stored procedure is used to update the invitee list based on the RSVP of the invitee. 
Using the UserID, EventID, RSVP and the number of additional guests as specified by the invitee in the invitation email, 
the stored procedure is executed as soon as the invitee submits the form via email. The corresponding changes are made 
in the Events table to keep a tab of the RSVP’s and total guest count. If an invitee specifies an additional guest 
number that exceeds the maximum number allowed, proper error message indicating that 
“Maximum guests limit exceeded” is displayed.
*/

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF OBJECT_ID(N'DevilsCall.dbo.sp_inviteeRsvp', N'U') IS NULL
BEGIN
CREATE proc [dbo].[sp_inviteeRsvp]
@userID smallint,
@eventID smallint,
@rsvp nvarchar(10),
@additionalguests int
as
BEGIN
DECLARE @count int, @head int, @max int;
SELECT @head = CurrentHeadCount, @max = MaxInvitees, @count = MaxGuests FROM Event WHERE EventID = @eventID
IF @head+@count+1 <= @max
BEGIN 
IF @count >= @additionalguests  ---- condition to check if the user has exceeded the allowable guest count
BEGIN
BEGIN TRANSACTION;
	BEGIN TRY
	update invitee
	set rsvp=@rsvp,AdditionalGuests=@additionalguests
	where UserID=@userID and EventID=@eventID
	END TRY
	BEGIN CATCH
						SELECT 
							ERROR_NUMBER() AS ErrorNumber
							,ERROR_SEVERITY() AS ErrorSeverity
							,ERROR_STATE() AS ErrorState
							,ERROR_PROCEDURE() AS ErrorProcedure
							,ERROR_LINE() AS ErrorLine
							,ERROR_MESSAGE() AS ErrorMessage;

							IF @@TRANCOUNT > 0
								ROLLBACK TRANSACTION;
						END CATCH;

	IF @@TRANCOUNT > 0
	COMMIT TRANSACTION;
END
ELSE 
PRINT 'Max Guests exceeded. Please check!'
END
ELSE
PRINT 'Sorry, we are full!'
END
END
GO


/****** Object:  StoredProcedure [dbo].[sp_inviteeUpdateGuest]    Script Date: 4/17/2018 2:11:56 PM ******/

--- Create Stored Procedure sp_inviteeUpdateGuest ---
/*
This stored procedure is used to update the invitee list based on the change in number of additional guests
of the invitee. If an invitee specifies an additional guest number that exceeds the maximum number 
allowed, proper error message indicating that “Maximum guests limit exceeded” is displayed.
*/

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF OBJECT_ID(N'DevilsCall.dbo.sp_inviteeUpdateGuest', N'U') IS NULL
BEGIN
CREATE proc [dbo].[sp_inviteeUpdateGuest]
@userID smallint,
@eventID smallint,
@additionalguests int
as
BEGIN
DECLARE @count int, @head int, @max int;
SELECT @head = CurrentHeadCount, @max = MaxInvitees, @count = MaxGuests FROM Event WHERE EventID = @eventID
IF @head+@count+1 <= @max
BEGIN 
IF @count >= @additionalguests  ---- condition to check if the user has exceeded the allowable guest count
BEGIN
BEGIN TRANSACTION;
	BEGIN TRY
	update invitee
	set AdditionalGuests=@additionalguests
	where UserID=@userID and EventID=@eventID
	END TRY
	BEGIN CATCH
						SELECT 
							ERROR_NUMBER() AS ErrorNumber
							,ERROR_SEVERITY() AS ErrorSeverity
							,ERROR_STATE() AS ErrorState
							,ERROR_PROCEDURE() AS ErrorProcedure
							,ERROR_LINE() AS ErrorLine
							,ERROR_MESSAGE() AS ErrorMessage;

							IF @@TRANCOUNT > 0
								ROLLBACK TRANSACTION;
						END CATCH;

	IF @@TRANCOUNT > 0
	COMMIT TRANSACTION;
END
ELSE 
PRINT 'Max Guests exceeded. Please check!'
END
ELSE
PRINT 'Sorry, we are full!'
END
END
GO


/****** Object:  StoredProcedure [dbo].[sp_listOfInvitees]    Script Date: 4/17/2018 2:11:56 PM ******/

--- Create Stored Procedure sp_listOfInvitees ---
/*
This stored procedure is used to display all the invitees for a particular event. 
*/

SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF OBJECT_ID(N'DevilsCall.dbo.sp_listOfInvitees', N'U') IS NULL
BEGIN
CREATE proc [dbo].[sp_listOfInvitees]
@eventid smallint
as
select *
from dbo.v_listOfInvitees where EventID = @eventid
END
GO


/****** Object:  StoredProcedure [dbo].[sp_listOfEvents]    Script Date: 4/17/2018 2:11:56 PM ******/

--- Create Stored Procedure sp_listOfEvents ---
/*
This stored procedure is used to display list of all events. 
*/

IF OBJECT_ID(N'DevilsCall.dbo.sp_listOfEvents', N'U') IS NULL
BEGIN

CREATE proc [dbo].[sp_listOfEvents]
@Userid smallint
as
select EventID,Title, e.date,e.time, e.description,MaxInvitees,CurrentHeadCount,MaxGuests,l.Description,OverallRating
from Event e join users u on e.CreatedBy=u.UserID 
join Location l on e.LocationID=l.LocationID where 
UserID = @Userid
END
GO


/****** Object:  StoredProcedure [dbo].[sp_EditEvent]    Script Date: 4/17/2018 2:11:56 PM ******/

--- Create Stored Procedure sp_EditEvent ---
/*
This stored procedure is used to edit a particular event. 
*/

IF OBJECT_ID(N'DevilsCall.dbo.sp_EditEvent', N'U') IS NULL
BEGIN
CREATE proc [dbo].sp_EditEvent
@Eventid smallint,
@Title nvarchar(200),
@Date date,
@Time time(7),
@Description nvarchar(1000),
@MaxInvitees int,
@LocationID smallint
as
BEGIN TRANSACTION
BEGIN TRY
if @Title is not null
begin
Update event
set Title=@Title
where EventID=@Eventid
end
if @Date is not null
begin
Update event
set Date=@Date
where EventID=@Eventid
end
if @Time is not null
begin
Update event
set Time=@Time
where EventID=@Eventid
end
if @Description is not null
begin
Update event
set Description=@Description
where EventID=@Eventid
end
if @MaxInvitees is not null
begin
Update event
set MaxInvitees=@MaxInvitees
where EventID=@Eventid
end
if @LocationID is not null
begin
Update event
set LocationID=@LocationID
where EventID=@Eventid
end
END TRY
BEGIN CATCH
					SELECT 
							ERROR_NUMBER() AS ErrorNumber
							,ERROR_SEVERITY() AS ErrorSeverity
							,ERROR_STATE() AS ErrorState
							,ERROR_PROCEDURE() AS ErrorProcedure
							,ERROR_LINE() AS ErrorLine
							,ERROR_MESSAGE() AS ErrorMessage;

							IF @@TRANCOUNT > 0
								ROLLBACK TRANSACTION;
						END CATCH;

	IF @@TRANCOUNT > 0
	COMMIT TRANSACTION;
END
GO

--- Create Stored Procedure sp_EventInformation ---
/*
This stored procedure is used to display details of a particular event. 
*/

IF OBJECT_ID(N'DevilsCall.dbo.sp_EventInformation', N'U') IS NULL
BEGIN
CREATE proc [dbo].sp_EventInformation
@Eventid smallint
as
select *
from Event where 
EventID = @Eventid
END

GO






-------------------------------------------  TRIGGERS  ----------------------------------------



/****** Object: Trigger [dbo].[tr_invitee_current]     Script Date: 4/26/2018 16:23:18 PM ******/

--- Create Trigger tr_invitee_currenCountUpdateRsvp ---

/* This trigger is invoked when a record is updated in Invitee table.
When the Rsvp of an invitee is changed, the trigger is invoked to update 
the current head count for the event the invitee is going to attend. 
If the rsvp changes to yes or maybe from a no, then the number of guests 
and the invitee is added to the current head count for the event. 
If the rsvp changes to no, the number of guests and invitee is removed
from the current head count for the event. */

IF OBJECT_ID(N'DevilsCall.dbo.tr_invitee_currenCountUpdateRsvp', N'U') IS NULL
BEGIN

CREATE TRIGGER dbo.tr_invitee_currenCountUpdateRsvp
ON dbo.Invitee FOR UPDATE 
AS 
BEGIN
	 DECLARE @eventid int, @currentcount int,@count int, @rsvpn nvarchar(10), @rsvpo nvarchar(10);
	 SELECT  @eventid=EventID, @rsvpn=Rsvp FROM inserted;
	 SELECT @count = AdditionalGuests, @rsvpo = Rsvp FROM deleted; 
	 SET NOCOUNT ON
	IF UPDATE(Rsvp)
	   BEGIN
		IF @rsvpn <> @rsvpo
		BEGIN
		  IF (@rsvpn = 'yes' or @rsvpn = 'maybe') and @rsvpo = 'no'	
			 BEGIN
				SELECT @currentcount = CurrentHeadCount FROM Event WHERE EventID = @eventid
					BEGIN TRANSACTION;
						BEGIN TRY
							UPDATE Event SET CurrentHeadCount = (@currentcount + @count + 1) WHERE EventID=@eventid
							END TRY
						BEGIN CATCH
							SELECT 
								ERROR_NUMBER() AS ErrorNumber
								,ERROR_SEVERITY() AS ErrorSeverity
								,ERROR_STATE() AS ErrorState
								,ERROR_PROCEDURE() AS ErrorProcedure
								,ERROR_LINE() AS ErrorLine
								,ERROR_MESSAGE() AS ErrorMessage;

								IF @@TRANCOUNT > 0
									ROLLBACK TRANSACTION;
							END CATCH;

						IF @@TRANCOUNT > 0
							COMMIT TRANSACTION;
				END

		IF (@rsvpn = 'no') and (@rsvpo = 'yes' or  @rsvpo = 'maybe')	
			 BEGIN
				SELECT @currentcount = CurrentHeadCount FROM Event WHERE EventID = @eventid
					BEGIN TRANSACTION;
						BEGIN TRY
							UPDATE Event SET CurrentHeadCount = (@currentcount - @count - 1) WHERE EventID=@eventid
							END TRY
						BEGIN CATCH
							SELECT 
								ERROR_NUMBER() AS ErrorNumber
								,ERROR_SEVERITY() AS ErrorSeverity
								,ERROR_STATE() AS ErrorState
								,ERROR_PROCEDURE() AS ErrorProcedure
								,ERROR_LINE() AS ErrorLine
								,ERROR_MESSAGE() AS ErrorMessage;

								IF @@TRANCOUNT > 0
									ROLLBACK TRANSACTION;
							END CATCH;

						IF @@TRANCOUNT > 0
							COMMIT TRANSACTION;
				END
		
			END
	END
END
END

/****** Object: Trigger [dbo].[tr_events_currentCountUpdateGuests]     Script Date: 4/26/2018 17:00:12 PM ******/

---- Create Trigger [dbo].[tr_events_currentCountUpdateGuests] ---- 
/* This trigger is invoked when there is an update on Invitee table.
When the additional guest count is changed for an invitee, the current 
head count in the events table is updated. */

IF OBJECT_ID(N'DevilsCall.dbo.tr_events_currentCountUpdateGuests', N'U') IS NULL
BEGIN
CREATE TRIGGER dbo.tr_events_currentCountUpdateGuests
ON dbo.Invitee FOR UPDATE 
AS
BEGIN
 DECLARE @eventid int, @currentcount int, @old int, @new int, @rsvp nvarchar(10);
 SELECT @new = AdditionalGuests, @eventid=EventID, @rsvp=Rsvp FROM inserted;
 SELECT @old = AdditionalGuests FROM deleted; 
 SET NOCOUNT ON
 IF UPDATE(AdditionalGuests)
		BEGIN
		IF @old <> @new
		BEGIN
			SELECT @currentcount = CurrentHeadCount FROM Event WHERE EventID = @eventid
			BEGIN TRANSACTION;
				BEGIN TRY
					UPDATE Event SET CurrentHeadCount = @currentcount + @new - @old WHERE EventID=@eventid
					END TRY
				BEGIN CATCH
					SELECT 
						ERROR_NUMBER() AS ErrorNumber
						,ERROR_SEVERITY() AS ErrorSeverity
						,ERROR_STATE() AS ErrorState
						,ERROR_PROCEDURE() AS ErrorProcedure
						,ERROR_LINE() AS ErrorLine
						,ERROR_MESSAGE() AS ErrorMessage;

						IF @@TRANCOUNT > 0
							ROLLBACK TRANSACTION;
					END CATCH;

				IF @@TRANCOUNT > 0
					COMMIT TRANSACTION;
		END
	END
END
END

/****** Object: Trigger [dbo].[tr_feedback_feedbackrating]     Script Date: 4/26/2018 17:00:12 PM ******/

---- Create Trigger [dbo].[tr_feedback_feedbackrating] ----

/* This trigger is invoked when there is an insertion in Feedback table. 
The overall rating for the corresponding event is updated in Events table. */
 
IF OBJECT_ID(N'DevilsCall.dbo.tr_events_feedbackrating', N'U') IS NULL
BEGIN
CREATE TRIGGER dbo.tr_events_feedbackrating
ON dbo.Feedback FOR INSERT 
AS
BEGIN
DECLARE @rating tinyint, @eventid int, @overall tinyint, @count int; 
SELECT @rating = FeedbackRating, @eventid = EventID from inserted;
SELECT @overall = OverallRating FROM Event WHERE EventID =@eventid; 
SELECT @count = COUNT(FeedbackRating) FROM Feedback WHERE EventID =@eventid;
BEGIN TRANSACTION
	BEGIN TRY
	UPDATE Event SET OverallRating = (((@overall * @count) + @rating)/(@count + 1)) WHERE EventID = @eventid
	END TRY
	BEGIN CATCH
						SELECT 
							ERROR_NUMBER() AS ErrorNumber
							,ERROR_SEVERITY() AS ErrorSeverity
							,ERROR_STATE() AS ErrorState
							,ERROR_PROCEDURE() AS ErrorProcedure
							,ERROR_LINE() AS ErrorLine
							,ERROR_MESSAGE() AS ErrorMessage;

							IF @@TRANCOUNT > 0
								ROLLBACK TRANSACTION;
						END CATCH;
			IF @@TRANCOUNT > 0
				COMMIT TRANSACTION;
END
END


----------------------------------- END OF FILE -------------------------------------------