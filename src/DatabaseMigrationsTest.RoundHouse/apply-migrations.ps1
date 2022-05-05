$conn = "Server=.\SQL2017;Database=Migrations_RoundHouse;Integrated Security=true"
$Files = "C:\source\repos\database-migrations-dotnet\src\DatabaseMigrationsTest.RoundHouse"
$CreateDB = $Files + "\CustomCreateDB.sql"
<#
$AlterDB = $Files + "\1 AlterDatabase"
$RunAfterCreate = $Files + "\2 RunAfterCreateDatabase"
$RunBeforeUp = $Files + "\3 RunBeforeUp"
$Up = $Files + "\4 Up"
$RunAfterUp = $Files + "\5 RunFirstAfterUp"
$Functions = $Files + "\6 Functions"
$Views = $Files + "\7 Views"
$Sprocs = $Files + "\8 StoredProcs"
$Indexes = $Files + "\9 Indexes"
$RunAfterAny = $Files + "\10 RunAfterOtherAnyTimeScripts"
$Perms = $Files + "\11 Permissions"
#>
$Version = $Files + "\Version\RoundhouseDBVersion.txt"
$Out = $Files + "\Output"
 
&C:\source\repos\database-migrations-dotnet\src\packages\roundhouse.0.8.6\bin\rh -c $conn -f $Files -cds $CreateDB -vf $Version -o $Out
<#-alterdatabasefolder $AlterDB 
-runaftercreatedatabasefolder $RunAfterCreate -runbeforeupfolder $RunBeforeUp -upfolder $Up 
-runfirstfolder $RunAfterUp -functionsfolder $Functions -viewsfolder $Views -sprocsfolder $Sprocs 
-indexesfolder $Indexes -runAfterOtherAnyTimeScriptsfolder $RunAfterAny -permissionsfolder $Perms #>