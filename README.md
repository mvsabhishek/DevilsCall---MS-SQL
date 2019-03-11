# DevilsCall --- IFT 530 Advanced SQL Programming Course Project

## OBJECTIVE: 

The objective of our project is to develop a comprehensive student event evite and management web application that can be adapted across all student organizations in ASU. We want to implement core powerful functionality with a resilient database along with a GUI that can be easily used by all individuals.

## TECHNOLOGY:

SQL Server Management Studio, MS-SQL Server

## REQUIREMENTS:

1.	Login Page- Users will login using emailed and password.
2.	Create E-Vite- Students can create new event with date, time, location, event description, RSVP option etc and send out invitations. This will be a form feature as part of our application.
3.	RSVP option- Invitation RSVP will have option for invitees to include additional guests if they want to and if they are allowed to. The creator has control over this option and will help manage the event invitees.
4.	Invitees group- Event organizer can send invitations to groups based on club (list of members) or department or school. If no option, invitations are sent to all the students.
5.	Edit event details- Event organizer can modify events at a later point of time in case there is any change in the event and notify all the attendees.
6.	Send Reminder- Event organizer can decide to send reminder of the event to the invitees. This will be helpful in case some guest forgets to RSVP for the event. The RSVP will close based on how the organizer sets it. (It can be one day before or one week before the party)
7.	Invitee response- Attendee will be able to respond to the invitation through email. And the status is updated in the Invitee and event table. 
8.	When the invitees respond, the headcount data is updated in Event table.
9.	Feedback option- After the party, there will be one feedback option based on which organizers can plan future events in a better way. This feedback option will be mailed to the attendees once the event is done with. 
10.	When the Feedback table is updated, the total rating of the event is updated.
11.	List of invitees– This consists of a list of all people invited 
12.	Event details – This consists of all information about the event like date, venue, organizer and many more
13.	List of events - This gives us the list of all planned events for the user.

## DATABASE DESIGN

![ERD Diagram](https://github.com/mvsabhishek/DevilsCall/)
