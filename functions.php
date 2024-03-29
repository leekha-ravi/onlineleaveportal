<?php

function getLeavesAvailed($type='casual',$session='current')
{
    
    global $currSessQ, $spclCurrSessQ1, $spclCurrSessQ2, $dateDiffSessQ1, $dateDiffSessQ2;
    $currSessQuery = $currSessQ; 
    /* Default is Current Session  */
    if( $session=='alltime' ){
        $currSessQuery = '';
    }
    
    switch($type){
        case 'casual':
            $typeQ = "('casual','firsthalf','secondhalf')";
        break;
        case 'medical':
            $typeQ = "('medical')";
        break;
        case 'pleave':
            $typeQ = "('pleave')";
        break;
    }
    $casualLeaves = mysqli_query($GLOBALS['conn'],"SELECT id FROM tblleavetype WHERE inner_name IN {$typeQ}");
    if( mysqli_num_rows($casualLeaves) > 0 )
    {
        while($row=mysqli_fetch_assoc($casualLeaves)) 
        {
            $leavetypeids[] = $row['id'];
        }
        $leaveTypes = implode(',',$leavetypeids);
    }
    mysqli_free_result($casualLeaves);
    if( $leaveTypes!='' ){
       $spLeaves1 = $spLeaves2 = 0;
       //echo "SELECT SUM(nod) FROM tblleaves WHERE empid = {$_SESSION['eid']} AND LeaveType IN ($leaveTypes) {$currSessQuery} ";

       $total          = mysqli_result(mysqli_query($GLOBALS['conn'], "SELECT SUM(nod) FROM tblleaves WHERE empid = {$_SESSION['eid']} AND LeaveType IN ($leaveTypes) {$currSessQuery} "),0,0);
       if( $session!='alltime' ){
            $spLeaves1      = mysqli_result(mysqli_query($GLOBALS['conn'], "SELECT $dateDiffSessQ1 FROM tblleaves WHERE empid = {$_SESSION['eid']} AND LeaveType IN ($leaveTypes) {$spclCurrSessQ1} "),0,0);
            $spLeaves2      = mysqli_result(mysqli_query($GLOBALS['conn'], "SELECT $dateDiffSessQ2 FROM tblleaves WHERE empid = {$_SESSION['eid']} AND LeaveType IN ($leaveTypes) {$spclCurrSessQ2} "),0,0);
        
       }
      
       $totalLeaves =  $total + $spLeaves1 + $spLeaves2; 
      
       return $totalLeaves;
    }
}
function randomGenerator($digits = 10)
{
	srand((double) microtime() * 10000000);
	
	//Array of alphabets
	$input = array ("A", "B", "C", "D", "E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z");
	
	// init
	$random_generator = '';
	
	// Loop the number of times of required digits
	for ($i = 1; $i < $digits + 1; $i++) {
		// To decide the digit should be numeric or alphabet
		if (rand(1,2) == 1) {
			// Add one random alphabet 
			$rand_index = array_rand($input);

			// One char is added
			$random_generator .= $input[$rand_index];
		} else {
			// Add one numeric digit between 1 and 10
			// one number is added
			$random_generator .= rand(1,10);
		}
	}
	
	return $random_generator;
}
function getLeaveType($id, $type='name')
{
    if( empty($id) ){
        return;
    }
    $field = "LeaveType";
    if( $type=='innername' ){
        $field = "inner_name";
    }
    return mysqli_result(mysqli_query($GLOBALS['conn'], "SELECT {$field} FROM tblleavetype WHERE id = {$id}"),0,0);
}

?>