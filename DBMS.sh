#! /bin/bash

# =======================================================

# this is Shell Script Project for Python Track at Mansoura
# =======================================================
echo "
Created using shell script by: 
=======================================================

1. Abdelrahman Tarek.
2. Mohamed Hamed.
3. Mohamed Elsayed Ibrahim.
=======================================================
"; 

mkdir ~/database  2> /dev/null






#============================================================= 

function createDatabase {
	echo "=============================";
	echo "please enter database name" ;
	read database_name; 
	
	if [[ ! -d ~/database/$database_name ]];
		then	mkdir ~/database/$database_name;
				if [[ $? -eq 0 ]]; then
					echo "==============================";
					echo " Database [$database_name] Has Been Created Successfully" ;
					echo "==============================";

				else	
					echo "Error in  Creating the Database" ;
				fi
	else	
		echo "The [$database_name] Database Already Exists";
		echo "please, enter a valid name"
		echo "==============================";
		createDatabase; 

	fi

}
#================================================================
function listDatabase {

	if [[ ! -d ~/database ]]	
	then 	
		echo " there are no databases created, please create one first";
		echo "========================================================";
		main_menu; 
	else 
		cd ~/database ; 
		echo "Available Databases:";
		echo " ";
		ls . ; 
		echo "========================================================";
	select returnOption in "Return to Main Menu" "Connect to a Database"
	do 
		case $returnOption in 
	
			"Return to Main Menu") main_menu; 
				 				;; 
			"Connect to a Database") connectToDatabase;
			;;
			*) echo " you entered invaild option, please try again";
			   echo "========================================================";

					listDatabase ; 
					;; 
		esac
	done
fi
}
#====================================================================
function connectToDatabase {
	 
if [[ ! -d ~/database ]]	
	then 	
		echo " there are no databases created, please create one first";
		echo "========================================================";
		main_menu; 
	else 
		cd ~/database ; 
		echo "========================================================";
		echo "Available Databases:"
		echo "--------------------------------------------------------";

		ls . ; 
		echo "--------------------------------------------------------";

echo "please enter database name to connect to"; 
echo "========================================================";

read selectedDatabase ; 
if [[ ! -d ~/database/$selectedDatabase ]]
then 
echo "there is no database with this name, please enter a vaild one";
connectToDatabase; 
else 
	cd ~/database/$selectedDatabase; 
fi 
echo "--------------------------------------------------------";
echo "you have selected: [$selectedDatabase] Database";
echo "--------------------------------------------------------";
echo "please choose an option to continue";
echo " "; 


function DatabaseOptions {
printf "          ==========================
	  =         options        =
	  ==========================
	  \n"; 

		select choice in "create a table" "list tables" "drop a table" "insert into table" "insert into table2" "insert into table3" "select from table" "delete from table" "update table" "Return to Main Menu" 
		do
		case $choice in 

				"create a table") createTable ; 
					break ;
					;;
				"list tables") listTables ; 
					break; 
					;; 
				"drop a table") dropTable ; 
					break;
					;; 
				"insert into table") insertIntoTable ; 
					break; 
					;;
				"insert into table2") insertIntoTable2 ; 
					break; 
					;;
				"insert into table3") insertIntoTable2 ; 
					break; 
					;;
				"select from table") selectFromTable ; 
					break; 
					;; 
				"delete from table") deleteFromTable ; 
					break; 
					;;
				"update table") updateTable ; 
					break; 
					;;
				"Return to Main Menu") main_menu; 
					break;
					;;
				*) echo "you have entered an invalid option"; 
					connectToDatabase; 
					break; 
					;;
		esac 
	done
	}
DatabaseOptions; 

fi;


}
#====================================================================
function dropDatabase {
		
		if [ ! -d ~/database ]
		then 
			echo "you don't have any databases. please create one first"; 
			main_menu; 
		else 
			cd ~/database ; 
			ls . ; 
			echo "enter database name to drop";
			read databaseToDrop;
			if [[ ! -d $databaseToDrop ]]
			then 
				echo "please enter vaild database name"; 
				dropDatabase;
			else 
				rm -r $databaseToDrop; 
				echo "database $databaseToDrop has been successfully deleted";

			fi
			
		fi; 


}
# ====================================================================
function createTable {
	echo "please enter table name "; 
	read tableName ; 
	touch $tableName ;
	echo "please enter columns names and seprate them by a space";
	read -a ArrayOfColumns ; 

	NumberOfColumns="${#ArrayOfColumns[@]}"; 

	typeset -a ArrayDataType[$NumberOfColumns]; 

	i=0
	while [[ $i -lt NumberOfColumns ]]
	do 
		echo "===============================================" ;
		echo "Choose datatype of the field [${ArrayOfColumns[$i]}]"; 
		echo "===============================================" ;
		select DataType in int string
		do 
			case $DataType in 
				
				int) ArrayDataType[$i]="int" ;
					break ; 
					;; 
				
				string) ArrayDataType[$i]="string" ;
				break ; 
				;; 

				*) echo "invalid datatype " ;
					continue ; 
					;; 
			esac 
		done
	i=$i+1 ; 
	done 

	function Primarykey {
			while [ true ]
			do 
				printf "your table columns are \n"; 
				echo "${ArrayOfColumns[@]}"; 
				printf "Enter Primary Key Column Index \n";
				echo "Hint: Primary Key  must be int"
				read PKey; 

				if [[ $PKey =~ ^[0-9]+$ ]]
				then 
					if [[ $PKey -lt NumberOfColumns ]]
					then 
					echo "The Index of your Primary Key Column is: $PKey" >> $tableName ; 
					break ; 
					fi 
				else 
					echo "Primary Key $PKey Column Does Not Exist, try again please"; 
					Primarykey; 
				fi 
			done
	}
	Primarykey; 

	 echo " " >> $tableName 
     echo "The data types of each column respectively " >> $tableName
	 echo "===============================================" >>$tableName;

     echo ${ArrayDataType[@]} >> $tableName 

	 echo "===============================================" >>$tableName;
     echo ${ArrayOfColumns[@]} >> $tableName ;   
	 echo "-----------------------------------------------" >>$tableName;

     printf "Table is created successfully \n";
		
			
	
	DatabaseOptions; 


}
# =======================================================

function listTables {
	echo "Available Tables: "
	ls . ;
	echo "================================"; 
	echo "please type in 1 to return to previous menu"; 
	select choice in 1 
	do
		case $choice in 
			1) DatabaseOptions ; 
				break; 
				;; 
			*) echo "you entered an invalid option, please try again"; 
				listTables; 
				break;
				;;
		esac 
	done


}

# =======================================================
function dropTable {
	ls . ; 
	echo " please enter table name to drop " ;
	read tableToDrop ; 
	if [[ -f $tableToDrop ]]
	then
		rm $tableToDrop ;
		echo "=========================";
		echo " $tableToDrop has been deleted successfully";

		DatabaseOptions; 
	else 
		echo "you entered invalid name , please choose vaild table name"; 
		dropTable; 
	fi 

}

# =======================================================

function insertIntoTable {
	ls . ;
	echo "please enter table name to insert into"; 
	read tableToInsert; 
	if [[ -f $tableToInsert ]]
	then 
		vim $tableToInsert ; 

		DatabaseOptions; 
	else 
		echo "you entered invalid name , please choose vaild table name"; 
		insertIntoTable; 
	fi

}
# =======================================================
function insertIntoTable2 {
	echo "this program is only capable of inserting 4 columns due to memory restrictions"
	ls . ; 

	echo "please enter table name to insert into"; 
	read tableToInsert; 
	if [[ -f $tableToInsert ]]
	then 
		echo  "please enter first column"
		read col1 
		echo  "please enter second column"
		read col2
		echo  "please enter third column"
		read col3 
		echo  "please enter fourth column"
		read col4
		
		echo "$col1 : $col2 : $col3 : $col4" >> $tableToInsert 
		DatabaseOptions; 
	else 
		echo "you entered invalid name , please choose vaild table name"; 
		insertIntoTable; 
	fi
	
	

}
# =======================================================

function insertIntoTable3 {
	ls . ; 

	echo "please enter table name to insert into"; 
	read tableToInsert; 
	if [[ -f $tableToInsert ]]
	then 
		head -8 $tableToInsert; 
		echo  "please enter values of columns"
		read -a columnsOfArray; 
		echo ${columnsOfArray[@]} >> $tableToInsert
		DatabaseOptions; 
	else 
		echo "you entered invalid name , please choose vaild table name"; 
		insertIntoTable; 
	fi
	
	

}
# =======================================================
function selectFromTable {
	ls . ;
	echo "please enter table name to select from"; 
	read tableToSelectFrom;
	if [[ -f $tableToSelectFrom ]]
	then 
		cat $tableToSelectFrom; 
		printf "============================= \n ";
		printf "please enter value to select \n"; 
		read wordToSelect; 
		printf "============================= \n ";

		echo "value selected is $wordToSelect";

		DatabaseOptions;
	else 
		echo "please enter a vaild table name"
		selectFromTable ; 
	fi 
	
}
# =======================================================
function deleteFromTable {
	ls . ;
	echo "please enter table name to delete from"; 
	read tableToDeleteFrom;
	if [[ -f $tableToDeleteFrom ]] 
	then 
		cat $tableToDeleteFrom; 
		printf "=============================\n";
		printf "please select record to delete by id \n"
		printf "please enter record to Delete \n"; 
		read rowToDelete; 
		sed -i "/$rowToDelete/d" $tableToDeleteFrom;  
		DatabaseOptions;

	else 
		echo "the table name is not correct, try again"
		deleteFromTable; 

	fi


}

# =======================================================
function updateTable {
	ls . ;
	echo "please enter table name to update "; 
	read tableToUpdate;
	if [[ -f $tableToUpdate ]]
	then 
		cat $tableToUpdate; 
		printf "=============================\n";
		echo "please type the value to update";
		read wordToUpdate ; 
		echo "please type the new value"; 
		read newWord; 
		sed -i "s/$wordToUpdate/$newWord/g" $tableToUpdate;
		DatabaseOptions;
	else 
		echo "the table name is not correct, try again please"
		updateTable;
	fi

}
# =======================================================
#  calling of main_menu to start the program 

function  main_menu {
	
	echo "                    Main Menu 
	===================================
	|	please select an option   |
	===================================
	
	"
	select opt in "Create New Database" "List Databases" "Connect to a database" "Drop a database" "Exit" 
	do 
		case $opt in
			"Create New Database")
				createDatabase;
				main_menu;
				break ;
				;;
			"List Databases")
				listDatabase;
				break ;
				;;
			"Connect to a database")
				connectToDatabase;
				break ;
				;;
			
			"Drop a database")
				dropDatabase;
				main_menu;
				break ;
				;;
			"Exit")
				exit  ; 
 				;;
			*) 
				echo "please enter a valid option" ; 
				main_menu ;  
		esac
	done 
	
};
main_menu;