<?php 
// DB credentials.
define('DB_HOST','localhost');
define('DB_USER','root');
define('DB_PASS','');
define('DB_NAME','las_elms');

$sessionStartMonth 		= 7; /* July */
$sessionEndMonth 		= 6; /* June */

// Establish database connection.
$conn = mysqli_connect(DB_HOST, DB_USER, DB_PASS, DB_NAME);
if (!$conn) {
   die("sorry !connection is not successful");
}
else { 
    //echo "Connection Successful";
}
function mysqli_result($result = null, $row = 0, $field = 0)
{
	if (is_null($result) || !is_object($result)) {
		return;
	}
	$result->data_seek($row);
	$datarow = $result->fetch_array();

	return is_array($datarow) && array_key_exists($field, $datarow) ? $datarow[$field] : null;
}
try
{
    $dbh = new PDO("mysql:host=".DB_HOST.";dbname=".DB_NAME,DB_USER, DB_PASS,array(PDO::MYSQL_ATTR_INIT_COMMAND => "SET NAMES 'utf8'"));
}
catch (PDOException $e)
{
exit("Error: " . $e->getMessage());
}

$currentMonth 	= mysqli_result(mysqli_query($GLOBALS['conn'], "SELECT MONTH(CURDATE())"),0,0);
$currentYear    = mysqli_result(mysqli_query($GLOBALS['conn'], "SELECT YEAR(CURDATE())"),0,0);

if( $currentMonth >= $sessionStartMonth ){
	$lastYear = $currentYear;
} else {
	$lastYear = mysqli_result(mysqli_query($GLOBALS['conn'], "SELECT YEAR(DATE_SUB(CURDATE(), INTERVAL 1 YEAR))" ),0,0);
}
$currentSession = "{$lastYear}-{$currentYear}";

$sesStartDate       = mysqli_result(mysqli_query($conn, "SELECT DATE_SUB('$lastYear-$sessionStartMonth-01',INTERVAL DAYOFMONTH('$lastYear-$sessionStartMonth-01')-1 DAY) "),0,0);
$sesStartMomLastDate= mysqli_result(mysqli_query($conn, "SELECT LAST_DAY('{$sesStartDate}')"),0,0);
$sesEndDate         = mysqli_result(mysqli_query($GLOBALS['conn'], "SELECT LAST_DAY('{$currentYear}-{$sessionEndMonth}-01')" ),0,0);

/* Last Session Last Month Start and End Day date */
$lseslmnthstDate = mysqli_result(mysqli_query($GLOBALS['conn'], "SELECT DATE_SUB('{$sesStartDate}', INTERVAL 1 MONTH)" ),0,0);
$lseslmnthetDate = mysqli_result(mysqli_query($GLOBALS['conn'], "SELECT LAST_DAY('{$lseslmnthstDate}')" ),0,0);

/* Next Session First Month Start and end Day date */
$nsesfmnthstDate = mysqli_result(mysqli_query($GLOBALS['conn'], "SELECT DATE_ADD('{$sesEndDate}', INTERVAL 1 DAY)" ),0,0);
$nsesfmnthetDate = mysqli_result(mysqli_query($GLOBALS['conn'], "SELECT LAST_DAY('{$nsesfmnthstDate}')" ),0,0);

/* 01-04-2024 - 04-04-2024 */
$currSessQ      = "     AND 
                        ToDate BETWEEN '{$sesStartDate}' AND '{$sesEndDate}' 
                        AND FromDate BETWEEN '{$sesStartDate}' AND '{$sesEndDate}' 
                        ";

/* 30-06-2023 - 02-07-2023 Special Case 1 When Fromdate is from Last Session and From Todate is current session, Count Only Todate to last month end  */

$spclCurrSessQ1 = "     AND 
                        FromDate BETWEEN '{$lseslmnthstDate}' AND '{$lseslmnthetDate}'
                        AND ToDate BETWEEN '{$sesStartDate}' AND '{$sesStartMomLastDate}' 
                        ";
$dateDiffSessQ1  = " SUM(DATEDIFF(ToDate,'{$lseslmnthetDate}')) AS splcase1 ";

/* Special Case 2 30-03-2024 02-04-2025 When fromdate is from Current Session and To date is Next session, Count Only Fromdate to Month End  */
$nextYear        = $currYear-1;
$tempd           = mysqli_result(mysqli_query($conn, "SELECT DATE_SUB('{$currentYear}-{$sessionEndMonth}-01',INTERVAL DAYOFMONTH('{$currentYear}-{$sessionEndMonth}-01')-1 DAY) "),0,0);
$spclCurrSessQ2  = "    AND 
                        FromDate BETWEEN '{$tempd}' AND '{$sesEndDate}'
                        AND ToDate BETWEEN '{$nsesfmnthstDate}' AND '{$nsesfmnthetDate}' 
                        ";

$dateDiffSessQ2  = " SUM(DATEDIFF( '{$sesEndDate}',  FromDate)) AS splcase2 ";  
