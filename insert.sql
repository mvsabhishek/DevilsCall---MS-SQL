--- Insert Sample data for Club ---
insert into dbo.Club values('ISA', '2001-01-01')
insert into dbo.Club values('Nerdherd', '2010-01-01')
insert into dbo.Club values('Soda', '2011-01-01')
insert into dbo.Club values('WiCS', '2009-01-01')


--- Insert data for school ---
insert into dbo.School values('Polytechnic')
insert into dbo.School values('Ira A Fulton')
insert into dbo.School values('WP Carey')
insert into dbo.School values('Mary Lou Fulton')

--- Insert data for department ---
insert into dbo.Department values('IFT', 1)
insert into dbo.Department values('EGR', 1)
insert into dbo.Department values('CSE', 2)
insert into dbo.Department values('BSA', 3)
insert into dbo.Department values('EEE', 2)
insert into dbo.Department values('EDU', 4)

--- Insert data for location ---
insert into dbo.Location values(1, 'Next to Subway', 'Student Union, Polytech Campus, ASU, Mesa')
insert into dbo.Location values(2, 'Behind AWA Lawns', 'Room 100, CISDE, Tempe Campus, ASU, Tempe')
insert into dbo.Location values(3, 'First Floor', 'Room 130, Sutton Hall, Polytech Campus, ASU, Mesa')

--- Insert data for users ---
insert into dbo.Users values('jkGyllen@asu.edu', 'Jake', 'Gyllenhal', 1, 'undergrad', '2017-01-01', 'fulltime')
insert into dbo.Users values('maggGylle@asu.edu', 'Maggie', 'Gyllenhal', 3, 'undergrad', '2016-01-01', 'partime')
insert into dbo.Users values('alokSahu@asu.edu', 'Alok', 'Sahu', 2, 'graduate', '2015-01-01', 'fulltime')
insert into dbo.Users values('adikaly@asu.edu', 'Aditya', 'Kalyanaraman', 1, 'graduate', '2017-01-01', 'fulltime')
insert into dbo.Users values('tomBrady@asu.edu', 'Tom', 'Brady', 1, 'graduate', '2017-01-01', 'fulltime')



--- Stored Procedures ----
EXEC dbo.sp_createEvent 'Chat on Chaat', '2018-12-01', '14:12:23', 'Some Description Blah Blah', 20, 0, 3, 1, 2, 0, 'department', 'IFT';
EXEC dbo.sp_createEvent 'NerdHack 2018', '2018-12-01', '14:12:23', 'Some Description Blah Blah', 2, 0, 1, 2, 3, 0, 'club', 'Soda';
EXEC dbo.sp_createEvent 'Homecoming Poly 2018', '2018-12-01', '14:12:23', 'Some Description Blah Blah', 100, 0, 4, 4, 3, 0, 'school', 'Polytechnic';
EXEC dbo.sp_createFeedback 1, 'Good Job', 4;
EXEC dbo.sp_createFeedback 1, 'Okay Job', 2;
-- Demo -- Create Event
EXEC dbo.sp_createEvent 'New Event at Poly 2018', '2018-12-01', '14:12:23', 'Some Description Blah Blah', 100, 0, 2, 5, 3, 0, 'school', 'WP Carey';


-- Demo -- Edit Event
EXEC dbo.sp_EditEvent 4, 'Title Changed', null, null, null, null, 4;

-- Demo -- Create Feedback
EXEC dbo.sp_createFeedback 1, 'Didnt like it :/', 1;

-- Demo -- EventInfo
EXEC dbo.sp_EventInformation 1;

-- Demo -- inviteeRsvp ------
EXEC dbo.sp_inviteeRsvp 1, 1, 'no', 3;

-- Demo -- inviteUpdate
EXEC dbo.sp_inviteeUpdateGuest 1, 1, 4;

-- Demo -- listofEvents a user is invited for
EXEC dbo.sp_listOfEvents 1;

-- Demo -- list of invitees for an event
EXEC dbo.sp_listOfInvitees 5;












