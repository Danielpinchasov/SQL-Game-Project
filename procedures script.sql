-- welcome, please follow the instructions bellow and then create the procedures game
Use master
Go
-------------------------------------------------------------
create database [Catch the Fish]
-------------------------------------------------------------
Use [Catch the Fish]
Go
-------------------------------------------------------------
--- Gender Table ---
Create table [GENDER]
([GenderID] INT IDENTITY(1,1) not null,
[GenderName] nvarchar (10) PRIMARY KEY not null)

insert into GENDER
values ('Male'), ('Female')

---------------------------------------------------------------
--- Country Table --
create table Country
([CountryID] int IDENTITY(1,1) not null,
[CountryName] nvarchar (50) primary key not null)

insert into country
values ('Afghanistan'),('Albania'),('Algeria'),('Andorra'),('Angola'),
		('Antigua and Barbuda'),('Argentina'),('Armenia'),('Australia'),('Austria'),
		('Azerbaijan'),('Bahamas'),('Bahrain'),('Bangladesh'),('Barbados'),
		('Belarus'),('Belgium'),('Belize'),('Benin'),('Bhutan'),
		('Bolivia'),('Bosnia and Herzegovina'),('Botswana'),('Brazil'),('Brunei'),
		('Bulgaria'),('Burkina Faso'),('Burundi'),('Cambodia'),('Cameroon'),
		('Canada'),('Central African Republic'),('Chad'),('Chile'),('China'),
		('Colombia'),('Congo'),('Costa Rica'),('Croatia'),('Cuba'),
		('Cyprus'),('Czechia'),('Denmark'),('Dominican Republic'),('Ecuador'),
		('Egypt'),('El Salvador'),('Equatorial Guinea'),('Eritrea'),('Estonia'),
		('Ethiopia'),('Fiji'),('Finland'),('France'),('Gabon'),
		('Gambia'),('Germany'),('Ghana'),('Greece'),('Guatemala'),
		('Guinea'),('Haiti'),('Honduras'),('Hungary'),('Iceland'),
		('India'),('Indonesia'),('Iran'),('Iraq'),('Irland'),
		('Israel'),('Italy'),('Jamaica'),('Japan'),('Jordan'),
		('Kazakhstan'),('Kenya'),('Kuwait'),('Kyrgyzstan'),('Laos'),
		('Latvia'),('Lebanon'),('Liberia'),('Libya'),('Liechtenstein'),
		('Lithuania'),('Luxembourg'),('Madagascar'),('Malawi'),('Malaysia'),
		('Maldives'),('Mali'),('Malta'),('Marshall Islands'),('Mauritania'),
		('Mauritius'),('Mexico'),('Micronesia'),('Moldova'),('Monaco'),
		('Mongolia'),('Montenegro'),('Morocco'),('Mozambique'),('Myanmar'),
		('Namibia'),('Nepal'),('Netherlands'),('New Zealand'),('Nicaragua'),
		('Niger'),('Nigeria'),('North Korea'),('North Macedonia'),('Norway'),
		('Pakistan'),('Panama'),('Papua New Guinea'),('Paraguay'),('Peru'),
		('Philippines'),('Poland'),('Portugal'),('Qatar'),('Romania'),
		('Russia'),('Rwanda'),('Saudi Arabia'),('Senegal'),('Serbia'),
		('Sierra Leone'),('Singapore'),('Slovakia'),('Slovenia'),('Solomon Islands'),
		('Somalia'),('South Africa'),('South Korea'),('Spain'),('Sri Lanka'),
		('Sudan'),('Sweden'),('Switzerland'),('Syria'),('Tajikistan'),
		('Thailand'),('Togo'),('Trinidad and Tobago'),('Tunisia'),('Turkey'),
		('Turkmenistan'),('Uganda'),('Ukraine'),('United Arab Emirates'),('United Kingdom'),
		('USA'),('Uruguay'),('Uzbekistan'),('Venezuela'),('Vietnam'),
		('Yemen'),('Zambia'),('Zimbabwe'),('Oman'),('Tanzania')

-------------------------------------------------------------------------
---Users Table--

create TABLE Users
([UserID] int IDENTITY(1,1) PRIMARY KEY NOT NULL,
[UserName] nvarchar (50) not null,
[Password] nvarchar (50) not null ,
[RegisterDate] DATE NOT NULL,
[LastName] nvarchar (20) NOT NULL,
[FirstName] nvarchar(20) NOT NULL,
[Address] nvarchar(60) NULL,
[countryname] nvarchar (50) NOT null ,
[EMail] nvarchar (50) not null,
[Gendername] nvarchar (10),
[BirthDate] DATE null,
[LogInStatus] Bit DEFAULT 0
)

ALTER TABLE [dbo].[users] ADD CONSTRAINT [FK_users_country] FOREIGN KEY([countryname])
REFERENCES [dbo].[Country] ([Countryname])
GO

ALTER TABLE [dbo].[Users] ADD  CONSTRAINT [FK_Users_Gender] FOREIGN KEY([GenderName])
REFERENCES [dbo].[GENDER] ([GenderName])
GO

ALTER TABLE [dbo].[Users] ADD CONSTRAINT
[DF_RegisterDate] DEFAULT GETDATE() FOR [RegisterDate]
GO

----------------------------------------------------------------------
---Fishermen Table---

Create table Fishermen
(
FishermenID int IDENTITY(1,1) PRIMARY KEY NOT NULL,
Fishername nvarchar (40) not null
)

insert into Fishermen
values 
('Fishenzon'),
('GefilteFish'),
('FishAndChips')


-------------------------------------------------------------------------
--- Score table ---
CREATE table Scores
(
[UserID] int not null,
BonusType nvarchar (40) not null,
BounusCode Int IDENTITY(20,1) PRIMARY KEY NOT NULL,
BonusAmount int not null,
BonusDate DATE default getdate() not null,
FishermenID int
)

ALTER TABLE [dbo].[Scores] ADD  CONSTRAINT [FK_Scores_userID] FOREIGN KEY([UserID])
REFERENCES [dbo].[Users] ([UserID])
GO

ALTER TABLE [dbo].[Scores]  ADD  CONSTRAINT [FK_Scores_FishermenID] FOREIGN KEY([FishermenID])
REFERENCES [dbo].[Fishermen] ([FishermenID])
GO


-- section 1
-- this procedure is the first screen that the user see
CREATE PROCEDURE enter_the_game (@first_visit nvarchar(30))
As
IF @first_visit = 'this is my first time' 
	Begin
		PRINT('go to registration')
		return
	end
else
	Begin
		print('go to login')
	    return
	End
go

-- section 2, section 3, and section 4
-- registration screen
-- this procedure contains all the data constraints that should be entered when the user first registers.
-- In addition, if the user managed to register, he gets 1000 points. And he get notification about that
CREATE PROCEDURE REGISTRATION 
(
@USERNAME nvarchar(50), 
@PASSWORD NVARCHAR(50),
@LASTNAME NVARCHAR(20), 
@firstname NVARCHAR(20), 
@ADDRESS NVARCHAR(60), 
@COUNTRY nvarchar(50), 
@MAIL NVARCHAR(50), 
@GENDER NVARCHAR(10), 
@DATEPICKER DATE
)
as 
declare @number int
set @number = (select DATEDiff(yyyy,@DATEPICKER,getdate()))

declare @random_Number int
set @random_Number = FLOOR(RAND()*(1000-1+1)+1)

if @number < 13
	PRINT 'The game permitted for 13 years old and up. 
Hope to see you again once you reach the age of 13'
else
IF EXISTS (SELECT * FROM users WHERE @MAIL = EMail)
	PRINT 'This email address is taken. Please choose another one'
else
if (@mail not like '%@%')
	PRINT 'invalid email'
else
IF EXISTS (SELECT * FROM users WHERE @username = username)
	PRINT 'invalid username, you can use this: ' + @username + '' + CAST(@random_Number as varchar(10))
else
if len(@password)<7
PRINT 'The Password must contain atleast 7 letters'
else
if @password not like '%[0-9]%'
PRINT 'The Password must contain atleast 1 number'
else
if @password COLLATE Latin1_General_BIN not LIKE '%[a-z]%'
print 'The Password must contain atleast 1 small letter'
else
if @password COLLATE Latin1_General_BIN not like  ('%[A-Z]%')
print 'The Password must contain atleast 1 big letter'
else
if @password like '%password%'
print  'The Password cant contain the word [Password] in any combination'
else
if @PASSWORD = @USERNAME
print ' the password cannot be like user name'

-- If all the conditions are not correct, then values can be entered in the user table
else
	begin
		INSERT INTO users
			VALUES (@USERNAME, 
					@PASSWORD, 
					default, 
					@lastname, 
					@FIRSTNAME, 
					@ADDRESS, 
					@COUNTRY, 
					@MAIL, 
					@GENDER, 
					@DATEPICKER,
					default)
		insert into scores
		values (@@identity,'Registration',1000,default,null)
		print '
		you have sucssesfully registered.
		you get 1000 points as a gift,

		please log in'
	end
go

select * from users
go

-- after the user has succesfully registered, he need to login.
-- this procedure check if the user logged in. 
-- if the user logged in succesfully, his login status change from 0 to 1. if not his login status stay 0
create PROCEDURE login_check (@username nvarchar(50), @password nvarchar(50))
As
IF EXISTS (SELECT * FROM users WHERE username = @username and [password] = @password)
	BEGIN
		UPDATE users
			SET LogInStatus = 1
			where UserName = @username and [password] = @password

		PRINT 'login complete'
	END
ELSE
	BEGIN
		PRINT 'you dont have user, go to registration 
		or you already logged in'
	END
go

select * from users

go
-- section 6: Selection menu
-- in this procedure, the user can see his score table or move to the game.
-- the user need to provide his username and choose his option to complete this step.
create PROCEDURE Selection_menu (@menu nvarchar(10), @username nvarchar(50))
As
if @menu = 'score'
-- this is the table that we create for users so they can see their achievements in the game
	select u.UserName, BonusAmount, FisherNAME
	from Scores s full join users u
	on s.UserID = u.UserID full join Fishermen f
	on f.FishermenID = s.FishermenID
	where u.username = @username
else
if @menu = 'game'
begin
	print 'welcome to the game'
end
go

go
-- section 7
-- choose your fish
-- the user need to provide his username and choose his option to complete this step.
-- in this step the user need to bet on one fish (he's got only 3 option).
-- if he bet on the wrong fish he looses points, if he bet on the winner he get 1000 points.
create procedure Fishermen_Representative(@fishername nvarchar(30), @username nvarchar(50))
as
IF EXISTS (SELECT * FROM Fishermen WHERE @fishername = fishername)
begin
if @fishername = 'Fishenzon' and @username = (select username from users where UserName = @username)
	begin
		UPDATE scores
		SET FishermenID = 1	
			where userID = (select userid from Users where UserName = @username)
		print 'great, now when you choose your fish you can play the game'
	end
else
if @fishername = 'GefilteFish' and @username = (select username from users where UserName = @username)
	begin
		UPDATE scores
		SET FishermenID = 2	
			where userID = (select userid from Users where UserName = @username)
		print 'great, now when you choose your fish you can play the game'
	end
else
if @fishername = 'FishAndChips' and  @username = (select username from users where UserName = @username)
	begin
		UPDATE scores
		SET	FishermenID = 3
			where userID = (select userid from Users where UserName = @username)
		print 'great, now when you choose your fish you can play the game'
	end
end
go


go
-- section 8 play the game procedure
-- this procedure checking the username that provided by the username, if the username exists the game will be run
-- we have 10 rounds in this game
-- in the last round the user see if he lost or win and how much points be earned
create procedure play_the_game (@username nvarchar(50))
as
IF EXISTS (SELECT * FROM Users WHERE @username = UserName)
begin
	DECLARE @Counter INT 
	SET @Counter=1

		declare @FISH_1 nvarchar (20)
		declare @f1 int
		declare @upper_f1 int
		declare @lower_f1 int
	
		set @FISH_1 = '1'
		set @upper_f1 = 5
		set @lower_f1 = 1
		set @f1 = cast((RAND()*(1 + @upper_f1-@lower_f1)+@lower_f1) as int)

-- same code but for fish number 2
		declare @FISH_2 nvarchar (20)
		declare @f2 int
		declare @upper_f2 int
		declare @lower_f2 int
	
		set @FISH_2 = '2'
		set @upper_f2 = 5
		set @lower_f2 = 1
		set @f2 = cast((RAND()*(1 + @upper_f2-@lower_f2)+@lower_f2) as int)

-- same code but for fish number 3
		declare @FISH_3 nvarchar (20)
		declare @f3 int
		declare @upper_f3 int
		declare @lower_f3 int
	
		set @FISH_3 = '3'
		set @upper_f3 = 5
		set @lower_f3 = 1
		set @f3 = cast((RAND()*(1 + @upper_f3-@lower_f3)+@lower_f3) as int)

-- now we declare a new variable that will give as the winning fish number in every single game
	declare @winning_fish nvarchar (50)
	set @winning_fish = FLOOR(RAND()*(3-1+1)+1)

-- while loop for 9 rounds in the game
	while ( @Counter <= 9)

	BEGIN

	print '********************************************************************************************************************'

	print replicate ('.  ', @f1)+@FISH_1 + '><((0>'

	print replicate ('.  ', @f2)+@FISH_2 + '><((0>-----'

	print replicate ('.  ', @f3)+@FISH_3 + '><((0>+++++'

	--print '***********************************************************************************************************'
    
		SET @Counter  = @Counter  + 1
		set @f1 = cast((RAND()*((1 + @upper_f1)-@Lower_f1)+@f1+1) as int)
		set @f2 = cast((RAND()*((1 + @upper_f2)-@Lower_f2)+@f2+1) as int)
		set @f3 = cast((RAND()*((1 + @upper_f3)-@Lower_f3)+@f3+1) as int)
		
	END
	 
-- in the last round we did the same thing, but now we announce the winning fish
	while ( @Counter = 10)
	BEGIN

	print '********************************************************************************************************************'

	print replicate ('.  ', @f1)+@FISH_1 + '><((0>'

	print replicate ('.  ', @f2)+@FISH_2 + '><((0>-----'

	print replicate ('.  ', @f3)+@FISH_3 + '><((0>+++++'

	print 'the winner fish is fish number  ' + @winning_fish

	--print '***********************************************************************************************************'
    
		SET @Counter  = @Counter  + 1
		set @f1 = cast((RAND()*((1 + @upper_f1)-@Lower_f1)+@f1+1) as int)
		set @f2 = cast((RAND()*((1 + @upper_f2)-@Lower_f2)+@f2+1) as int)
		set @f3 = cast((RAND()*((1 + @upper_f3)-@Lower_f3)+@f3+1) as int)
		
	END
-- now we set a condition that say: if the user choose the winning fish, he won the game and earn 1000 points
-- the winning fish number must be equal to the fisherman id that the user choose before
 if @winning_fish = (select Fishermenid 
					 from scores s join users u 
					 on u.UserID = s.UserID 
					 where username = @username)
  begin
	update scores
		set BonusAmount = BonusAmount + 1000
		where userID = (select userid from Users where UserName = @username)
		print 'you are the winner, you earn 1000 points' 
   end
-- if the user choose the fish that lost the game, he lost the game and also 100 points
 else
	if @winning_fish <> (select Fishermenid 
					     from scores s join users u 
					     on u.UserID = s.UserID 
					     where username = @username)
	begin
		update scores
			set BonusAmount = BonusAmount - 100
			where userID = (select userid from Users where UserName = @username)
            print 'you lose, you lost 100 points '
	end
end
go