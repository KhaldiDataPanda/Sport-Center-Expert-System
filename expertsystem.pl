:-dynamic(stadium/3).
:-dynamic(player/4).
:-dynamic(team/3).
:-dynamic(occupancy/4).

start:-
      write('-------------------------------\n'),
      write('azul fellawen to sport club'), menu.

menu:-
      nl, write('-------------------------------\n'),
      write('Menu: [remember the dot, choose with a number]'),nl,
      write('1. play a football game with other team.'),nl,
      write('2. create a team.'),nl,
      write('3. inscription to the gym.'),nl,
      write('4. End.'),nl,    
      write('-------------------------------\n'), nl,
      read.

read:-
    read(R), ((R==1,showstadiums); (R==2,create_team); (R==3,inscription_for_gym);(R==4, end)).

%---------------------OPTION 1

showstadiums :-
write('-------------------------------\n'),

nl, write('OUR STADIUMS <3 :\n'),
        nl, write('choose one of them [write the name of the stadium, dont forget the dot] '),nl,       
        stadium(X,Y,Z),write('==>Name: '),write(X),write('\t\t\t Capacity:  '),write(Y), nl,
        write('\tEquipment: '), write(Z),
        nl,fail;choose_stadium.

choose_stadium:- 
    read(R), 
    ((R==stade1,write('you have chosen stadium1'),nl,
    write('choose your team'),nl,
    write("1. team_prolog"),nl,write("2. team_barca"),nl,write("3. other"),
    choose_teams_hour(R))
     ;
    (R==stade2,write('you have chosen stadium2'),nl,
    write('choose your team'),nl,
    write("1. team_blida"),nl,write("2. team_alger"),nl,write("3. other"),
    choose_teams_hour(R))).

choose_teams_hour(STADE):-
    read(T),
    write('choose the other team'),nl,
    read(Differentteam),
    (T \= Differentteam ->
        write('now pick the hour u gonna play in '),nl,
        write("write hour in format h.m"),nl,write("example: 8.20"),nl,
        choose_hour(STADE,T,Differentteam)
    ;
        write('u picked the same team ur in !'),nl,   
        choose_teams_hour(STADE)   
    ).  

choose_hour(STADE,T,Differentteam):-
     read(Hour),
    (occupancy(STADE,Hour,_,Differentteam) ->
            write('this hour is already taken'),nl,
            choose_hour(STADE,T,Differentteam)
            ;
            assert(occupancy(STADE,Hour,T,Differentteam)),
            write('DONE!'),nl,
            write('-------------------------------\n'),nl,
            write('do u want to see the history of the games of the team u choosed to play against '),nl,
            write("1. yes"),nl,write("2. no"),nl,
            read(R),
            ((R==1,write("give us 18 in td and tp to unlock this option XD"), menu);(R==2,menu))          
            ).

%---------------------OPTION 2

create_team :-
write('-------------------------------\n'),

nl, write('select the size of the team [enter 1/2 dont forget the dot] :\n'),
    
        write('1. 8 '),nl,
        write('2. 10 '),nl,
        
    nl,fail;choose_team.

choose_team:- read(R), ((R==1,create_teamof8); (R==2,create_teamof10)).

create_teamof8:-write('you have chosen 8'),nl,
    write('enter the name of the team'),nl,
    read_teamname8.

read_teamname8:- 
    read(TEAMNAME),
    nl,
    (
        \+ team(TEAMNAME,8,_) ->
        assert(team(TEAMNAME,8,[])),
        write('your team is created '),write(TEAMNAME), nl
    ;
        write('this name is already taken.'), nl,
        read_teamname8    
    ),
    players_of_ur_team8(TEAMNAME).

players_of_ur_team8(TEAMNAME):-
    
    write('give us the coordonaties of the 8 players one by one '),nl,
    player_id8(TEAMNAME),
    player_id8(TEAMNAME)
    ,player_id8(TEAMNAME),
    player_id8(TEAMNAME),
    player_id8(TEAMNAME),
    player_id8(TEAMNAME)
    ,player_id8(TEAMNAME),
    player_id8(TEAMNAME),
    write("done!!!").
    
player_id8(TEAMNAME):-
    write('enter the name of the player'),nl,
    read(NAME),
    assert(player(NAME,TEAMNAME,NO,_)),
    write("name "),  write(NAME), nl,
     write('team_name '),write(TEAMNAME),nl.

create_teamof10:-write('you have chosen 10'),nl,
    write('enter the name of the team'),nl,
    read_teamname8.

read_teamname10:- 
    read(TEAMNAME),
    nl,
    (
        \+ team(TEAMNAME,10,_) ->
        assert(team(TEAMNAME,10,[])),
        write('your team is created '),write(TEAMNAME), nl
    ;
        write('this name is already taken.'), nl       
    ),
    players_of_ur_team10(TEAMNAME).

players_of_ur_team10(TEAMNAME):-
    
    write('give us the coordonaties of the 10 players one by one '),nl,
    player_id10(TEAMNAME),
    player_id10(TEAMNAME)
    ,player_id10(TEAMNAME),
    player_id10(TEAMNAME),
    player_id10(TEAMNAME),
    player_id10(TEAMNAME)
    ,player_id10(TEAMNAME),
    player_id10(TEAMNAME),
    write("done!!!"),
    menu.
    

player_id10(TEAMNAME):-
    write('enter the name of the player'),nl,
    read(NAME),
    assert(player(NAME,TEAMNAME,NO,_)),
    write("name ")  ,  write(NAME), nl, write('team_name '),write(TEAMNAME),nl,
    write('-------------------------------\n'). 

%---------------------OPTION 3

inscription_for_gym :-
write('-------------------------------\n'),nl,
    nl, write("give us ur id"),nl,
    read(ID),
    nl,
    (
        \+ player(ID,_,inscription,_) ->
        
        
        (inscription = YES ->
        
        write('u are already inscripted'),nl,
        menu;
        offers(ID)
        );
        write('u are not a student'),nl,menu
        ).

offers(ID):-
        nl, write('offers <3 :\n'),
        write('one month: 4000DA '),nl,
        write('three month: 10000DA '),nl,
        write('one day: 300DA '),nl,
        write('-------------------------------\n'),
        write('choose one of them [write the number of the offer, dont forget the dot] '),nl,
        read(R),
        (((R==1,write('you have chosen one month offer'),nl,player(ID,_,_,inscription,one_month));
        (R==2,write('you have chosen three month offer'),nl,play);
        (R==3,write('you have chosen one day offer'),nl,player(ID,_,_,inscription,one_day)))),
        write('-------------------------------\n'),nl,
        nl,fail,menu.

end:-halt.

stadium(stadium_ID,Capacity,Equipment).
stadium(stade1,16,[projector]).
stadium(stade2,20,[projector,two_balls, Goalkeeper_gloves]).  

player(player_id,team_id,inscription_gym,offer).
player(looser_1,team_prolog,YES,_). 
player(looser_2,team_prolog,NO,_).        
player(looser_3,team_prolog,NO,_).
player(looser_4,team_prolog,NO,_).
player(looser_5,team_prolog,NO,_).
player(looser_6,team_prolog,NO,_).
player(looser_7,team_prolog,NO,_).
player(looser_8,team_prolog,NO,_).

team(team_ID,Capacity,Needs).
team(team_prolog,8,[shirts]).
team(team_barca,8,[]).
team(team_blida,10,[]).
team(team_alger,10,[]).

occupancy(stadium_ID,Hour,team1_id,team2_id).
occupancy(stade1,8.20,team_prolog,team_barca).

