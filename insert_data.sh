#! /bin/bash

if [[ $1 == "test" ]]
then
  PSQL="psql --username=postgres --dbname=worldcuptest -t --no-align -c"
else
  PSQL="psql --username=freecodecamp --dbname=worldcup -t --no-align -c"
fi

# Do not change code above this line. Use the PSQL variable above to query your database.
cat games.csv | while IFS="," read Year Round Winner Opponent Winner_goals Opponent_goals
do
 if [[ $Year != "year" ]]
  then
   #Get Winner id
   Winner_id=$($PSQL "Select team_id from teams where name='$Winner'")
   if [[ -z $winner_id ]]
     then
      echo $($PSQL "Insert into teams(name) Values('$Winner')")
   fi
   #Get opponent Id
   Opponent_id=$($PSQL "Select team_id from teams where name='$Opponent'")
   if [[ -z $Opponent_id ]]
     then
      echo $($PSQL "Insert into teams(name) Values('$Opponent')")
   fi
  fi
done

cat games.csv | while IFS="," read Year Round Winner Opponent Winner_goals Opponent_goals
do
 if [[ $Year != "year" ]]
   then
     Winner_id=$($PSQL "Select team_id from teams where name='$Winner'")
     Opponent_id=$($PSQL "Select team_id from teams where name='$Opponent'")
     echo $($PSQL "Insert into games(year,round,winner_goals,opponent_goals,winner_id,opponent_id) Values($Year,'$Round',$Winner_goals,$Opponent_goals,$Winner_id,$Opponent_id)")
 fi
done
