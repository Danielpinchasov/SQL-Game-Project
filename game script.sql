-- welcome to 'catch the fish game', if this is your first time, print: 'this is my first time'
-- if you already registered, you can move to the login screen.

-- user entered first time to the game
exec enter_the_game 'this is MY first time'

-- user has registered the game
exec enter_the_game 'this is not MY first time'


-- registration
-- user provided not the right values, such as young age or weak password or username and mail that already exists and more...
EXEC REGISTRATION 
@USERNAME = 'dani1', 
@PASSWORD = 'avie4561',
@FIRSTNAME = 'AVI',
@LASTNAME = 'COHEN',
@ADDRESS = 'HAMACABIM 5 TEL AVIV', 
@COUNTRY = 'israel', 
@MAIL = 'COVS14WAALLA.COM', 
@GENDER = 'male', 
@DATEPICKER = '2016-07-14'

-- registration
-- user provided wrong password
EXEC REGISTRATION 
@USERNAME = 'dani155', 
@PASSWORD = 'avie4561', 
@FIRSTNAME = 'AVI',
@LASTNAME = 'COHEN',
@ADDRESS = 'HAMACABIM 5 TEL AVIV', 
@COUNTRY = 'israel', 
@MAIL = 'COVS14@WAALLA.COM', 
@GENDER = 'male', 
@DATEPICKER = '2002-07-14'

-- registration
-- user provided the right values and succesfully registered the game
EXEC REGISTRATION 
@USERNAME = 'dani1', 
@PASSWORD = 'Avie4561', 
@FIRSTNAME = 'AVI',
@LASTNAME = 'COHEN',
@ADDRESS = 'HAMACABIM 5 TEL AVIV', 
@COUNTRY = 'israel', 
@MAIL = 'COVS10@WAALLA.COM', 
@GENDER = 'male', 
@DATEPICKER = '2005-07-14'

-- registration
-- user provided username that already exists
EXEC REGISTRATION 
@USERNAME = 'dani1', 
@PASSWORD = 'Avie4561', 
@FIRSTNAME = 'AVI',
@LASTNAME = 'COHEN',
@ADDRESS = 'HAMACABIM 5 TEL AVIV', 
@COUNTRY = 'israel', 
@MAIL = 'COVS40@WAALLA.COM', 
@GENDER = 'male', 
@DATEPICKER = '2005-07-14'


-- login
-- user log in with the wrong values
exec login_check
@username = 'beni1234',
@password = 'Av61'


-- login
-- user successfully login with correct username and password
exec login_check
@username = 'dani1',
@password = 'Avie4561'


-- Selection menu
-- welcome to main menu, if you want to enter the score table, press SCORE and then enter your USERNAME. 
-- if you want to play the game press GAME and the enter your USERNAME.

-- user entered his SCORE table with his real username 
-- (his fishername field will be 'null' because he didn't choose any fishername yet)
DECLARE @Catch NVARCHAR
EXEC @CATCH = Selection_menu 'score','dani1'
go

-- user entered his SCORE table with wrong username
DECLARE @Catch NVARCHAR
EXEC @CATCH = Selection_menu 'score','avi5'
go

-- user want to move forward to the game
DECLARE @Catch NVARCHAR
EXEC @CATCH = Selection_menu 'game','dani1'
go

-- choose your fish
-- please choose your fish from the table below
select Fishername from Fishermen

-- please provide your username and type the fish you want to bet on him
DECLARE @Catch NVARCHAR
EXEC @CATCH = Fishermen_Representative 'Fishenzon', 'dani1'
go

-- now the user can see his fishername on his score table
DECLARE @Catch NVARCHAR
EXEC @CATCH = Selection_menu 'score','dani1'
go

-- in this step the user provide his username and play the game
-- you can execute this code multiple times
exec play_the_game 
@username = 'dani1'



select * from Scores
select * from Users
select * from Fishermen
delete from Scores
delete from Users
